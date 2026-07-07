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

;=================================================
; BYRNECORRECTTABLE
; Genera una tabla de materiales basada en el escaneo
; global (*ByrneProjectScan*), mostrando solo los elementos
; del viewport pero reteniendo su índice e identidad global.
;=================================================

(defun c:BYRNECORRECTTABLE 
       (/ doc currentSpace insPt rows cols row tableObj
          viewportObj viewportEname components localQty
          viewportBOM bName globalItem)

    (ByrneStart "BYRNE_PROJECT_BOMS" "0, 0, 0")
    ;; 1. Garantizar la existencia del Master BOM Global
    (princ "\n[INFO] Actualizando escaneo global del modelo...")
    (ByrneBuildProjectScan)

    ;; 2. Selección del Viewport
    (setq viewportObj (ByrneGetViewport))

    (if (null viewportObj)
        (progn
            (princ "\nNo se seleccionó ningún viewport.")
            (princ)
        )
        (progn
            (setq viewportEname (vlax-vla-object->ename viewportObj))
            
            ;; Extraer y resolver los componentes físicos del viewport actual
            (setq components (ByrneResolveComponents viewportEname))

            (if (null components)
                (progn
                    (princ "\nNo se encontraron componentes Byrne dentro de este viewport.")
                    (princ)
                )
                (progn
                    ;;=================================================
                    ;; CONSTRUCCIÓN DEL BOM LOCAL FILTRADO POR EL GLOBAL
                    ;;=================================================
                    (setq viewportBOM nil)

                    ;; Iteramos sobre la "Fuente Única de Verdad"
                    (foreach globalItem *ByrneProjectScan*
                        (setq bName (cdr (assoc 'blockName globalItem)))
                        
                        ;; Contar cuántas instancias de este bloque global viven en el viewport
                        (setq localQty (ByrneCountInstances bName components))

                        ;; Si existe en el viewport, construimos la entrada mapeada
                        (if (> localQty 0)
                            (setq viewportBOM
                                  (append viewportBOM
                                          (list
                                              (list
                                                  (assoc 'item globalItem)
                                                  (assoc 'blockName globalItem)
                                                  (assoc 'description globalItem)
                                                  (assoc 'partNumber globalItem)
                                                  (cons 'qty localQty)
                                              )
                                          )
                                  )
                            )
                        )
                    )

                    ;;=================================================
                    ;; DIBUJAR LA TABLA (ESTILO PRETTY TABLE)
                    ;;=================================================
                    (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
                    (setq currentSpace (vla-get-Block (vla-get-ActiveLayout doc)))
                    
                    (setq insPt (getpoint "\nSelecciona el punto de inserción para la tabla BOM: "))
                    
                    (if insPt
                        (progn
                            ;; 2 filas para Título y Encabezados + número de datos
                            (setq rows (+ (length viewportBOM) 2))
                            (setq cols 4)

                            ;; Crear objeto Tabla ActiveX con las medidas de PrettyTable
                            (setq tableObj 
                                  (vla-AddTable 
                                      currentSpace 
                                      (vlax-3d-point insPt) 
                                      rows 
                                      cols 
                                      0.12  ; Altura de fila original
                                      1.0   ; Ancho de columna original
                                  )
                            )

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
                            ;; HEADERS (Ahora en la fila 0 tras borrar el título)
                            ;;=========================================
                            (vla-SetText tableObj 0 0 "ITEM")
                            (vla-SetText tableObj 0 1 "SYMBOLOGY")
                            (vla-SetText tableObj 0 2 "DESCRIPTION")
                            (vla-SetText tableObj 0 3 "QTY")

                            ;;=========================================
                            ;; Llenado de filas dinámicas
                            ;;=========================================
                            (setq row 1) ; Empieza en 1 porque la fila 0 son los encabezados
                            (foreach bomEntry viewportBOM
                                
                                ;; Ítem indexado globalmente
                                (vla-SetText tableObj row 0 (itoa (cdr (assoc 'item bomEntry))))
                                
                                ;; Espacio reservado para bloques de simbología futura
                                (vla-SetText tableObj row 1 "")
                                
                                ;; Descripción exacta del catálogo maestro
                                (vla-SetText tableObj row 2 (cdr (assoc 'description bomEntry)))
                                
                                ;; Cantidad localizada en la ventana escaneada
                                (vla-SetText tableObj row 3 (itoa (cdr (assoc 'qty bomEntry))))
                                
                                (setq row (1+ row))
                            )

                            (princ "\nByrne Correct Table generada exitosamente con formato e índices globales.")
                        )
                        (princ "\nOperación cancelada: No se seleccionó un punto de inserción.")
                    )
                )
            )
        )
    )
    (princ)
  
  (ByrneEnd)
)