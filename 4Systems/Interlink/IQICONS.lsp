(defun c:IQICONS (/ startPt)


  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota IQ ICONS CORD: ")

  (ByrnePurgeBlock "IQACCESSORIES")

  (ByrneInsertBlock
    "IQACCESSORIES"
    pause
  )


  (princ "\nIQ ICONS insertado correctamente.")
  (princ)

)