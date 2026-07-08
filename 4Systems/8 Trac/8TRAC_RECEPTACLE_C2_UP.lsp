(defun c:RC2UPACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_RECEPTACLE_C2_UP" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUPLEX RECEPTACLE C2: ")

  (ByrnePurgeBlock "8TRAC_RECEPTACLE_C2_UP")

  (ByrneInsertBlock
    "8TRAC_RECEPTACLE_C2_UP"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DUPLEX RECEPTACLE C2" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDUPLEX RECEPTACLE C2 insertado correctamente.")
  (princ)

)