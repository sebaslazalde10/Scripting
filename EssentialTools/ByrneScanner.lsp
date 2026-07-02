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

            (setq viewportObj (vlax-ename->vla-object ent))

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
; TESTVIEWPORTSCAN
;=================================================

(defun c:TESTVIEWPORTSCAN (/ vp)

    (setq vp (ByrneGetViewport))

    (if vp

        (progn

            (princ "\nViewport selected successfully.")

            (princ
                (strcat
                    "\nviewportObject Name: "
                    (vla-get-ObjectName vp)
                )
            )

        )

    )

    (princ)

)