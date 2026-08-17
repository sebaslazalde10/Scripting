(defun c:4TTRIPLEXUPACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4TRAC_TRIPLEX_RECEPTACLE" "0, 0, 0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota 4 TRAC TRIPLEX RECEPTACLEE: ")

  (ByrnePurgeBlock "4T_TRIPLEX_RECEPTACLE_SIDE")

  (ByrneInsertBlock
    "4T_TRIPLEX_RECEPTACLE_SIDE"
    pause
  )



  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n4trac TRIPLEX RECEPTACLE insertado correctamente.")
  (princ)

)