(defun c:START_EM_2WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_EM_2_WIN " "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START EM 2 WINDOW: ")

  (ByrnePurgeBlock "START_EM_2_WIN")

  (ByrneInsertBlock
    "START_EM_2_WIN"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  (ByrneEnd)

  (princ "\nSTART_EM_2_WIN insertado correctamente.")
  (princ)

)
