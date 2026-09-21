(defun c:BURELE_UP (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_BURELE" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota BURELE: ")

  (ByrnePurgeBlock "BURELE")

  (ByrneInsertBlock
    "BURELE"
    pause
  )


  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nBURELE insertado correctamente.")
  (princ)

)

