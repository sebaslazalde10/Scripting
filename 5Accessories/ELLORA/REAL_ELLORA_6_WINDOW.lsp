(defun c:ELLORA_6_WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ELLORA_6_WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ELLORA 6 WINDOW: ")

  (ByrnePurgeBlock "ELLORA_6WIN_REAL")

  (ByrneInsertBlock
    "ELLORA_6WIN_REAL"
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

  (princ "\nELLORA 6 WINDOW insertado correctamente.")
  (princ)

)