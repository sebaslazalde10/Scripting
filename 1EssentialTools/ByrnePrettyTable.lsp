;=================================================
; ByrneCorrectTable.lsp
; Byrne México CAD Automation Library
;
; Version: CorrectTable_v5.0 (AutoFit Engine Locked)
;=================================================

(vl-load-com)

;=================================================
; ByrneGetOrLoadBlockID
;=================================================
(defun ByrneGetOrLoadBlockID (blkName / acad doc blocks blk blkID blockPath tempRef ms)
    (setq acad (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acad))
    (setq blocks (vla-get-Blocks doc))
    (setq blkID nil)
    
    (if (not (vl-catch-all-error-p (setq blk (vl-catch-all-apply 'vla-Item (list blocks blkName)))))
        (setq blkID (vla-get-ObjectID blk))
        (progn
            (setq blockPath (findfile (strcat blkName ".dwg")))
            (if blockPath
                (progn
                    (setq ms (vla-get-ModelSpace doc))
                    (if (not (vl-catch-all-error-p (setq tempRef (vl-catch-all-apply 'vla-InsertBlock (list ms (vlax-3d-point 0 0 0) blockPath 1.0 1.0 1.0 0.0)))))
                        (progn
                            (vl-catch-all-apply 'vla-Delete (list tempRef))
                            (if (not (vl-catch-all-error-p (setq blk (vl-catch-all-apply 'vla-Item (list blocks blkName)))))
                                (setq blkID (vla-get-ObjectID blk))
                            )
                        )
                    )
                )
            )
        )
    )
    blkID
)

;=================================================
; BYRNECORRECTTABLE
;=================================================

(defun c:BYRNECORRECTTABLE
       (/ doc currentSpace insPt rows cols row col tableObj
          viewportObj viewportEname components internalBOM
          bomEntry rawBlockName catEntry symbolBlock blkID
          cwItem cwSymbol cwDesc cwQty
          rHeight textHeight)

    ;; =======================================================
    ;; CONFIGURACIÓN RÍGIDA (En Centímetros)
    ;; Ancho total = ~11.5 cm (Perfecto para hoja de 21.5 cm)
    ;; =======================================================
    (setq cwItem 0.35)      ; Ancho columna ITEM
    (setq cwSymbol 1.25)    ; Ancho columna SYMBOL
    (setq cwDesc 1.25)      ; Ancho columna DESCRIPTION
    (setq cwQty 0.5)       ; Ancho columna QTY

    (setq rHeight 0.36)     ; Altura de fila (Suficiente para el símbolo)
    (setq textHeight 0.06)  ; Altura de texto que solicitaste
    ;; =======================================================

    (setq viewportObj (ByrneGetViewport))

    (if viewportObj
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            (setq components (ByrneResolveComponents viewportEname))
            (setq internalBOM (ByrneBuildInternalBOM components))

            (if internalBOM
                (progn
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    (setq currentSpace (vla-get-Block (vla-get-ActiveLayout doc)))
                    (setq insPt (getpoint "\nSelect insertion point for the BOM table: "))

                    (if insPt
                        (progn
                            (setq rows (+ 2 (length internalBOM)))
                            (setq cols 4)

                            (setq tableObj
                                (vla-AddTable
                                    currentSpace
                                    (vlax-3d-point insPt)
                                    rows
                                    cols
                                    rHeight
                                    cwSymbol))

                            (vl-catch-all-apply
                                'vla-put-StyleName
                                (list tableObj "CorrectTable"))

                            ;; =======================================
                            ;; 1. DESCOMBINAR Y BORRAR TÍTULO
                            ;; =======================================
                            (vl-catch-all-apply 'vla-UnmergeCells (list tableObj 0 0 0 3))
                            (vl-catch-all-apply 'vla-DeleteRows (list tableObj 0 1))

                            ;; =======================================
                            ;; 2. APLICAR ANCHOS Y ALTURAS PRIMERO
                            ;; =======================================
                            ;; Alturas Globales
                            (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 1 textHeight))
                            (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 2 textHeight))
                            (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 4 textHeight))

                            ;; Columnas
                            (vla-SetColumnWidth tableObj 0 cwItem)
                            (vla-SetColumnWidth tableObj 1 cwSymbol)
                            (vla-SetColumnWidth tableObj 2 cwDesc)
                            (vla-SetColumnWidth tableObj 3 cwQty)

                            ;; Altura de filas
                            (setq row 0)
                            (repeat (vla-get-Rows tableObj)
                                (vl-catch-all-apply 'vla-SetRowHeight (list tableObj row rHeight))
                                (setq row (1+ row))
                            )

                            ;;----------------------------------------
                            ;; Encabezados (Fila 0)
                            ;;----------------------------------------
                            (vla-SetText tableObj 0 0 "ITEM")
                            (vla-SetText tableObj 0 1 "SYMBOL")
                            (vla-SetText tableObj 0 2 "DESCRIPTION")
                            (vla-SetText tableObj 0 3 "QTY")

                            (setq col 0)
                            (repeat 4
                                (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj 0 col textHeight))
                                (vla-SetCellAlignment tableObj 0 col 5)
                                (setq col (1+ col))
                            )

                            ;;----------------------------------------
                            ;; Datos (Fila 1 en adelante)
                            ;;----------------------------------------
                            (setq row 1)

                            (foreach bomEntry internalBOM

                                ;; ITEM
                                (vla-SetText tableObj row 0 (itoa (cdr (assoc 'item bomEntry))))
                                (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj row 0 textHeight))
                                (vla-SetCellAlignment tableObj row 0 5)

                                ;; SYMBOL
                                (setq rawBlockName (cdr (assoc 'blockName bomEntry)))
                                (setq catEntry (ByrneGetCatalogEntry rawBlockName))
                                (setq symbolBlock (cdr (assoc 'symbolBlock catEntry)))
                                (if (not symbolBlock) (setq symbolBlock rawBlockName))

                                (setq blkID (ByrneGetOrLoadBlockID symbolBlock))

                                (if blkID
                                    (progn
                                        (vla-SetCellType tableObj row 1 2)
                                        
                                        ;; LA MAGIA SUCEDE AQUÍ: :vlax-true activa el AutoFit
                                        (vla-SetBlockTableRecordId tableObj row 1 blkID :vlax-true)
                                        (vla-SetAutoScale tableObj row 1 :vlax-true)
                                        
                                        (vla-SetCellAlignment tableObj row 1 5)
                                    )
                                    (vla-SetText tableObj row 1 "")
                                )

                                ;; DESCRIPTION
                                (vla-SetText tableObj row 2 (cdr (assoc 'description bomEntry)))
                                (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj row 2 textHeight))
                                (vla-SetCellAlignment tableObj row 2 4)

                                ;; QTY
                                (vla-SetText tableObj row 3 (itoa (cdr (assoc 'qty bomEntry))))
                                (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj row 3 textHeight))
                                (vla-SetCellAlignment tableObj row 3 5)

                                (setq row (1+ row))
                            )

                            (princ "\nByrne BOM generada. Escala y Autofit calibrados al 100%.")
                        )
                    )
                )
                (princ "\nNo Byrne components found inside viewport.")
            )
        )
        (princ "\nNo viewport selected.")
    )
    (princ)
)