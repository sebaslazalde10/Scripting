(defun c:START_UM_2WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_UM_2_WIN " "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START UM 2 WINDOW: ")

  (ByrnePurgeBlock "START_UM_2_WIN_REAL")

  (ByrneInsertBlock
    "START_UM_2_WIN_REAL"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  (ByrneEnd)

  (princ "\nSTART_UM_2_WIN_REAL insertado correctamente.")
  (princ)

)
