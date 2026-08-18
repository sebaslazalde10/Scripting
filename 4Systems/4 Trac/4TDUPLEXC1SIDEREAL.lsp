(defun c:RC1_4TDUPLEXSIDE_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4TRAC_DUPLEX_RECEPTACLE_C1" "255, 255, 0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota 4 TRAC DUPLEX RECEPTACLE C1: ")

  (ByrnePurgeBlock "4T_C1_DUPLEX_RECEPTACLE_UP_REAL")

  (ByrneInsertBlock
    "4T_C1_DUPLEX_RECEPTACLE_UP_REAL"
    pause
  )



  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n4trac DUPLEX RECEPTACLE C1 insertado correctamente.")
  (princ)

)