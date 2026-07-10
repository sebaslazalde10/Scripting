;=================================================
; ByrneExportMultiLayout.lsp
; Byrne México CAD Automation Library
;
; Motor de automatización (AutoCAD Layouts -> Excel)
;=================================================

(vl-load-com)

;;=================================================
;; Subfunción Auxiliar: Desempaquetado Seguro
;;=================================================
(defun ByrneSafeObj (obj)
  ;; Si es un variant, saca el objeto. Si no, lo devuelve tal cual.
  (if (= (type obj) 'variant)
    (vlax-variant-value obj)
    obj
  )
)

(defun c:BOM2EXCEL_ALL (/ acad doc layouts layoutList ss i vpEname vp validVp layName
                         xlApp xlBooks xlBook xlSheets clusterIndex letterCode sheetName 
                         vportEname components internalBOM)
  
  (ByrneStart "BYRNE_BOM_MULTILAYOUT" "0, 0, 0")
  (princ "\nIniciando escaneo automático de Layouts...")

  (setq acad (vlax-get-acad-object))
  (setq doc (vla-get-ActiveDocument acad))
  (setq layouts (vla-get-Layouts doc))

  ;; 1. Recopilar y ordenar Layouts (pestañas de AutoCAD) ignorando el "Model"
  (setq layoutList nil)
  (vlax-for lay layouts
    (if (= (vla-get-ModelType lay) :vlax-false)
      (setq layoutList (cons lay layoutList))
    )
  )
  
  ;; Ordenar la lista por la propiedad "TabOrder" (El orden físico de las pestañas de izq a der)
  (setq layoutList (vl-sort layoutList '(lambda (a b) (< (vla-get-TabOrder a) (vla-get-TabOrder b)))))

  (if layoutList
    (progn
      ;; 2. Inicializar la conexión ActiveX con Excel de forma invisible
      (setq xlApp (vlax-get-or-create-object "Excel.Application"))
      (vlax-put-property xlApp 'Visible :vlax-false)
      
      ;; Pasamos todo a través del filtro de seguridad (ByrneSafeObj)
      (setq xlBooks (ByrneSafeObj (vlax-get-property xlApp 'Workbooks)))
      (setq xlBook (ByrneSafeObj (vlax-invoke-method xlBooks 'Add)))
      (setq xlSheets (ByrneSafeObj (vlax-get-property xlBook 'Sheets)))

      (setq clusterIndex 0)

      ;; 3. Iterar sobre cada Layout (Pestaña) en el orden correcto
      (foreach lay layoutList
        (setq layName (vla-get-Name lay))
        (setq validVp nil)
        
        ;; Buscar todos los viewports que existan SÓLO en esta pestaña actual
        (setq ss (ssget "X" (list '(0 . "VIEWPORT") (cons 410 layName))))
        
        (if ss
          (progn
            (setq i 0)
            (repeat (sslength ss)
              (setq vpEname (ssname ss i))
              (setq vp (vlax-ename->vla-object vpEname))
              
              ;; Identificamos el Viewport correcto leyendo su código DXF nativo (69)
              (if (> (cdr (assoc 69 (entget vpEname))) 1)
                (setq validVp vp)
              )
              (setq i (1+ i))
            )
          )
        )

        ;; 4. Si encontramos un Viewport en la pestaña, intentamos extraer su BOM
        (if validVp
          (progn
            (setq vportEname (vlax-vla-object->ename validVp))
            (setq components (ByrneResolveComponents vportEname))
            (setq internalBOM (ByrneBuildInternalBOM components))

            ;; Si hubo componentes válidos en ese layout, creamos su pestaña en Excel
            (if internalBOM
              (progn
                ;; Asignamos CLUSTER A (65), CLUSTER B (66), etc.
                (setq letterCode (+ 65 clusterIndex))
                (setq sheetName (strcat "CLUSTER " (chr letterCode)))

                (ByrneWriteToExcelSheet xlSheets sheetName internalBOM)
                (setq clusterIndex (1+ clusterIndex))
              )
            )
          )
        )
      )

      ;; 5. Finalizar, hacer visible Excel y liberar la memoria COM
      (vlax-put-property xlApp 'Visible :vlax-true) 
      (vlax-release-object xlSheets)
      (vlax-release-object xlBook)
      (vlax-release-object xlBooks)
      (vlax-release-object xlApp)
      (princ (strcat "\nProceso terminado. Se generaron " (itoa clusterIndex) " clusters en Excel."))
    )
    (princ "\nNo se encontraron Layouts de espacio papel.")
  )

  (ByrneEnd)
  (princ)
)

;;=================================================
;; Subfunción Auxiliar: Inyección limpia en celda
;;=================================================
(defun ByrneSetCell (cells row col val / cellObj)
  ;; Se obtiene la celda, se filtra por ByrneSafeObj, y se escribe el valor
  (setq cellObj (ByrneSafeObj (vlax-get-property cells 'Item row col)))
  (vlax-put-property cellObj 'Value2 val)
)

;;=================================================
;; Subfunción: Inyección de datos en la pestaña
;;=================================================
(defun ByrneWriteToExcelSheet (xlSheets sheetName internalBOM / xlSheet cells row bomEntry item rawBlockName catEntry desc partNum qty)
  
  ;; Añadir o renombrar una pestaña en el libro
  (setq xlSheet (ByrneSafeObj (vlax-invoke-method xlSheets 'Add)))
  (vlax-put-property xlSheet 'Name sheetName)
  
  ;; Obtener la matriz de celdas
  (setq cells (ByrneSafeObj (vlax-get-property xlSheet 'Cells)))

  ;; Escribir Encabezados usando la función auxiliar
  (ByrneSetCell cells 1 1 "ITEM")
  (ByrneSetCell cells 1 2 "DESCRIPCIÓN")
  (ByrneSetCell cells 1 3 "NO. DE PARTE")
  (ByrneSetCell cells 1 4 "CANTIDAD O QTY")

  ;; Llenar Filas de Datos
  (setq row 2)
  (foreach bomEntry internalBOM
    (setq item (cdr (assoc 'item bomEntry)))
    (setq rawBlockName (cdr (assoc 'blockName bomEntry)))
    (setq desc (cdr (assoc 'description bomEntry)))
    (setq qty (cdr (assoc 'qty bomEntry)))
    
    ;; Obtener el No. de Parte desde el Catálogo
    (setq catEntry (ByrneGetCatalogEntry rawBlockName))
    (setq partNum (cdr (assoc 'partNumber catEntry)))

    (if (not desc) (setq desc "N/A"))
    (if (not partNum) (setq partNum "N/A"))

    ;; Inyectar usando la función auxiliar
    (ByrneSetCell cells row 1 item)
    (ByrneSetCell cells row 2 desc)
    (ByrneSetCell cells row 3 partNum)
    (ByrneSetCell cells row 4 (itoa qty)) ;; Nos aseguramos de convertir QTY a String

    (setq row (1+ row))
  )
  
  (vlax-release-object xlSheet)
)