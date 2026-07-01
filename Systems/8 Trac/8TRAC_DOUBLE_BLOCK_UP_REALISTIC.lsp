(defun c:DBUP8TRACACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_DOUBLE_BLOCK_UP_REALISTIC" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DOUBLE BLOCK: ")

  (ByrnePurgeBlock "8TRAC_DOUBLE_BLOCK_UP_REALISTIC")

  (ByrneInsertBlock
    "8TRAC_DOUBLE_BLOCK_UP_REALISTIC"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DOUBLE BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDOUBLE BLOCK insertado correctamente.")
  (princ)

)