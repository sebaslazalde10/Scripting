(defun c:WHITEBLOCKACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_WHITE_BLOCK" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota WHITE BLOCK: ")

  (ByrnePurgeBlock "WHITE_BLOCK")

  (ByrneInsertBlock
    "WHITE_BLOCK"
    pause
  )

  
  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "WHITE CONNECTION BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nWHITE CONNECTION BLOCK insertado correctamente.")
  (princ)

)