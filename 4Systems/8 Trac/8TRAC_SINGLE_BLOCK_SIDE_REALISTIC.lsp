(defun c:8TRAC_SINGLE_BLOCK_SIDE_REALISTICACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_SINGLE_BLOCK_SIDE_REALISTIC" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota SINGLE BLOCK: ")

  (ByrnePurgeBlock "8TRAC_SINGLE_BLOCK_SIDE_REALISTIC")

  (ByrneInsertBlock
    "8TRAC_SINGLE_BLOCK_SIDE_REALISTIC"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "SINGLE BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nSINGLE BLOCK insertado correctamente.")
  (princ)

)