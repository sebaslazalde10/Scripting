(defun c:BLACKBLOCKACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_BLACK_BLOCK" "0, 0, 0 ")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota BLACK BLOCK: ")

  (ByrnePurgeBlock "BLACK_BLOCK")

  (ByrneInsertBlock
    "BLACK_BLOCK"
    pause
  )


  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "BLACK CONNECTION BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nBLACK CONNECTION BLOCK insertado correctamente.")
  (princ)

)