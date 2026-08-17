(defun c:NAICA_4W_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_NAICA_4_WINDOW" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota NAICA 4 WINDOW: ")

  (ByrnePurgeBlock "NAICA_4W")

  (ByrneInsertBlock
    "NAICA_4W"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  (ByrneEnd)

  (princ "\nNAICA 4 W insertado correctamente.")
  (princ)

)

