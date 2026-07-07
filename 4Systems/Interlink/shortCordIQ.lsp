;=================================================
; SCIQ.lsp
; Inserta un Short Cord IQ
;=================================================

(defun c:SCIQ ()

  ;; =========================
  ;; INSERTAR SHORT CORD
  ;; =========================

  (prompt "\nInserta y rota SHORT CORD: ")

  (ByrnePurgeBlock "SHORT_CORD_2")

  (ByrneInsertBlock
    "SHORT_CORD_2"
    pause
  )

  (princ "\nSHORT_CORD insertado correctamente.")
  (princ)

)

(princ "\nSCIQ cargado.")
(princ)