(defun c:8TRAC_DOUBLE_HALFBLOCK_UP_REALISTICACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_DOUBLE_HALFBLOCK_UP_REALISTIC" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DOUBLE HALF BLOCK: ")

  (ByrnePurgeBlock "8TRAC_DOUBLE_HALFBLOCK_UP_REALISTIC")

  (ByrneInsertBlock
    "8TRAC_DOUBLE_HALFBLOCK_UP_REALISTIC"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DOUBLE HALF BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDOUBLE HALF BLOCK insertado correctamente.")
  (princ)

)