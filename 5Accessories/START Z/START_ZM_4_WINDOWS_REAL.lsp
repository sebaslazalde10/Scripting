(defun c:START_Z_4WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_Z_4_WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START Z 4 WINDOWS: ")

  (ByrnePurgeBlock "START_ZM_4_WINDOWS_REAL")

  (ByrneInsertBlock
    "START_ZM_4_WINDOWS_REAL"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)


  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nStart Z 4 Windows insertado correctamente.")
  (princ)

)
