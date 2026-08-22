;=================================================
; GENBOMS.lsp
; Byrne México CAD Automation Library
;
; Itera todos los layouts del proyecto (cada uno con
; UN solo viewport), genera la tabla BOM en cada uno
; usando la misma logica que BOMMING, y coloca la
; tabla de modo que su esquina INFERIOR DERECHA quede
; exactamente en (6.0, 0.5, 0) [pulgadas, paper space].
;
; Requiere que ByrneStart, ByrneEnd, ByrneResolveComponents,
; ByrneBuildInternalBOM, ByrneGetCatalogEntry y
; ByrneGetOrLoadBlockID ya esten cargadas (ByrneCorrectTable.lsp).
;=================================================

(vl-load-com)

;=================================================
; ByrneGetLayoutViewport
; Encuentra automaticamente el (unico) viewport real
; de un layout, ignorando el viewport de sistema (id 1)
;=================================================
(defun ByrneGetLayoutViewport (layoutName / ss i ent vpId obj vpObj)
    (setq vpObj nil)
    (setq ss (ssget "X" (list '(0 . "VIEWPORT") (cons 410 layoutName))))
    (if ss
        (progn
            (setq i 0)
            (while (and (< i (sslength ss)) (not vpObj))
                (setq ent (ssname ss i))
                ;; El ID del viewport viene en el codigo DXF 69.
                ;; El viewport de sistema (el propio "papel") siempre tiene Id = 1
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
; C:GENBOMS
;=================================================
(defun c:GENBOMS
       (/ acadObj doc layouts lay layoutName currentLayout currentSpace
          viewportObj viewportEname components internalBOM project
          rows cols row col tableObj
          bomEntry rawBlockName catEntry symbolBlock blkID customScale
          cwItem cwSymbol cwDesc cwQty rHeight textHeight fallbackScale
          targetX targetY targetZ
          numRows numCols totalWidth totalHeight r c
          insPtVariant insPtList curX curY curZ dx dy)

    (ByrneStart "BYRNE_GENBOMS" "0, 0, 0")

    (setq acadObj (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acadObj))

    ;; =======================================================
    ;; PUNTO OBJETIVO: esquina INFERIOR DERECHA de la tabla
    ;; (pulgadas, coordenadas del paper space de cada layout)
    ;; =======================================================
    (setq targetX 6.0)
    (setq targetY 0.5)
    (setq targetZ 0.0)

    ;; =======================================================
    ;; CONFIGURACION FISICA (misma que BOMMING)
    ;; =======================================================
    (setq cwItem 0.35)
    (setq cwSymbol 1.25)
    (setq cwDesc 1.25)
    (setq cwQty 0.50)

    (setq rHeight 0.36)
    (setq textHeight 0.06)
    (setq fallbackScale 0.06)
    ;; =======================================================

    (setq layouts (vla-get-Layouts doc))

    ;; =======================================================
    ;; MASTER PROJECT SCAN (una sola vez, antes del loop)
    ;; Misma fuente que usan los globos, para que la
    ;; numeracion de TODAS las tablas coincida entre si
    ;; y con los globos.
    ;; =======================================================
    (setq project (ByrneGetProjectScan))
    (if (not project) (setq project (ByrneBuildProjectScan)))

    (vlax-for lay layouts
        (setq layoutName (vla-get-Name lay))

        (if (/= (strcase layoutName) "MODEL")
            (progn
                (vla-put-ActiveLayout doc lay)
                (setq currentLayout (vla-get-ActiveLayout doc))
                (setq currentSpace (vla-get-Block currentLayout))

                (setq viewportObj (ByrneGetLayoutViewport layoutName))

                (if viewportObj
                    (progn
                        (setq viewportEname (vlax-vla-object->ename viewportObj))
                        (setq components (ByrneResolveComponents viewportEname))
                        (setq internalBOM (ByrneBuildInternalBOM components))

                        ;; ALINEAR NUMERACION CON LOS GLOBOS
                        (if (and project internalBOM)
                            (setq internalBOM (ByrneApplyGlobalNumbering internalBOM project))
                        )

                        (if internalBOM
                            (progn
                                (setq rows (+ 2 (length internalBOM)))
                                (setq cols 4)

                                ;; Se crea en un punto temporal (0,0,0); se reposiciona
                                ;; al final con base en las dimensiones reales de la tabla.
                                (setq tableObj (vla-AddTable currentSpace (vlax-3d-point 0.0 0.0 0.0) rows cols rHeight cwSymbol))

                                (vl-catch-all-apply 'vla-put-StyleName (list tableObj "CorrectTable"))

                                ;; =======================================
                                ;; 1. DESCOMBINAR Y BORRAR TITULO
                                ;; =======================================
                                (vl-catch-all-apply 'vla-UnmergeCells (list tableObj 0 0 0 3))
                                (vl-catch-all-apply 'vla-DeleteRows (list tableObj 0 1))

                                ;; =======================================
                                ;; 2. APLICAR ANCHOS Y ALTURAS BASE
                                ;; =======================================
                                (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 1 textHeight))
                                (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 2 textHeight))
                                (vl-catch-all-apply 'vla-SetTextHeight (list tableObj 4 textHeight))

                                (vla-SetColumnWidth tableObj 0 cwItem)
                                (vla-SetColumnWidth tableObj 1 cwSymbol)
                                (vla-SetColumnWidth tableObj 2 cwDesc)
                                (vla-SetColumnWidth tableObj 3 cwQty)

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

                                    ;; SYMBOL + ESCALA PERSONALIZADA
                                    (setq rawBlockName (cdr (assoc 'blockName bomEntry)))
                                    (setq catEntry (ByrneGetCatalogEntry rawBlockName))

                                    (setq symbolBlock (cdr (assoc 'symbolBlock catEntry)))
                                    (if (not symbolBlock) (setq symbolBlock rawBlockName))

                                    (setq customScale (cdr (assoc 'blockScale catEntry)))
                                    (if (not customScale) (setq customScale fallbackScale))

                                    (setq blkID (ByrneGetOrLoadBlockID symbolBlock))

                                    (if blkID
                                        (progn
                                            (vla-SetCellType tableObj row 1 2)
                                            (vla-SetBlockTableRecordId tableObj row 1 blkID :vlax-true)
                                            (vla-SetAutoScale tableObj row 1 :vlax-false)
                                            (vla-SetBlockScale tableObj row 1 customScale)
                                            (vla-SetCellAlignment tableObj row 1 5)
                                        )
                                        (vla-SetText tableObj row 1 "")
                                    )

                                    ;; DESCRIPTION
                                    (vla-SetText tableObj row 2 (cdr (assoc 'description bomEntry)))
                                    (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj row 2 textHeight))
                                    (vla-SetCellAlignment tableObj row 2 5)

                                    ;; QTY
                                    (vla-SetText tableObj row 3 (itoa (cdr (assoc 'qty bomEntry))))
                                    (vl-catch-all-apply 'vla-SetCellTextHeight (list tableObj row 3 textHeight))
                                    (vla-SetCellAlignment tableObj row 3 5)

                                    (setq row (1+ row))
                                )

                                ;; ========================================================
                                ;; BUCLE APLANADOR FINAL
                                ;; ========================================================
                                (setq row 0)
                                (repeat (vla-get-Rows tableObj)
                                    (vl-catch-all-apply 'vla-SetRowHeight (list tableObj row rHeight))
                                    (setq row (1+ row))
                                )
                                (vla-SetColumnWidth tableObj 1 cwSymbol)

                                ;; ========================================================
                                ;; REPOSICIONAR: esquina inferior derecha -> (targetX, targetY, targetZ)
                                ;; Se calcula con las dimensiones REALES de la tabla ya
                                ;; terminada (ancho de columnas + alto de filas), no se
                                ;; asume el punto de insercion original.
                                ;; ========================================================
                                (setq numRows (vla-get-Rows tableObj))
                                (setq numCols (vla-get-Columns tableObj))

                                (setq totalWidth 0.0)
                                (setq c 0)
                                (repeat numCols
                                    (setq totalWidth (+ totalWidth (vla-GetColumnWidth tableObj c)))
                                    (setq c (1+ c))
                                )

                                (setq totalHeight 0.0)
                                (setq r 0)
                                (repeat numRows
                                    (setq totalHeight (+ totalHeight (vla-GetRowHeight tableObj r)))
                                    (setq r (1+ r))
                                )

                                (setq insPtVariant (vla-get-InsertionPoint tableObj))
                                (setq insPtList (vlax-safearray->list (vlax-variant-value insPtVariant)))
                                (setq curX (nth 0 insPtList))
                                (setq curY (nth 1 insPtList))
                                (setq curZ (nth 2 insPtList))

                                ;; Esquina inferior derecha actual = (curX + totalWidth, curY - totalHeight)
                                (setq dx (- targetX (+ curX totalWidth)))
                                (setq dy (- targetY (- curY totalHeight)))

                                (vla-Move tableObj
                                    (vlax-3d-point curX curY curZ)
                                    (vlax-3d-point (+ curX dx) (+ curY dy) (+ curZ (- targetZ curZ)))
                                )

                                (princ (strcat "\nGENBOMS: BOM generada en layout \"" layoutName "\"."))
                            )
                            (princ (strcat "\nGENBOMS: no se encontraron componentes Byrne en el viewport del layout \"" layoutName "\"."))
                        )
                    )
                    (princ (strcat "\nGENBOMS: no se encontro viewport en el layout \"" layoutName "\"."))
                )
            )
        )
    )

    (ByrneEnd)
    (princ)
)

(princ "\nGENBOMS.lsp cargado. Escribe GENBOMS para generar las tablas BOM en todos los layouts.")
(princ)