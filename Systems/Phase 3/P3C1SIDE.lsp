(defun c:P3C1SIDE (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_P3C1SIDE" "241, 235, 31")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota RECEPTACLE C1: ")

  (ByrnePurgeBlock "C1_RECEPTACLE")

  (ByrneInsertBlock
    "C1_RECEPTACLE"
    pause
  )

 
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n RECEPTACLE C1 insertado correctamente.")
  (princ)

)