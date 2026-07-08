(defun c:RC1SIDEACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_RECEPTACLE_C1_SIDE" "255, 255, 0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUPLEX RECEPTACLE C1: ")

  (ByrnePurgeBlock "8TRAC_RECEPTACLE_C1_SIDE")

  (ByrneInsertBlock
    "8TRAC_RECEPTACLE_C1_SIDE"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DUPLEX RECEPTACLE C1" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDUPLEX RECEPTACLE C1 insertado correctamente.")
  (princ)

)