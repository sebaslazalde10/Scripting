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
          viewportObj viewportEname components internalBOM project
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

            ;; =======================================
            ;; ALINEAR NUMERACIÓN CON LOS GLOBOS
            ;; (usa el mismo Master Project Scan que
            ;; BYRNEAUTOBALLOON / UPANDOWN / LEFTANDRIGHT)
            ;; =======================================
            (setq project (ByrneGetProjectScan))
            (if (not project) (setq project (ByrneBuildProjectScan)))
            (if (and project internalBOM)
                (setq internalBOM (ByrneApplyGlobalNumbering internalBOM project))
            )

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

(defun ByrneExportClusteredCSV (/ csvFile f acadObj doc layouts lay layoutName
                                  viewportObj viewportEname components allComponents
                                  masterBOM project layoutBOMs localBOM
                                  layoutNames bomEntry item desc partNum qty
                                  headerStr lineStr localEntry)
  (setq csvFile (getfiled "Export Matrix BOM as CSV" "Byrne_Matrix_BOM" "csv" 1))
  
  (if csvFile
    (progn
      (setq acadObj (vlax-get-acad-object))
      (setq doc (vla-get-ActiveDocument acadObj))
      (setq layouts (vla-get-Layouts doc))

      ;; Master Scan para sincronía de globos
      (setq project (ByrneGetProjectScan))
      (if (not project) (setq project (ByrneBuildProjectScan)))

      (setq allComponents nil)
      (setq layoutBOMs nil)
      (setq layoutNames nil)

      ;; RECOPILACIÓN: Extraer todo para crear la BOM General y las BOM locales
      (vlax-for lay layouts
        (setq layoutName (vla-get-Name lay))
        (if (/= (strcase layoutName) "MODEL")
            (progn
                (setq viewportObj (ByrneGetLayoutViewport layoutName))
                (if viewportObj
                    (progn
                        (setq viewportEname (vlax-vla-object->ename viewportObj))
                        (setq components (ByrneResolveComponents viewportEname))
                        
                        (if components
                            (progn
                                ;; Sumar a la cubeta general para la Master BOM
                                (setq allComponents (append allComponents components))
                                
                                ;; Construir y guardar la BOM específica de este Layout
                                (setq localBOM (ByrneBuildInternalBOM components))
                                (if (and project localBOM)
                                    (setq localBOM (ByrneApplyGlobalNumbering localBOM project))
                                )
                                ;; Guardar en memoria: ( "NombreLayout" . listaBOMLocal )
                                (setq layoutBOMs (cons (cons layoutName localBOM) layoutBOMs))
                                (setq layoutNames (cons layoutName layoutNames))
                            )
                        )
                    )
                )
            )
        )
      )

      ;; Invertir listas para que los layouts aparezcan en el orden original del archivo
      (setq layoutBOMs (reverse layoutBOMs))
      (setq layoutNames (reverse layoutNames))

      ;; CONSTRUCCIÓN MATRIZ: Crear el CSV basado en la BOM General
      (if allComponents
          (progn
              ;; Construir la BOM General global
              (setq masterBOM (ByrneBuildInternalBOM allComponents))
              (if (and project masterBOM)
                  (setq masterBOM (ByrneApplyGlobalNumbering masterBOM project))
              )

              (setq f (open csvFile "w"))
              
              ;; 1. Imprimir Encabezados
              (setq headerStr "NO. DE ITEM,DESCRIPTION,PART NUMBER")
              (foreach lName layoutNames
                  ;; Agregamos el nombre del layout y una columna vacía (coma extra)
                  (setq headerStr (strcat headerStr "," lName ","))
              )
              (write-line headerStr f)

              ;; 2. Imprimir Filas basadas en la BOM General
              (foreach bomEntry masterBOM
                  (setq item (itoa (cdr (assoc 'item bomEntry))))
                  (setq desc (cdr (assoc 'description bomEntry)))
                  (setq partNum (cdr (assoc 'partNumber bomEntry)))

                  (if (not desc) (setq desc "N/A"))
                  (if (not partNum) (setq partNum "N/A"))
                  
                  ;; Limpieza de comas
                  (setq desc (vl-string-translate "," " " desc))
                  (setq partNum (vl-string-translate "," " " partNum))

                  ;; Iniciar la fila con la info base del componente
                  (setq lineStr (strcat item "," desc "," partNum))

                  ;; 3. Cruzar la info con las columnas de cada layout
                  (foreach lName layoutNames
                      (setq localBOM (cdr (assoc lName layoutBOMs)))
                      (setq qty 0) ; Por defecto es 0 si no lo encuentra
                      
                      ;; Buscar el item actual dentro del BOM de este layout específico
                      (foreach localEntry localBOM
                          (if (= (cdr (assoc 'item localEntry)) (cdr (assoc 'item bomEntry)))
                              (setq qty (cdr (assoc 'qty localEntry)))
                          )
                      )
                      
                      ;; Agregar la cantidad y la coma extra para la columna vacía
                      (setq lineStr (strcat lineStr "," (itoa qty) ","))
                  )
                  
                  (write-line lineStr f)
              )
              (close f)
              (princ (strcat "\nExportación de Matriz exitosa, archivo guardado en: " csvFile))
          )
          (princ "\nNo se encontraron componentes validos en los layouts.")
      )
    )
    (princ "\nExportación cancelada por el usuario.")
  )
  (princ)
)

(defun c:BOM2CSV ()
  (ByrneStart "BYRNE_BOM_MATRIX" "0, 0, 0")
  (ByrneExportClusteredCSV)
  (ByrneEnd)
  (princ)
)

(vl-load-com)

;; --- FUNCIONES AUXILIARES PARA EXCEL ---
(defun ByrnePutCell (sheet row col val / cellVar cellObj)
  ;; Extrae la celda del Variant y asigna el valor
  (setq cellVar (vlax-get-property (vlax-get-property sheet 'Cells) 'Item row col))
  (setq cellObj (vlax-variant-value cellVar))
  (vlax-put-property cellObj 'Value2 val)
)

(defun ByrneSetColWidth (sheet col width / cellVar cellObj colObj)
  ;; Extrae la celda, pide la columna (que ya viene como objeto) y ajusta
  (setq cellVar (vlax-get-property (vlax-get-property sheet 'Cells) 'Item 1 col))
  (setq cellObj (vlax-variant-value cellVar))
  
  ;; 'EntireColumn' devuelve el objeto directo, no un variant
  (setq colObj (vlax-get-property cellObj 'EntireColumn))
  
  (vlax-put-property colObj 'ColumnWidth width)
)
;; --- RUTINA PRINCIPAL ---
(defun ByrneExportMatrixToExcel (/ acadObj doc layouts lay layoutName
                                   viewportObj viewportEname components allComponents
                                   masterBOM project layoutBOMs localBOM
                                   layoutNames bomEntry item desc partNum qty
                                   excelApp wbCollection wb sheet
                                   row col localEntry)
  
  (setq acadObj (vlax-get-acad-object))
  (setq doc (vla-get-ActiveDocument acadObj))
  (setq layouts (vla-get-Layouts doc))

  ;; Master Scan para sincronía de globos
  (setq project (ByrneGetProjectScan))
  (if (not project) (setq project (ByrneBuildProjectScan)))

  (setq allComponents nil)
  (setq layoutBOMs nil)
  (setq layoutNames nil)

  ;; 1. RECOPILACIÓN DE DATOS (Master y Locales)
  (vlax-for lay layouts
    (setq layoutName (vla-get-Name lay))
    (if (/= (strcase layoutName) "MODEL")
        (progn
            (setq viewportObj (ByrneGetLayoutViewport layoutName))
            (if viewportObj
                (progn
                    (setq viewportEname (vlax-vla-object->ename viewportObj))
                    (setq components (ByrneResolveComponents viewportEname))
                    (if components
                        (progn
                            (setq allComponents (append allComponents components))
                            (setq localBOM (ByrneBuildInternalBOM components))
                            (if (and project localBOM)
                                (setq localBOM (ByrneApplyGlobalNumbering localBOM project))
                            )
                            (setq layoutBOMs (cons (cons layoutName localBOM) layoutBOMs))
                            (setq layoutNames (cons layoutName layoutNames))
                        )
                    )
                )
            )
        )
    )
  )

  (setq layoutBOMs (reverse layoutBOMs))
  (setq layoutNames (reverse layoutNames))

  ;; 2. CONSTRUCCIÓN EN EXCEL
  (if allComponents
      (progn
          (setq masterBOM (ByrneBuildInternalBOM allComponents))
          (if (and project masterBOM)
              (setq masterBOM (ByrneApplyGlobalNumbering masterBOM project))
          )

          (princ "\nIniciando Excel... ")
          ;; Iniciar instancia de Excel mediante COM
          (setq excelApp (vlax-get-or-create-object "Excel.Application"))
          (if excelApp
              (progn
                  (vla-put-visible excelApp :vlax-true)
                  (setq wbCollection (vlax-get-property excelApp 'Workbooks))
                  (setq wb (vlax-invoke-method wbCollection 'Add))
                  (setq sheet (vlax-get-property wb 'ActiveSheet))

                  ;; Definir anchos fijos de columnas principales
                  (ByrneSetColWidth sheet 1 6.0)   ;; NO.
                  (ByrneSetColWidth sheet 2 45.0)  ;; DESCRIPTION
                  (ByrneSetColWidth sheet 3 25.0)  ;; PART NUMBER

                  ;; Imprimir Encabezados Fijos
                  (setq row 1)
                  (ByrnePutCell sheet row 1 "NO.")
                  (ByrnePutCell sheet row 2 "DESCRIPTION")
                  (ByrnePutCell sheet row 3 "PART NUMBER")

                  ;; Imprimir Encabezados de Layouts y ajustar sus anchos
                  (setq col 4)
                  (foreach lName layoutNames
                      (ByrnePutCell sheet row col lName)
                      (ByrneSetColWidth sheet col 6.0)       ;; Ancho Columna de Cantidades
                      (ByrneSetColWidth sheet (1+ col) 6.0)  ;; Ancho Columna Vacía
                      (setq col (+ col 2))                   ;; Saltamos de 2 en 2
                  )

                  ;; Imprimir Filas de Componentes
                  (setq row 2)
                  (foreach bomEntry masterBOM
                      (setq item (itoa (cdr (assoc 'item bomEntry))))
                      (setq desc (cdr (assoc 'description bomEntry)))
                      (setq partNum (cdr (assoc 'partNumber bomEntry)))

                      (if (not desc) (setq desc "N/A"))
                      (if (not partNum) (setq partNum "N/A"))

                      (ByrnePutCell sheet row 1 item)
                      (ByrnePutCell sheet row 2 desc)
                      (ByrnePutCell sheet row 3 partNum)

                      (setq col 4)
                      (foreach lName layoutNames
                          (setq localBOM (cdr (assoc lName layoutBOMs)))
                          (setq qty 0)
                          
                          (foreach localEntry localBOM
                              (if (= (cdr (assoc 'item localEntry)) (cdr (assoc 'item bomEntry)))
                                  (setq qty (cdr (assoc 'qty localEntry)))
                              )
                          )
                          
                          ;; Escribir la cantidad
                          (if (> qty 0)
                              (ByrnePutCell sheet row col (itoa qty))
                              (ByrnePutCell sheet row col "0")
                          )
                          ;; Dejamos la columna col+1 vacía intacta y avanzamos
                          (setq col (+ col 2))
                      )
                      (setq row (1+ row))
                  )
                  
                  ;; Liberar memoria COM
                  (vlax-release-object sheet)
                  (vlax-release-object wb)
                  (vlax-release-object wbCollection)
                  (vlax-release-object excelApp)
                  (princ "\n¡Exportación a Excel finalizada con éxito!")
              )
              (princ "\nError: No se pudo iniciar Microsoft Excel. Asegúrate de tenerlo instalado.")
          )
      )
      (princ "\nNo se encontraron componentes validos en los layouts.")
  )
  (princ)
)

(defun c:BOM2EXCEL ()
  (ByrneStart "BYRNE_BOM_EXCEL" "0, 0, 0")
  (ByrneExportMatrixToExcel)
  (ByrneEnd)
  (princ)
)