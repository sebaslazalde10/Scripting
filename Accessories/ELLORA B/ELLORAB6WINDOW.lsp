(defun c:ELLORAB6WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ELLORA_B_6_WIN" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ELLORA B 6 WINDOW: ")

  (ByrnePurgeBlock "ELLORAB6WIN")

  (ByrneInsertBlock
    "ELLORAB6WIN"
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

  (ByrneAddBOM "ELLORA B 6 WINDOW" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nELLORA B 6 WINDOW insertado correctamente.")
  (princ)

)