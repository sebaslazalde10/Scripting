(defun c:START_Z_3WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_Z_3_WIN" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START_Z_3_WIN: ")

  (ByrnePurgeBlock "START_Z_3_WIN")

  (ByrneInsertBlock
    "START_Z_3_WIN"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "START Z 3 WINDOWS" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n START Z 3 WINDOWS  insertado correctamente.")
  (princ)

)