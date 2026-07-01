(defun c:8TRACK_DOUBLE_HALFBLOCK_SIDE_REALISTICACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRACK_DOUBLE_HALFBLOCK_SIDE_REALISTIC" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DOUBLE HALF BLOCK: ")

  (ByrnePurgeBlock "8TRACK_DOUBLE_HALFBLOCK_SIDE_REALISTIC")

  (ByrneInsertBlock
    "8TRACK_DOUBLE_HALFBLOCK_SIDE_REALISTIC"
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