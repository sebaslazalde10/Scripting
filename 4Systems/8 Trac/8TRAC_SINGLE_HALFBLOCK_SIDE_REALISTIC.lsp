(defun c:8TSINGLEHBSIDEACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_SINGLE_HALFBLOCK" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota 8 TRAC SINGLE HALFBLOCK: ")

  (ByrnePurgeBlock "8TRAC_SINGLE_HALFBLOCK_SIDE_REALISTIC")

  (ByrneInsertBlock
    "8TRAC_SINGLE_HALFBLOCK_SIDE_REALISTIC"
    pause
  )



  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n8 TRAC SINGLE HALFBLOCK insertado correctamente.")
  (princ)

)






