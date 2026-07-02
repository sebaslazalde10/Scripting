;=================================================
; ByrnePrettyTable.lsp
; Byrne México CAD Automation Library
;
; Version: PrettyTable_v1.0
;
; Creates a formatted BOM table from the
; Byrne Internal BOM.
;=================================================

(vl-load-com)

;=================================================
; BYRNEPRETTYTABLE
;=================================================

(defun c:BYRNEPRETTYTABLE
       (/ doc
          currentSpace
          insPt
          rows
          cols
          row
          tableObj
          viewportObj
          viewportEname
          components
          internalBOM
          bomEntry)

    ;;=========================================
    ;; BUILD INTERNAL BOM
    ;;=========================================

    (setq viewportObj
          (ByrneGetViewport))

    (if (null viewportObj)

        (progn
            (princ "\nNo viewport selected.")
            (princ)
        )

        (progn

            (setq viewportEname
                  (vlax-vla-object->ename viewportObj))

            (setq components
                  (ByrneResolveComponents viewportEname))

            (setq internalBOM
                  (ByrneBuildInternalBOM components))

            (if (null internalBOM)

                (progn
                    (princ "\nNo Byrne components found inside viewport.")
                    (princ)
                )

                (progn

                    ;;=========================================
                    ;; INSERTION POINT
                    ;;=========================================

                    (setq insPt
                          (getpoint "\nSelect insertion point for BOM table: "))

                    ;;=========================================
                    ;; TABLE SETTINGS
                    ;;=========================================

                    (setq rows (+ (length internalBOM) 2))
                    (setq cols 4)

                    (setq doc
                          (vla-get-ActiveDocument
                              (vlax-get-acad-object)))

                    (setq currentSpace
                          (if (= (getvar "CVPORT") 1)
                              (vla-get-PaperSpace doc)
                              (vla-get-ModelSpace doc)))

                    (setq tableObj
                          (vla-AddTable
                              currentSpace
                              (vlax-3d-point insPt)
                              rows
                              cols
                              0.12
                              1.0))

                    ;;=========================================
                    ;; REMOVE TITLE ROW
                    ;;=========================================

                    (vla-DeleteRows tableObj 0 1)

                    ;;=========================================
                    ;; TEXT HEIGHT
                    ;;=========================================

                    (vla-SetTextHeight tableObj 1 0.06)
                    (vla-SetTextHeight tableObj 2 0.06)
                    (vla-SetTextHeight tableObj 4 0.06)

                    ;;=========================================
                    ;; COLUMN WIDTHS
                    ;;=========================================

                    (vla-SetColumnWidth tableObj 0 0.35)
                    (vla-SetColumnWidth tableObj 1 1.25)
                    (vla-SetColumnWidth tableObj 2 1.25)
                    (vla-SetColumnWidth tableObj 3 0.50)

                    ;;=========================================
                    ;; HEADERS
                    ;;=========================================

                    (vla-SetText tableObj 0 0 "ITEM")
                    (vla-SetText tableObj 0 1 "SYMBOLOGY")
                    (vla-SetText tableObj 0 2 "DESCRIPTION")
                    (vla-SetText tableObj 0 3 "QTY")

                    ;;=========================================
                    ;; DATA
                    ;;=========================================

                    (setq row 1)

                    (foreach bomEntry internalBOM

                        (vla-SetText
                            tableObj
                            row
                            0
                            (itoa
                                (cdr (assoc 'item bomEntry))
                            )
                        )

                        ;; Por ahora la dejamos vacía.
                        ;; Más adelante aquí insertaremos
                        ;; el símbolo dinámicamente.
                        (vla-SetText
                            tableObj
                            row
                            1
                            ""
                        )

                        (vla-SetText
                            tableObj
                            row
                            2
                            (cdr
                                (assoc 'description bomEntry))
                        )

                        (vla-SetText
                            tableObj
                            row
                            3
                            (itoa
                                (cdr
                                    (assoc 'qty bomEntry))
                            )
                        )

                        (setq row (1+ row))

                    )

                    (princ "\nByrne Pretty Table created successfully.")

                )

            )

        )

    )

    (princ)

)