(defun c:RC4SIDEACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_RECEPTACLE_C4_SIDE" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUPLEX RECEPTACLE C4: ")

  (ByrnePurgeBlock "8TRAC_RECEPTACLE_C4_SIDE")

  (ByrneInsertBlock
    "8TRAC_RECEPTACLE_C4_SIDE"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DUPLEX RECEPTACLE C4" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDUPLEX RECEPTACLE C4 insertado correctamente.")
  (princ)

)