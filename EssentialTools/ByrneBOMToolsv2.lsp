;=================================================
; ByrneBOMToolsv2.lsp
; Byrne México CAD Automation Library
;
; Version: BOM_v2.0
; Author: Sebastián Lazalde + ChatGPT
; Date: June 2026
;
; Functions:
; - ByrneAddBOM
; - BOM
; - BOMRAW
; - BOMCLEAR
; - BOMTABLE (Legacy Text)
; - BOMTABLEPRETTY (ActiveX Compact Table)
; - BOM2CSV (Excel Export with Comma Protection)
;=================================================



;=================================================
; INICIALIZAR BOM
;=================================================

(if (not *ByrneBOM*)
  (setq *ByrneBOM* nil)
)



;=================================================
; AGREGAR ITEM AL BOM
;=================================================

(defun ByrneAddBOM (item qty)

  (setq *ByrneBOM*
        (cons
          (list item qty)
          *ByrneBOM*
        )
  )

)



;=================================================
; LIMPIAR BOM
;=================================================

(defun c:BOMCLEAR ()

  (setq *ByrneBOM* nil)

  (princ "\nBOM reiniciado.")
  (princ)

)



;=================================================
; VER BOM CRUDO
;=================================================

(defun c:BOMRAW ()

  (print *ByrneBOM*)
  (princ)

)



;=================================================
; MOSTRAR BOM AGRUPADO
;=================================================

(defun c:BOM (/ counts rec item qty found)

  (if (null *ByrneBOM*)

    (progn
      (princ "\nNo existen elementos en el BOM.")
      (princ)
    )

    (progn

      (setq counts nil)

      (foreach rec *ByrneBOM*

        (setq item (car rec))
        (setq qty  (cadr rec))

        (if (setq found (assoc item counts))

          (setq counts
                (subst
                  (list item (+ qty (cadr found)))
                  found
                  counts
                )
          )

          (setq counts
                (cons
                  (list item qty)
                  counts
                )
          )
        )
      )

      (princ
        (strcat
          "\nItems en BOM: "
          (itoa (length counts))
        )
      )

      (princ "\n====================")
      (princ "\nBYRNE BOM")
      (princ "\n====================")

      (foreach rec (reverse counts)

        (princ
          (strcat
            "\n"
            (car rec)
            " : "
            (itoa (cadr rec))
          )
        )

      )

      (princ "\n====================")
      (princ)

    )
  )
)



;=================================================
; BOMTABLE v1.3 (Legacy - Texto Plano Sincronizado)
;=================================================

(defun c:BOMTABLE (/ insPt counts rec item qty found row y)

  (if (null *ByrneBOM*)

    (princ "\nNo existen elementos en el BOM.")

    (progn

      ;; Agrupar cantidades
      (setq counts nil)

      (foreach rec *ByrneBOM*

        (setq item (car rec))
        (setq qty  (cadr rec))

        (if (setq found (assoc item counts))

          (setq counts
                (subst
                  (list item (+ qty (cadr found)))
                  found
                  counts
                )
          )

          (setq counts
                (cons
                  (list item qty)
                  counts
                )
          )
        )
      )

      ;; Punto de inserción
      (setq insPt (getpoint "\nSelecciona punto para la tabla BOM de texto: "))

      ;; Encabezados compactos (Altura 0.06)
      (command "TEXT" insPt 0.06 0 "ITEM")
      (command "TEXT" (list (+ (car insPt) 0.35) (cadr insPt) 0) 0.06 0 "SYMBOLOGY")
      (command "TEXT" (list (+ (car insPt) 1.60) (cadr insPt) 0) 0.06 0 "DESCRIPTION")
      (command "TEXT" (list (+ (car insPt) 2.85) (cadr insPt) 0) 0.06 0 "QTY")

      ;; Filas
      (setq row 1)

      (foreach rec (reverse counts)

        (setq y (- (cadr insPt) (* row 0.12)))

        ;; ITEM
        (command "TEXT" (list (car insPt) y 0) 0.06 0 (itoa row))

        ;; SYMBOLOGY (Espacio en blanco)
        (command "TEXT" (list (+ (car insPt) 0.35) y 0) 0.06 0 "")

        ;; DESCRIPTION
        (command "TEXT" (list (+ (car insPt) 1.60) y 0) 0.06 0 (car rec))

        ;; QTY
        (command "TEXT" (list (+ (car insPt) 2.85) y 0) 0.06 0 (itoa (cadr rec)))

        (setq row (1+ row))

      )

      (princ "\nBOMTABLE de texto creada.")

    )
  )

  (princ)

)



;=================================================
; BOMTABLEPRETTY v1.3.1
; Tabla real de AutoCAD (Texto 0.06 e inserción dinámica)
;=================================================

