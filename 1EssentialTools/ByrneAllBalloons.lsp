;=================================================
; ALLBALLOONS.lsp
; Byrne México CAD Automation Library
;
; Itera todos los layouts del proyecto (cada uno con
; UN solo viewport) y aplica, en cada uno, la misma
; logica que:
;   - c:UPANDOWN        -> ALLUP
;   - c:LEFTANDRIGHT     -> ALLLR
;   - c:BYRNEAUTOBALLOON -> ALLAB
;
; No modifica ByrneAutoBalloon.lsp: los comandos
; originales (UPANDOWN, LEFTANDRIGHT, BYRNEAUTOBALLOON)
; siguen funcionando igual, con seleccion manual del
; viewport.
;
; Requiere que ByrneAutoBalloon.lsp y
; ByrneInternalBOM.lsp ya esten cargados (usa
; ByrneInsertBalloon, ByrneResolveComponents,
; ByrneGetProjectScan, ByrneBuildProjectScan,
; ByrneGetGlobalItemNumber).
;=================================================

(vl-load-com)

;=================================================
; ByrneGetLayoutViewport
; (misma que en GENBOMS.lsp; se redefine aqui para
; que este archivo funcione de forma independiente)
;
; Encuentra automaticamente el (unico) viewport real
; de un layout, ignorando el viewport de sistema (id 1)
;=================================================
(defun ByrneGetLayoutViewport (layoutName / ss i ent vpId vpObj)
    (setq vpObj nil)
    (setq ss (ssget "X" (list '(0 . "VIEWPORT") (cons 410 layoutName))))
    (if ss
        (progn
            (setq i 0)
            (while (and (< i (sslength ss)) (not vpObj))
                (setq ent (ssname ss i))
                (setq vpId (cdr (assoc 69 (entget ent))))
                (if (/= vpId 1)
                    (setq vpObj (vlax-ename->vla-object ent))
                )
                (setq i (1+ i))
            )
        )
    )
    vpObj
)

;=================================================
; ByrneRunOverAllLayouts
; Motor generico: activa cada layout (menos Model),
; ubica su viewport y llama a la funcion "coreFn"
; pasandole ese viewport. cmdName es solo para los
; mensajes en pantalla.
;=================================================
(defun ByrneRunOverAllLayouts (coreFn cmdName / acadObj doc layouts lay layoutName viewportObj)
    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))
    (setq layouts (vla-get-Layouts doc))

    (vlax-for lay layouts
        (setq layoutName (vla-get-Name lay))
        (if (/= (strcase layoutName) "MODEL")
            (progn
                (vla-put-ActiveLayout doc lay)
                (setq viewportObj (ByrneGetLayoutViewport layoutName))

                (if viewportObj
                    (progn
                        (apply coreFn (list viewportObj))
                        (princ (strcat "\n" cmdName ": completado en layout \"" layoutName "\"."))
                    )
                    (princ (strcat "\n" cmdName ": no se encontro viewport en el layout \"" layoutName "\"."))
                )
            )
        )
    )
    (princ)
)

;=================================================
; ByrneBalloonsUpAndDownForViewport
; (misma logica que BalloonsUpAndDownByrne, pero
; recibe el viewport en vez de pedirlo por pantalla)
;=================================================
(defun ByrneBalloonsUpAndDownForViewport (viewportObj / doc viewportEname vpId components project
                                           balloonData msPt dcsPt psPt item sortedBalloons
                                           data compX toggle offset lastX currentOffsetY)

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
            (setq balloonData nil)

            (foreach component components
                (setq msPt (cdr (assoc 'insertPoint component)))
                (setq dcsPt (trans msPt 0 2))
                (setq psPt (trans dcsPt 2 3))
                (setq item (if project (ByrneGetGlobalItemNumber (cdr (assoc 'blockName component)) project) nil))
                (setq balloonData (cons (cons psPt item) balloonData))
            )
            (vla-put-MSpace doc :vlax-false)

            (setq sortedBalloons (vl-sort balloonData '(lambda (a b) (< (car (car a)) (car (car b))))))

            (setq toggle 1
                  offset 0.12
                  lastX -999.0)

            (foreach data sortedBalloons
                (setq psPt (car data)
                      item (cdr data)
                      compX (car psPt))

                (if (< (- compX lastX) 0.15)
                    (progn
                        (setq currentOffsetY (* toggle offset))
                        (setq toggle (* toggle -1))
                    )
                    (progn
                        (setq currentOffsetY offset)
                        (setq toggle -1)
                    )
                )

                (ByrneInsertBalloon psPt item 0.0 currentOffsetY)

                (setq lastX compX)
            )
            (vla-Regen doc 0)
        )
    )
)

;=================================================
; ByrneBalloonsLeftAndRightForViewport
; (misma logica que BalloonsLeftAndRightByrne, pero
; recibe el viewport en vez de pedirlo por pantalla)
;=================================================
(defun ByrneBalloonsLeftAndRightForViewport (viewportObj / doc viewportEname vpId components project
                                              balloonData msPt dcsPt psPt item sortedBalloons
                                              data compY toggle offset lastY currentOffsetX)

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
            (setq balloonData nil)

            (foreach component components
                (setq msPt (cdr (assoc 'insertPoint component)))
                (setq dcsPt (trans msPt 0 2))
                (setq psPt (trans dcsPt 2 3))
                (setq item (if project (ByrneGetGlobalItemNumber (cdr (assoc 'blockName component)) project) nil))
                (setq balloonData (cons (cons psPt item) balloonData))
            )
            (vla-put-MSpace doc :vlax-false)

            (setq sortedBalloons (vl-sort balloonData '(lambda (a b) (> (cadr (car a)) (cadr (car b))))))

            (setq toggle 1
                  offset 0.12
                  lastY -999.0)

            (foreach data sortedBalloons
                (setq psPt (car data)
                      item (cdr data)
                      compY (cadr psPt))

                (if (< (abs (- compY lastY)) 0.15)
                    (progn
                        (setq currentOffsetX (* toggle offset))
                        (setq toggle (* toggle -1))
                    )
                    (progn
                        (setq currentOffsetX offset)
                        (setq toggle -1)
                    )
                )

                (ByrneInsertBalloon psPt item currentOffsetX 0.0)

                (setq lastY compY)
            )
            (vla-Regen doc 0)
        )
    )
)

;=================================================
; ByrneAutoBalloonForViewport
; (misma logica que c:BYRNEAUTOBALLOON, pero recibe
; el viewport en vez de pedirlo por pantalla)
;=================================================
(defun ByrneAutoBalloonForViewport (viewportObj / doc viewportEname vpId components project
                                     balloonData msPt dcsPt psPt item blockName totalY avgY
                                     sortedBalloons lastTopX lastTopY lastBotX lastBotY
                                     compX compY currentOffsetX currentOffsetY data)

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

            (setq lastTopX -999999.0 lastTopY 0.12
                  lastBotX -999999.0 lastBotY -0.12)

            (foreach data sortedBalloons
                (setq psPt (car data) item (cdr data) compX (car psPt) compY (cadr psPt))
                (setq currentOffsetX 0.0)

                (if (>= compY avgY)
                    (progn
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
        )
    )
)

;=================================================
; COMANDOS: ALLUP / ALLLR / ALLAB
;=================================================

(defun c:ALLUP ()
    (ByrneRunOverAllLayouts 'ByrneBalloonsUpAndDownForViewport "ALLUP")
)

(defun c:ALLLR ()
    (ByrneRunOverAllLayouts 'ByrneBalloonsLeftAndRightForViewport "ALLLR")
)

(defun c:ALLAB ()
    (ByrneRunOverAllLayouts 'ByrneAutoBalloonForViewport "ALLAB")
)

(princ "\nALLBALLOONS.lsp cargado. Comandos disponibles: ALLUP, ALLLR, ALLAB.")
(princ)