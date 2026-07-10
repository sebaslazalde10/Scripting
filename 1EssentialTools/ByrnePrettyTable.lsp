;=================================================
; ByrneCorrectTable.lsp
; Byrne México CAD Automation Library
;
; Version: CorrectTable_v6.1 (Custom Scale Engine)
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

(defun c:BOMMING
       (/ doc currentSpace insPt rows cols row col tableObj
          viewportObj viewportEname components internalBOM
          bomEntry rawBlockName catEntry symbolBlock blkID customScale
          cwItem cwSymbol cwDesc cwQty
          rHeight textHeight fallbackScale)
  
    (ByrneStart "BYRNE_BOM" "0, 0, 0")
    ;; =======================================================
    ;; CONFIGURACIÓN FÍSICA (Centímetros)
    ;; =======================================================
    (setq cwItem 0.35)      
    (setq cwSymbol 1.25)    
    (setq cwDesc 1.25)      
    (setq cwQty 0.50)       

    (setq rHeight 0.36)     
    (setq textHeight 0.06)  
    (setq fallbackScale 0.06) ;; Escala de seguridad por si no la pones en el catálogo
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

                            (setq tableObj (vla-AddTable currentSpace (vlax-3d-point insPt) rows cols rHeight cwSymbol))

                            (vl-catch-all-apply 'vla-put-StyleName (list tableObj "CorrectTable"))

                            ;; =======================================
                            ;; 1. DESCOMBINAR Y BORRAR TÍTULO
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

                                ;; ========================================================
                                ;; INYECCIÓN DEL SÍMBOLO Y ESCALA PERSONALIZADA
                                ;; ========================================================
                                (setq rawBlockName (cdr (assoc 'blockName bomEntry)))
                                (setq catEntry (ByrneGetCatalogEntry rawBlockName))
                                
                                (setq symbolBlock (cdr (assoc 'symbolBlock catEntry)))
                                (if (not symbolBlock) (setq symbolBlock rawBlockName))
                                
                                ;; Lectura de la escala desde el catálogo
                                (setq customScale (cdr (assoc 'blockScale catEntry)))
                                (if (not customScale) (setq customScale fallbackScale))

                                (setq blkID (ByrneGetOrLoadBlockID symbolBlock))

                                (if blkID
                                    (progn
                                        (vla-SetCellType tableObj row 1 2)
                                        
                                        ;; PASO A: Asentamos con AutoFit ENCENDIDO (:vlax-true)
                                        (vla-SetBlockTableRecordId tableObj row 1 blkID :vlax-true)
                                        
                                        ;; PASO B: Apagamos el AutoFit para tomar el control (:vlax-false)
                                        (vla-SetAutoScale tableObj row 1 :vlax-false)
                                        
                                        ;; PASO C: Inyectamos tu escala
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
                            ;; BUCLE APLANADOR FINAL (Forzar dimensiones al terminar)
                            ;; ========================================================
                            (setq row 0)
                            (repeat (vla-get-Rows tableObj)
                                (vl-catch-all-apply 'vla-SetRowHeight (list tableObj row rHeight))
                                (setq row (1+ row))
                            )
                            (vla-SetColumnWidth tableObj 1 cwSymbol)

                            (princ "\nByrne BOM generada. Escalas inyectadas desde el Catálogo.")
                        )
                    )
                )
                (princ "\nNo Byrne components found inside viewport.")
            )
        )
        (princ "\nNo viewport selected.")
    )
  
    (ByrneEnd)
    (princ)
)

;=================================================
; ByrneExportCSV.lsp
; Byrne México CAD Automation Library
;
; Módulo de exportación de BOM a formato CSV
;=================================================

(vl-load-com)


(defun ByrneExportToCSV (internalBOM / csvFile f bomEntry item rawBlockName catEntry desc partNum qty lineStr)
  ;; 1. Solicitar al usuario la ruta y nombre del archivo
  (setq csvFile (getfiled "Export BOM as CSV" "Byrne_Bill_of_Materials" "csv" 1))
  
  (if csvFile
    (progn
      ;; 2. Abrir el archivo en modo escritura ("w" = write)
      (setq f (open csvFile "w"))
      
      ;; 3. Escribir encabezados
      (write-line "ITEM,DESCRIPTION,PART NUMBER,QTY" f)
      
      ;; 4. Iterar sobre el internalBOM
      (foreach bomEntry internalBOM
        
        ;; Extraer datos básicos del BOMEntry
        (setq item (itoa (cdr (assoc 'item bomEntry))))
        (setq rawBlockName (cdr (assoc 'blockName bomEntry)))
        (setq desc (cdr (assoc 'description bomEntry)))
        (setq qty (itoa (cdr (assoc 'qty bomEntry))))
        
        ;; Consultar ByrneCatalogsPro.lsp para obtener el NO. DE PARTE
        (setq catEntry (ByrneGetCatalogEntry rawBlockName))
        (setq partNum (cdr (assoc 'partNumber catEntry)))
        
        ;; Validaciones de seguridad (evitar errores de tipo 'nil')
        (if (not desc) (setq desc "N/A"))
        (if (not partNum) (setq partNum "N/A"))
        
        ;; Limpiar comas para no romper la estructura del CSV
        (setq desc (vl-string-translate "," " " desc))
        (setq partNum (vl-string-translate "," " " partNum))
        
        ;; 5. Construir y escribir la fila (Omitiendo la columna de Símbolo)
        (setq lineStr (strcat item "," desc "," partNum "," qty))
        (write-line lineStr f)
      )
      
      ;; 6. Cerrar el archivo para liberar la memoria
      (close f)
      (princ (strcat "\nSuccessful exportation, file saved to: " csvFile))
    )
    (princ "\nExportation cancelled by the user.")
  )
  (princ)
)

(defun c:BOM2CSV (/ viewportObj viewportEname components internalBOM)
  (ByrneStart "BYRNE_BOM_CSV" "0, 0, 0")
  
  (setq viewportObj (ByrneGetViewport))

  (if viewportObj
      (progn
          (setq viewportEname (vlax-vla-object->ename viewportObj))
          (setq components (ByrneResolveComponents viewportEname))
          (setq internalBOM (ByrneBuildInternalBOM components))

          (if internalBOM
              ;; Si el BOM se generó correctamente, disparamos la exportación
              (ByrneExportToCSV internalBOM)
              (princ "\nNo Byrne components found inside viewport.")
          )
      )
      (princ "\nNo viewport selected.")
  )
  
  (ByrneEnd)
  (princ)
)