(defun c:BOMTABLEPRETTY
       (/ doc currentSpace insPt counts rec item qty found
          rows cols row tableObj)

  ;; Verificar BOM
  (if (null *ByrneBOM*)

    (princ "\nNo existen elementos en el BOM.")

    (progn

      ;; =========================
      ;; AGRUPAR CANTIDADES
      ;; =========================

      (setq counts nil)

      (foreach rec *ByrneBOM*
        (setq item (car rec))
        (setq qty  (cadr rec))

        (if (setq found (assoc item counts))
          (setq counts
                (subst
                  (list item (+ qty (cadr found)))
                  found
                  counts
                )
          )
          (setq counts
                (cons
                  (list item qty)
                  counts
                )
          )
        )
      )

      ;; =========================
      ;; PUNTO DE INSERCIÓN
      ;; =========================

      (getpoint "\nSelecciona punto para la tabla BOM: ")
      (setq insPt (getvar "LASTPOINT"))

      ;; =========================
      ;; CONFIGURAR TABLA Y ESPACIO ACTIVO
      ;; =========================

      (setq rows (+ (length counts) 2))
      (setq cols 4)

      (setq doc
            (vla-get-ActiveDocument
              (vlax-get-acad-object)
            )
      )

      ;; DETECCIÓN DE ESPACIO (MODELO VS PAPEL)
      (setq currentSpace
            (if (= (getvar "CVPORT") 1)
              (vla-get-PaperSpace doc)
              (vla-get-ModelSpace doc)
            )
      )

      (setq tableObj
            (vla-AddTable
              currentSpace
              (vlax-3d-point insPt)
              rows
              cols
              0.12          ; Altura de fila reducida (Proporcional a texto 0.06)
              1.0           ; Ancho por defecto temporal
            )
      )

      ;; =========================
      ;; ELIMINAR FILA DE TÍTULO
      ;; =========================

      (vla-DeleteRows tableObj 0 1)

      ;; =========================
      ;; CONFIGURAR TAMAÑO DE TEXTO PROTEGIDO (0.06)
      ;; =========================
      (vla-SetTextHeight tableObj 1 0.06) ; 1 = Tipo de fila Title (Por si se reasigna la fila 0)
      (vla-SetTextHeight tableObj 2 0.06) ; 2 = Tipo de fila Header
      (vla-SetTextHeight tableObj 4 0.06) ; 4 = Tipo de fila Data

      ;; =========================
      ;; ANCHOS DE COLUMNA AJUSTADOS PROPORCIONALMENTE
      ;; =========================
      (vla-SetColumnWidth tableObj 0 0.35) ; ITEM 
      (vla-SetColumnWidth tableObj 1 1.25) ; SYMBOLOGY 
      (vla-SetColumnWidth tableObj 2 1.25) ; DESCRIPTION 
      (vla-SetColumnWidth tableObj 3 0.50) ; QTY 

      ;; =========================
      ;; ENCABEZADOS
      ;; =========================

      (vla-SetText tableObj 0 0 "ITEM")
      (vla-SetText tableObj 0 1 "SYMBOLOGY")    
      (vla-SetText tableObj 0 2 "DESCRIPTION")
      (vla-SetText tableObj 0 3 "QTY")

      ;; =========================
      ;; DATOS
      ;; =========================

      (setq row 1)

      (foreach rec (reverse counts)

        (vla-SetText tableObj row 0 (itoa row))
        (vla-SetText tableObj row 1 "")
        (vla-SetText tableObj row 2 (car rec))
        (vla-SetText tableObj row 3 (itoa (cadr rec)))

        (setq row (1+ row))

      )

      (princ "\nBOMTABLEPRETTY compacta creada con éxito.")

    )
  )

  (princ)

)



;=================================================
; REBUILD BOM
;=================================================

(defun c:REBUILDBOM (/ ss i ent blk part)

  ;; Limpiar BOM actual
  (setq *ByrneBOM* nil)

  ;; Buscar todos los INSERT del dibujo
  (setq ss
        (ssget "_X"
               '((0 . "INSERT"))
        )
  )

  ;; Si no hay bloques
  (if (null ss)

    (princ "\nNo se encontraron bloques.")

    (progn

      (setq i 0)

      (while (< i (sslength ss))

        (setq ent (ssname ss i))

        (setq blk
              (cdr
                (assoc 2
                       (entget ent)
                )
              )
        )

        ;; Buscar bloque en catálogo Byrne
        (if (setq part (assoc blk *ByrneParts*))

          (ByrneAddBOM
            (cdr part)
            1
          )

        )

        (setq i (1+ i))

      )

      (princ "\nBOM reconstruido.")

    )
  )

  (princ)

)



;=================================================
; EXPORTAR BOM A CSV (BOM2CSV - Con Blindaje de Comas)
;=================================================

(defun c:BOM2CSV (/ csvFile fn counts rec item qty found row)

  (if (null *ByrneBOM*)
    (princ "\nNo existen elementos en el BOM para exportar.")
    (progn
      ;; =========================
      ;; AGRUPAR CANTIDADES
      ;; =========================
      (setq counts nil)
      (foreach rec *ByrneBOM*
        (setq item (car rec))
        (setq qty  (cadr rec))
        (if (setq found (assoc item counts))
          (setq counts
                (subst
                  (list item (+ qty (cadr found)))
                  found
                  counts
                )
          )
          (setq counts (cons (list item qty) counts))
        )
      )

      ;; =========================
      ;; CUADRO DE DIÁLOGO GUARDAR
      ;; =========================
      (setq csvFile 
            (getfiled "Guardar BOM de Byrne" "C:\\" "csv" 1)
      )

      (if csvFile
        (progn
          ;; Abrir archivo para escritura
          (setq fn (open csvFile "w"))

          ;; Escribir encabezados separados por coma
          (write-line "ITEM,SYMBOLOGY,DESCRIPTION,QTY" fn)

          ;; =========================
          ;; ESCRIBIR DATOS
          ;; =========================
          (setq row 1)
          (foreach rec (reverse counts)
            ;; Usamos \" alrededor de (car rec) para proteger descripciones que contengan comas
            (write-line
              (strcat (itoa row) ",,\"" (car rec) "\"," (itoa (cadr rec)))
              fn
            )
            (setq row (1+ row))
          )

          ;; Cerrar archivo
          (close fn)
          (princ (strcat "\nBOM exportado exitosamente a: " csvFile))
        )
        (princ "\nExportación cancelada.")
      )
    )
  )
  (princ)
)


(princ "\nByrneBOMTools v2.0 cargado.")
(princ)