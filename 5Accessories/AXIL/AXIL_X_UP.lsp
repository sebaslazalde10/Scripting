(defun c:AXIL_X_TOP (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_AXIL X_REAL_UP" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota AXIL X_REAL_UP: ")

  (ByrnePurgeBlock "AXIL X_REAL_UP")

  (ByrneInsertBlock
    "AXIL X_REAL_UP"
    pause
  )


  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nAXIL X insertado correctamente.")
  (princ)

)

