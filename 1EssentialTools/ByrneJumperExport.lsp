;=================================================
; ByrneCurveExport.lsp
; Byrne México CAD Automation Library
;
; Extrae la longitud de Arcos, Splines y Polilíneas
; seleccionados manualmente hacia un archivo CSV.
;=================================================

(vl-load-com)

(defun c:BYRNECURVEEXPORT (/ ss csvFile f i item ename obj curveType curveLen lineStr)
  
  (princ "\nSelecciona los Jumpers (Arcos, Splines o Polilíneas): ")
  
  ;; 1. Selección manual con filtro estricto por tipo de entidad
  (setq ss (ssget '((0 . "ARC,SPLINE,*POLYLINE"))))
  
  (if ss
    (progn
      ;; 2. Solicitamos la ruta para guardar el CSV
      (setq csvFile (getfiled "Exportar Jumpers CSV" "Byrne_Jumper_Lengths" "csv" 1))
      
      (if csvFile
        (progn
          ;; Abrimos el archivo en modo escritura
          (setq f (open csvFile "w"))
          
          ;; Escribimos los encabezados (sin coordenadas, solo largos)
          (write-line "ITEM,TIPO,LONGITUD" f)
          
          (setq i 0 item 1)

          ;; 3. Iteramos sobre la selección del usuario
          (while (< i (sslength ss))
            (setq ename (ssname ss i))
            (setq obj (vlax-ename->vla-object ename))
            
            ;; Obtenemos el tipo real (ARC, SPLINE, LWPOLYLINE) para el reporte
            (setq curveType (cdr (assoc 0 (entget ename))))
            
            ;; 4. Optimización: Usamos vlax-curve para medir cualquier geometría
            (setq curveLen (vlax-curve-getDistAtParam obj (vlax-curve-getEndParam obj)))
            
            ;; Construimos y escribimos la línea CSV a 4 decimales
            (setq lineStr (strcat (itoa item) "," curveType "," (rtos curveLen 2 4)))
            (write-line lineStr f)
            
            (setq item (1+ item))
            (setq i (1+ i))
          )
          
          ;; Cerramos el archivo
          (close f)
          (princ (strcat "\n[ÉXITO] Exportación completada. Archivo guardado en: " csvFile))
        )
        (princ "\n[CANCELADO] Exportación cancelada.")
      )
    )
    (princ "\n[VACÍO] No se seleccionó ningún objeto válido.")
  )
  (princ)
)

(princ "\nByrneCurveExport cargado. Ejecuta BYRNECURVEEXPORT para comenzar.")
(princ)


;=================================================
; ByrneLabelJumpers.lsp
; Byrne México CAD Automation Library
;
; Genera etiquetas de longitud sobre Arcos, Splines y 
; Polilíneas. Cambia automáticamente a Model Space para 
; seleccionar la capa y regresa a Paper Space al terminar.
;=================================================


(defun c:BYRNELABELJUMPERS (/ viewportObj viewportEname vpID extents vpScale textHeight ent entData targetLayer filterList ss i ename obj endParam midParam midPt curveLen ptStr)
  
  ;; 1. Obtenemos el Viewport usando el escáner base (desde Paper Space)
  (setq viewportObj (ByrneGetViewport))

  (if viewportObj
    (progn
      (setq viewportEname (vlax-vla-object->ename viewportObj))
      (setq extents (ByrneGetViewportExtents viewportEname))
      
      ;; 2. Cálculo dinámico de altura de texto para mantener 0.1" en papel
      (setq vpScale (vla-get-CustomScale viewportObj))
      (setq textHeight (/ 0.1 vpScale)) 
      
      ;; 3. TRANSICIÓN: Cambiamos a Model Space dentro del Layout
      (if (= (getvar "TILEMODE") 0) ; Verificamos que estamos en un Layout
        (progn
          (command "_.MSPACE")
          ;; Extraemos el ID del viewport seleccionado (Código DXF 69) y lo activamos
          (setq vpID (cdr (assoc 69 (entget viewportEname))))
          (setvar "CVPORT" vpID)
        )
      )
      
      ;; 4. Solicitamos la selección del objeto de muestra
      (setq targetLayer nil)
      (while (not targetLayer)
        (setq ent (car (entsel "\nSelecciona un arco, spline o polilínea para definir la capa a etiquetar: ")))
        (if ent
          (progn
            (setq entData (entget ent))
            (if (wcmatch (cdr (assoc 0 entData)) "ARC,SPLINE,*POLYLINE")
              (setq targetLayer (cdr (assoc 8 entData))) 
              (princ "\n[ERROR] El objeto no es una curva válida. Intenta de nuevo.")
            )
          )
          (princ "\n[CANCELADO] Selección vacía. Intenta de nuevo o presiona ESC.")
        )
      )
      
      (princ (strcat "\nFiltrando jumpers en la capa: " targetLayer))
      
      ;; 5. Armamos el filtro dinámico y seleccionamos
      (setq filterList (list '(0 . "ARC,SPLINE,*POLYLINE") (cons 8 targetLayer)))
      (setq ss (ssget "_X" filterList))
      
      (if ss
        (progn
          (setq i 0)
          ;; 6. Iteramos sobre los resultados
          (while (< i (sslength ss))
            (setq ename (ssname ss i))
            (setq obj (vlax-ename->vla-object ename))
            
            (setq endParam (vlax-curve-getEndParam obj))
            (setq midParam (/ endParam 2.0))
            (setq midPt (vlax-curve-getPointAtParam obj midParam))
            
            ;; Validamos que el punto medio esté dentro de los límites del viewport
            (if (ByrnePointInsideWindow midPt extents)
              (progn
                (setq curveLen (vlax-curve-getDistAtParam obj endParam))
                (setq ptStr (strcat "L= " (rtos curveLen 2 2) " in"))
                
                ;; Creación de la etiqueta centrada
                (entmake
                  (list
                    '(0 . "TEXT")
                    '(100 . "AcDbEntity")
                    '(100 . "AcDbText")
                    (cons 10 midPt)      
                    (cons 40 textHeight) 
                    (cons 1 ptStr)       
                    '(72 . 1)            
                    (cons 11 midPt)      
                    '(73 . 2)            
                  )
                )
              )
            )
            (setq i (1+ i))
          )
          (princ "\n[ÉXITO] Etiquetas de longitud generadas correctamente.")
        )
        (princ "\n[VACÍO] No se encontraron curvas en la capa indicada.")
      )
      
      ;; 7. TRANSICIÓN: Regresamos al Paper Space (Layout) al terminar
      (if (= (getvar "TILEMODE") 0)
        (command "_.PSPACE")
      )
    )
    (princ "\n[ERROR] No se seleccionó un viewport válido.")
  )
  (princ)
)

(princ "\nByrneLabelJumpers cargado. Ejecuta BYRNELABELJUMPERS para comenzar.")
(princ)