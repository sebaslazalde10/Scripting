(defun c:RC3SIDEACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_RECEPTACLE_C3_SIDE" "0, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUPLEX RECEPTACLE C3: ")

  (ByrnePurgeBlock "8TRAC_RECEPTACLE_C3_SIDE")

  (ByrneInsertBlock
    "8TRAC_RECEPTACLE_C3_SIDE"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DUPLEX RECEPTACLE C3" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDUPLEX RECEPTACLE C3 insertado correctamente.")
  (princ)

)