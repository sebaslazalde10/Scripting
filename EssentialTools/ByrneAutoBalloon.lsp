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