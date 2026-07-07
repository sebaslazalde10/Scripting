;=================================================
; ByrneAutoBalloon.lsp
; Byrne México CAD Automation Library
;
; Version: AutoBalloon_v1.6 (Coordinate & BOM Fix)
;=================================================

;-------------------------------------------------
; ByrneInsertBalloon
;-------------------------------------------------
(defun ByrneInsertBalloon (pt item / acad doc space landingPt pts arr ml cType mBlockName mBlock currentStyle)

    (vl-load-com)

    (setq acad (vlax-get-acad-object))
    (setq doc  (vla-get-ActiveDocument acad))
    (setq space (vla-get-PaperSpace doc))

    ;; Offset balanceado de 15 unidades en X e Y (Ideal para Layouts Métricos)
    (setq landingPt (list (+ (car pt) 0.05) (+ (cadr pt) 0.05) (caddr pt)))
    (setq pts (append pt landingPt))

    ;; Crear el SAFEARRAY para el MLeader
    (setq arr (vlax-make-safearray vlax-vbDouble (cons 0 (1- (length pts)))))
    (vlax-safearray-fill arr pts)

    ;; Insertar el MLeader en el Layout
    (setq ml (vla-AddMLeader space arr 0))

    ;; DINÁMICO: Forzar el estilo exacto seleccionado por el usuario en la interfaz
    (setq currentStyle (getvar "CMLEADERSTYLE"))
    (vla-put-StyleName ml currentStyle)

    ;; Identificar si el estilo usa Texto o Bloque (como Standard Metric 2)
    (setq cType (vla-get-ContentType ml))

    (if item
        (cond
            ;; Si es MText (Valor = 2)
            ((= cType 2)
                (vla-put-TextString ml (itoa item))
            )
            ;; Si es un Bloque (Valor = 1)
            ((= cType 1)
                (setq mBlockName (vla-get-ContentBlockName ml))
                (setq mBlock (vla-Item (vla-get-Blocks doc) mBlockName))
                
                (vlax-for obj mBlock
                    (if (= (vla-get-ObjectName obj) "AcDbAttributeDefinition")
                        (vla-SetBlockAttributeValue ml (vla-get-ObjectID obj) (itoa item))
                    )
                )
            )
        )
        ;; Control de fallos: Si el ítem no se localiza en el BOM, se marca para revisión
        (cond
            ((= cType 2) (vla-put-TextString ml "?"))
            ((= cType 1)
                (setq mBlockName (vla-get-ContentBlockName ml))
                (setq mBlock (vla-Item (vla-get-Blocks doc) mBlockName))
                (vlax-for obj mBlock
                    (if (= (vla-get-ObjectName obj) "AcDbAttributeDefinition")
                        (vla-SetBlockAttributeValue ml (vla-get-ObjectID obj) "?")
                    )
                )
            )
        )
    )

    (vla-Update ml)
)

;-------------------------------------------------
; BYRNEAUTOBALLOON
;-------------------------------------------------
(defun c:BYRNEAUTOBALLOON (/ doc viewportObj viewportEname vpId components project balloonData msPt dcsPt psPt item blockName data)

    (vl-load-com)
    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            
            ;; 1. Extraer el ID único del Viewport desde sus datos DXF (Grupo 69)
            (setq vpId (cdr (assoc 69 (entget viewportEname))))

            ;; 2. Resolver los componentes visuales de la ventana
            (setq components (ByrneResolveComponents viewportEname))

            ;; 3. AUTO-BOM: Si la base de datos global está vacía, se calcula en automático
            (setq project (ByrneGetProjectScan))
            (if (not project)
                (progn
                    (princ "\n[BOM] Inicializando escaneo global del proyecto en memoria...")
                    (setq project (ByrneBuildProjectScan))
                )
            )

            (if components
                (progn
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    
                    ;; =======================================================
                    ;; ENTORNO MATRICIAL TRIDIMENSIONAL
                    ;; =======================================================
                    ;; Activamos el modelo dentro del Viewport una sola vez para traducir coordenadas
                    (vla-put-MSpace doc :vlax-true)
                    (setvar "CVPORT" vpId)
                    
                    (setq balloonData nil)
                    (foreach component components
                        (setq blockName (cdr (assoc 'blockName component)))
                        (setq msPt (cdr (assoc 'insertPoint component)))
                        
                        ;; Paso 1: De Model Space WCS (0) a la vista de pantalla del Viewport DCS (2)
                        (setq dcsPt (trans msPt 0 2))
                        ;; Paso 2: De la pantalla DCS (2) al plano físico de la hoja del Layout PSDCS (3)
                        (setq psPt (trans dcsPt 2 3))
                        
                        (setq item (if project (ByrneGetGlobalItemNumber blockName project) nil))
                        
                        ;; Guardamos el par mapeado (PuntoPapel . NumeroItem)
                        (setq balloonData (cons (cons psPt item) balloonData))
                    )
                    
                    ;; Regresamos al Layout de forma segura e inmediata para no interferir con la interfaz
                    (vla-put-MSpace doc :vlax-false)
                    ;; =======================================================

                    ;; 4. Inyección masiva de globos directamente sobre la hoja
                    (foreach data (reverse balloonData)
                        (ByrneInsertBalloon (car data) (cdr data))
                    )
                    
                    (vla-Regen doc 0)
                    (princ (strcat "\nProceso completado. Se insertaron " (itoa (length components)) " globos en el Layout."))
                )
                (princ "\nNo se encontraron componentes de Byrne dentro de este viewport.")
            )
        )
    )
    (princ)
)