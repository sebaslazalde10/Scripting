;=================================================
; ByrneAutoBalloon.lsp
; Byrne México CAD Automation Library
;
; Version: AutoBalloon_v1.4 (Bulk Insert Loop)
;=================================================

;-------------------------------------------------
; ByrneInsertBalloon
;-------------------------------------------------
(defun ByrneInsertBalloon (pt item / acad doc space landingPt pts arr ml cType mBlockName mBlock)

    (vl-load-com)

    (setq acad (vlax-get-acad-object))
    (setq doc  (vla-get-ActiveDocument acad))
    (setq space (vla-get-PaperSpace doc))

    ;; Calcular el punto de destino (landing) aplicando el offset estático temporal
    (setq landingPt (list (+ (car pt) 20.0) (+ (cadr pt) 20.0) (caddr pt)))
    
    (setq pts (append pt landingPt))

    ;; Crear el SAFEARRAY
    (setq arr (vlax-make-safearray vlax-vbDouble (cons 0 (1- (length pts)))))
    (vlax-safearray-fill arr pts)

    ;; Insertar el MLeader en el Layout
    (setq ml (vla-AddMLeader space arr 0))

    ;; Identificar el tipo de contenido del estilo de MLeader actual
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
                
                ;; Buscar la definición del atributo dentro del bloque del globo
                (vlax-for obj mBlock
                    (if (= (vla-get-ObjectName obj) "AcDbAttributeDefinition")
                        (vla-SetBlockAttributeValue ml (vla-get-ObjectID obj) (itoa item))
                    )
                )
            )
        )
        (princ "\n[Advertencia] Ítem nulo detectado. Se creó un globo vacío.")
    )

    (vla-Regen doc 0)
)

;-------------------------------------------------
; BYRNEAUTOBALLOON
;-------------------------------------------------
(defun c:BYRNEAUTOBALLOON (/ viewportObj viewportEname components project blockName item)

    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            (setq components (ByrneResolveComponents viewportEname))

            ;; Intentar obtener el escaneo global del proyecto (BOM general)
            (setq project (ByrneGetProjectScan))
            
            (if (not project)
                (princ "\nNo hay escaneo de proyecto global en memoria. Los ítems podrían salir vacíos.")
            )

            (if components
                (progn
                    ;; =======================================================
                    ;; EL CAMBIO REAL: Bucle que recorre toda la lista
                    ;; =======================================================
                    (foreach component components
                        (setq blockName (cdr (assoc 'blockName component)))
                        
                        ;; Buscar el índice correspondiente en el BOM global
                        (setq item (if project (ByrneGetGlobalItemNumber blockName project) nil))

                        ;; Insertar globo con su coordenada de inserción física
                        (ByrneInsertBalloon (cdr (assoc 'insertPoint component)) item)
                    )
                    
                    (princ (strcat "\nProceso completado. Se insertaron " (itoa (length components)) " globos."))
                )
                (princ "\nNo se encontraron componentes de Byrne dentro de este viewport.")
            )
        )
    )
    (princ)
)