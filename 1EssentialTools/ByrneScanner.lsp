;=================================================
; ByrneScanner.lsp
; Byrne México CAD Automation Library
;
; Version: Scanner_v1.0
;
; Functions:
;
; - ByrneGetViewportExtents
; - ByrnePointInsideWindow
; - ByrneGetInsertionPoint
; - ByrneScanViewport
; - TESTVIEWPORTSCAN
;=================================================

(vl-load-com)

;=================================================
; ByrneGetViewport
;
; Permite seleccionar un viewport en Paper Space.
; Devuelve el viewportObjeto VLA del viewport.
;=================================================

(defun ByrneGetViewport (/ ent viewportObj)

    (setq ent (car (entsel "\nSelect viewport: ")))

    (if ent
        (progn

            (setq viewportObj
                  (vlax-ename->vla-object ent)
            )

            (if (= (vla-get-ObjectName viewportObj) "AcDbViewport")

                viewportObj

                (progn
                    (princ "\nSelected object is not a viewport.")
                    nil
                )

            )

        )

    )

)

;=================================================
; DEBUG COMMANDS
; Remove before production release.
;=================================================
;=================================================
; TESTVIEWPORTSCAN
;=================================================

(defun c:TESTVIEWPORTSCAN (/ vp)

    (setq vp (ByrneGetViewport))

    (if vp

        (progn

    (princ "\nViewport selected successfully.")

    (ByrneInspectViewport vp)

    )

    (princ)

)
)

;=================================================
; ByrneInspectViewport
;
; Prints the most important viewport properties.
;=================================================

