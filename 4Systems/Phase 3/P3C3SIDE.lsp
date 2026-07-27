(defun c:P3C3SIDE (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_P3C3SIDE" "242, 103, 34")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota RECEPTACLE C3: ")

  (ByrnePurgeBlock "C3_RECEPTACLE")

  (ByrneInsertBlock
    "C3_RECEPTACLE"
    pause
  )

 
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n C3 RECEPTACLE insertado correctamente.")
  (princ)

)