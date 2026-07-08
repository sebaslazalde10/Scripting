(defun c:RC4UPACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_RECEPTACLE_C4_UP" "255, 127, 0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUPLEX RECEPTACLE C4: ")

  (ByrnePurgeBlock "8TRAC_RECEPTACLE_C4_UP")

  (ByrneInsertBlock
    "8TRAC_RECEPTACLE_C4_UP"
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