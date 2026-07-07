(defun c:TESTML (/ acad doc ps arr ml)

    (vl-load-com)

    (setq acad (vlax-get-acad-object))
    (setq doc  (vla-get-ActiveDocument acad))

    (setq ps (vla-get-PaperSpace doc))

    ;; Flecha (0,0,0)
    ;; Landing (20,20,0)

    (setq arr
        (vlax-make-safearray
            vlax-vbDouble
            '(0 . 5)
        )
    )

    (vlax-safearray-fill
        arr
        '(0.0 0.0 0.0
          20.0 20.0 0.0)
    )

    (setq ml

        (vla-AddMLeader
            ps
            arr
            0
        )

    )

    (vla-put-TextString ml "123")

    (princ)

)