(defun ByrneInspectViewport (viewportObj / center)

    (princ "\n----------------------------------------")

    (princ
        (strcat
            "\nObjectName: "
            (vla-get-ObjectName viewportObj)
        )
    )

    (princ
        (strcat
            "\nWidth: "
            (rtos (vla-get-Width viewportObj) 2 4)
        )
    )

    (princ
        (strcat
            "\nHeight: "
            (rtos (vla-get-Height viewportObj) 2 4)
        )
    )

    (princ
        (strcat
            "\nCustom Scale: "
            (rtos (vla-get-CustomScale viewportObj) 2 6)
        )
    )

    (setq center (vlax-get viewportObj 'Center))

    (princ
        (strcat
            "\nViewport Center (Paper): "
            (vl-princ-to-string center)
        )
    )

    (princ "\n----------------------------------------")

)


;=================================================
; DEBUG COMMANDS
; Remove before production release.
;=================================================
(defun c:TESTVPDUMP (/ vp)

    (setq vp (ByrneGetViewport))

    (if vp
        (vlax-dump-object vp T)
    )

    (princ)
)


;=================================================
; DEBUG COMMANDS
; Remove before production release.
;=================================================
(defun c:TESTVPDXF ()
    (setq e (car (entsel "\nSelect viewport: ")))
    (print (entget e))
    (princ)
)

(defun ByrneGetViewportExtents (viewportEname
                                / dxfData
                                  paperWidth
                                  paperHeight
                                  modelCenter
                                  modelHeight
                                  aspectRatio
                                  modelWidth
                                  xmin
                                  xmax
                                  ymin
                                  ymax)

    (setq dxfData
          (entget viewportEname))

    (setq paperWidth
          (cdr (assoc 40 dxfData)))

    (setq paperHeight
          (cdr (assoc 41 dxfData)))

    (setq modelCenter
          (cdr (assoc 12 dxfData)))

    (setq modelHeight
          (cdr (assoc 45 dxfData)))

    (setq aspectRatio
          (/ paperWidth paperHeight))

    (setq modelWidth
          (* modelHeight aspectRatio))

    (setq xmin
          (- (car modelCenter)
             (/ modelWidth 2.0)))

    (setq xmax
          (+ (car modelCenter)
             (/ modelWidth 2.0)))

    (setq ymin
          (- (cadr modelCenter)
             (/ modelHeight 2.0)))

    (setq ymax
          (+ (cadr modelCenter)
             (/ modelHeight 2.0)))

    (list xmin ymin xmax ymax)

)

;=================================================
; ByrneGetInsertionPoint
;
; Returns the insertion point of a block reference.
;=================================================

(defun ByrneGetInsertionPoint (blockEname / dxfData)

    (setq dxfData (entget blockEname))

    (cdr (assoc 10 dxfData))

)

;=================================================
; ByrnePointInsideWindow
;
; Returns T if the point is inside the extents.
;=================================================

(defun ByrnePointInsideWindow (point extents
                                / xmin ymin xmax ymax)

    (setq xmin (nth 0 extents))
    (setq ymin (nth 1 extents))
    (setq xmax (nth 2 extents))
    (setq ymax (nth 3 extents))

    (and
        (>= (car point) xmin)
        (<= (car point) xmax)
        (>= (cadr point) ymin)
        (<= (cadr point) ymax)
    )

)

;=================================================
; ByrneScanViewport
;
; Returns a list of INSERT entities inside the viewport.
;=================================================

(defun ByrneScanViewport (viewportEname
                          / extents
                            ss
                            i
                            blockEname
                            blockData
                            insertPoint
                            result)

    (setq result nil)

    (setq extents
          (ByrneGetViewportExtents viewportEname))

    (setq ss
          (ssget "_X" '((0 . "INSERT"))))

    (if ss

        (progn

            (setq i 0)

            (while (< i (sslength ss))

                (setq blockEname
                      (ssname ss i))
              
                (setq blockData
                      (entget blockEname))

                (setq insertPoint
                      (ByrneGetInsertionPoint blockEname))

                (if (and

        (/= (cdr (assoc 67 blockData)) 1)

        (ByrnePointInsideWindow
            insertPoint
            extents
        )

    )

    (setq result
          (cons blockEname result))

)

                (setq i (1+ i))

            )

        )

    )

    (reverse result)

)

;=================================================
; DEBUG COMMAND
;=================================================

(defun c:BYRNESCAN (/ viewportObj viewportEname blocks blockData)

    (setq viewportObj
          (ByrneGetViewport))

    (if viewportObj

        (progn

            (setq viewportEname
                  (vlax-vla-object->ename viewportObj))

            (setq blocks
                  (ByrneScanViewport viewportEname))

            (princ
                (strcat
                    "\nBlocks found: "
                    (itoa (length blocks))
                )
            )

            (foreach block blocks

    (setq blockData (entget block))

    (princ
        (strcat
            "\n--------------------------------"
            "\nName: "
            (cdr (assoc 2 blockData))
            "\nHandle: "
            (cdr (assoc 5 blockData))
            "\nInsertion: "
            (vl-princ-to-string (cdr (assoc 10 blockData)))
        )
    )

    ;; Mostrar si está en Model o Paper Space
    (if (= (cdr (assoc 67 blockData)) 1)

        (princ "\nSpace: PAPER")

        (princ "\nSpace: MODEL")

    )

)

        )

    )

    (princ)

)


;=================================================
; DEBUG COMMANDS
; Remove before production release.
;=================================================
(defun c:TESTEXTENTS (/ viewportObj viewportEname extents)

    (setq viewportObj
          (ByrneGetViewport))

    (if viewportObj

        (progn

            (setq viewportEname
                  (vlax-vla-object->ename viewportObj))

            (setq extents
                  (ByrneGetViewportExtents viewportEname))

            (print extents)

        )

    )

    (princ)

)


;=================================================
; ByrneScanModel
;
; Scans the complete Model Space and returns every
; INSERT entity found.
;
; Returns:
;   List of block enames.
;=================================================

(defun ByrneScanModel (/ ss i result blockEname blockData)

    (setq result nil)

    (setq ss
          (ssget "_X" '((0 . "INSERT")))
    )

    (if ss

        (progn

            (setq i 0)

            (while (< i (sslength ss))

                (setq blockEname
                      (ssname ss i))

                (setq blockData
                      (entget blockEname))

                ;; Ignore Paper Space inserts
                (if (/= (cdr (assoc 67 blockData)) 1)

                    (setq result
                          (cons blockEname result))
                )

                (setq i (1+ i))

            )

        )

    )

    (reverse result)

)

;=================================================
; ByrneResolveModel
;
; Resolves every Byrne component found in the
; complete Model Space.
;
; Returns:
;   List of resolved Byrne components.
;=================================================



