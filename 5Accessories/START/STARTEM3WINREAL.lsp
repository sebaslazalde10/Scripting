(defun c:START_EM_3WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_EM_3_WIN" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START EM 3 WIN: ")

  (ByrnePurgeBlock "START_EM_3_WIN")

  (ByrneInsertBlock
    "START_EM_3_WIN"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  (ByrneEnd)

  (princ "\nSTART EM 3 WIN insertado correctamente.")
  (princ)

)
