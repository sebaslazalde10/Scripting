(defun c:4TDUPLEXSIDEACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4TRAC_DUPLEX_RECEPTACLE" "255, 255, 0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota 4 TRAC DUPLEX RECEPTACLEE: ")

  (ByrnePurgeBlock "4T_DUPLEX_RECEPTACLE_SIDE")

  (ByrneInsertBlock
    "4T_DUPLEX_RECEPTACLE_SIDE"
    pause
  )



  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n4trac DUPLEX RECEPTACLE insertado correctamente.")
  (princ)

)