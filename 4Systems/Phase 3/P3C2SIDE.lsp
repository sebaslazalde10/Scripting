(defun c:P3C2SIDE (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_P3C2SIDE" "242, 103, 34")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota RECEPTACLE C2: ")

  (ByrnePurgeBlock "C2_RECEPTACLE")

  (ByrneInsertBlock
    "C2_RECEPTACLE"
    pause
  )

 
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n RECEPTACLE C2 insertado correctamente.")
  (princ)

)