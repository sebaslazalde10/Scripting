;=================================================
; ByrneAutoBalloon.lsp
; Byrne México CAD Automation Library
;
; Version: AutoBalloon_v2.2 (Safety Stacking Engine)
;=================================================

(defun ByrneInsertBalloon (pt item offX offY / acad doc space landingPt pts arr ml cType mBlockName mBlock currentStyle)
    (vl-load-com)
    (setq acad (vlax-get-acad-object))
    (setq doc  (vla-get-ActiveDocument acad))
    (setq space (vla-get-PaperSpace doc))

    (setq landingPt (list (+ (car pt) offX) (+ (cadr pt) offY) (caddr pt)))
    (setq pts (append pt landingPt))

    (setq arr (vlax-make-safearray vlax-vbDouble (cons 0 (1- (length pts)))))
    (vlax-safearray-fill arr pts)

    (setq ml (vla-AddMLeader space arr 0))
    (setq currentStyle (getvar "CMLEADERSTYLE"))
    (vla-put-StyleName ml currentStyle)

    (setq cType (vla-get-ContentType ml))
    (if item
        (cond
            ((= cType 2) (vla-put-TextString ml (itoa item)))
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
    )
    (vla-Update ml)
)

(defun c:BYRNEAUTOBALLOON (/ doc viewportObj viewportEname vpId components project balloonData 
                             msPt dcsPt psPt item blockName totalY avgY sortedBalloons 
                             lastTopX lastTopY lastBotX lastBotY compX compY currentOffsetX currentOffsetY data)

    (vl-load-com)
    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            (setq vpId (cdr (assoc 69 (entget viewportEname))))
            (setq components (ByrneResolveComponents viewportEname))

            (setq project (ByrneGetProjectScan))
            (if (not project) (setq project (ByrneBuildProjectScan)))

            (if components
                (progn
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    (vla-put-MSpace doc :vlax-true)
                    (setvar "CVPORT" vpId)
                    
                    (setq balloonData nil totalY 0.0)
                    (foreach component components
                        (setq blockName (cdr (assoc 'blockName component)))
                        (setq msPt (cdr (assoc 'insertPoint component)))
                        (setq dcsPt (trans msPt 0 2))
                        (setq psPt (trans dcsPt 2 3))
                        (setq item (if project (ByrneGetGlobalItemNumber blockName project) nil))
                        (setq balloonData (cons (cons psPt item) balloonData))
                        (setq totalY (+ totalY (cadr psPt)))
                    )
                    (vla-put-MSpace doc :vlax-false)

                    (setq avgY (/ totalY (length balloonData)))
                    (setq sortedBalloons (vl-sort balloonData '(lambda (a b) (< (car (car a)) (car (car b))))))

                    ;; INICIALIZADORES CON MÁS AIRE: 0.12 base y 0.10 de salto
                    (setq lastTopX -999999.0 lastTopY 0.12
                          lastBotX -999999.0 lastBotY -0.12)

                    (foreach data sortedBalloons
                        (setq psPt (car data) item (cdr data) compX (car psPt) compY (cadr psPt))
                        (setq currentOffsetX 0.0) ;; Vertical estricta

                        (if (>= compY avgY)
                            (progn
                                ;; Aumentamos el umbral de detección (0.15) para que escalonen antes
                                (if (< (- compX lastTopX) 0.15)
                                    (setq currentOffsetY (+ lastTopY 0.10)) 
                                    (setq currentOffsetY 0.12) 
                                )
                                (setq lastTopX compX lastTopY currentOffsetY)
                            )
                            (progn
                                (if (< (- compX lastBotX) 0.15)
                                    (setq currentOffsetY (- lastBotY 0.10)) 
                                    (setq currentOffsetY -0.12) 
                                )
                                (setq lastBotX compX lastBotY currentOffsetY)
                            )
                        )
                        (ByrneInsertBalloon psPt item currentOffsetX currentOffsetY)
                    )
                    (vla-Regen doc 0)
                    (princ "\nProceso completado con stack de seguridad mejorado.")
                )
            )
        )
    )
    (princ)
)

;=================================================
; BalloonsUpAndDownByrne
; Distribución Zig-Zag para evitar colisiones
;=================================================

(defun BalloonsUpAndDownByrne (/ doc viewportObj viewportEname vpId components project balloonData 
                                 msPt dcsPt psPt item blockName sortedBalloons data compX toggle offset)

    (vl-load-com)
    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            (setq vpId (cdr (assoc 69 (entget viewportEname))))
            (setq components (ByrneResolveComponents viewportEname))

            ;; 1. Obtener BOM
            (setq project (ByrneGetProjectScan))
            (if (not project) (setq project (ByrneBuildProjectScan)))

            (if components
                (progn
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    
                    ;; 2. Traducción de coordenadas a PaperSpace
                    (vla-put-MSpace doc :vlax-true)
                    (setvar "CVPORT" vpId)
                    (setq balloonData nil)
                    
                    (foreach component components
                        (setq msPt (cdr (assoc 'insertPoint component)))
                        (setq dcsPt (trans msPt 0 2))
                        (setq psPt (trans dcsPt 2 3))
                        (setq item (if project (ByrneGetGlobalItemNumber (cdr (assoc 'blockName component)) project) nil))
                        (setq balloonData (cons (cons psPt item) balloonData))
                    )
                    (vla-put-MSpace doc :vlax-false)

                    ;; 3. Ordenar de izquierda a derecha
                    (setq sortedBalloons (vl-sort balloonData '(lambda (a b) (< (car (car a)) (car (car b))))))

                    ;; 4. Lógica de Zig-Zag
                    ;; toggle: 1 (Arriba), -1 (Abajo)
                    ;; offset: 0.12 (distancia vertical)
                    (setq toggle 1
                          offset 0.12
                          lastX -999.0)

                    (foreach data sortedBalloons
                        (setq psPt (car data)
                              item (cdr data)
                              compX (car psPt))

                        ;; Si la distancia horizontal es menor a 0.15 (umbral de colisión), hacemos Zig-Zag
                        (if (< (- compX lastX) 0.15)
                            (progn
                                (setq currentOffsetY (* toggle offset))
                                (setq toggle (* toggle -1)) ;; Invertimos para el siguiente
                            )
                            ;; Si no hay colisión, reset al estándar (Arriba)
                            (progn
                                (setq currentOffsetY offset)
                                (setq toggle -1) ;; El siguiente debería ir abajo si está cerca
                            )
                        )

                        ;; Dibujar
                        (ByrneInsertBalloon psPt item 0.0 currentOffsetY)
                        
                        (setq lastX compX)
                    )
                    (vla-Regen doc 0)
                    (princ "\nDistribución Zig-Zag completada.")
                )
            )
        )
    )
    (princ)
)

; Alias para llamar al comando fácilmente
(defun c:UPANDOWN () (BalloonsUpAndDownByrne))


;=================================================
; BalloonsLeftAndRightByrne
; Distribución Izquierda-Derecha para arreglos verticales
;=================================================

(defun BalloonsLeftAndRightByrne (/ doc viewportObj viewportEname vpId components project balloonData 
                                   msPt dcsPt psPt item blockName sortedBalloons data compY toggle offset lastY currentOffsetX)

    (vl-load-com)
    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            (setq vpId (cdr (assoc 69 (entget viewportEname))))
            (setq components (ByrneResolveComponents viewportEname))

            ;; 1. Obtener BOM
            (setq project (ByrneGetProjectScan))
            (if (not project) (setq project (ByrneBuildProjectScan)))

            (if components
                (progn
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    
                    ;; 2. Traducción de coordenadas a PaperSpace
                    (vla-put-MSpace doc :vlax-true)
                    (setvar "CVPORT" vpId)
                    (setq balloonData nil)
                    
                    (foreach component components
                        (setq msPt (cdr (assoc 'insertPoint component)))
                        (setq dcsPt (trans msPt 0 2))
                        (setq psPt (trans dcsPt 2 3))
                        (setq item (if project (ByrneGetGlobalItemNumber (cdr (assoc 'blockName component)) project) nil))
                        (setq balloonData (cons (cons psPt item) balloonData))
                    )
                    (vla-put-MSpace doc :vlax-false)

                    ;; 3. Ordenar de arriba a abajo por coordenada Y (cadr)
                    (setq sortedBalloons (vl-sort balloonData '(lambda (a b) (> (cadr (car a)) (cadr (car b))))))

                    ;; 4. Lógica de Zig-Zag Horizontal
                    ;; toggle: 1 (Derecha), -1 (Izquierda)
                    ;; offset: 0.12 (distancia horizontal)
                    (setq toggle 1
                          offset 0.12
                          lastY -999.0)

                    (foreach data sortedBalloons
                        (setq psPt (car data)
                              item (cdr data)
                              compY (cadr psPt))

                        ;; Evaluar colisión vertical entre componentes cercanos
                        (if (< (abs (- compY lastY)) 0.15)
                            (progn
                                (setq currentOffsetX (* toggle offset))
                                (setq toggle (* toggle -1)) ;; Invertir lado
                            )
                            ;; Reset por defecto hacia la derecha (+ offset)
                            (progn
                                (setq currentOffsetX offset)
                                (setq toggle -1)
                            )
                        )

                        ;; Dibujar con offset únicamente en X
                        (ByrneInsertBalloon psPt item currentOffsetX 0.0)
                        
                        (setq lastY compY)
                    )
                    (vla-Regen doc 0)
                    (princ "\nDistribución Left-and-Right completada.")
                )
            )
        )
    )
    (princ)
)

; Alias para llamar al comando
(defun c:LEFTANDRIGHT () (BalloonsLeftAndRightByrne))