(defun c:MMCONNECTUPACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MM_CONNECTOR_UP" "147, 39, 143")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota M/M Jumper: ")

  (ByrnePurgeBlock "MM_CONNECTOR_UP")

  (ByrneInsertBlock
    "MM_CONNECTOR_UP"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "M/M Jumper" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nM/M Jumper insertado correctamente.")
  (princ)

)