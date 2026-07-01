(defun c:ELLORAB5WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ELLORA_B_5_WIN" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ELLORA B 5 WINDOW: ")

  (ByrnePurgeBlock "ELLORAB5WIN")

  (ByrneInsertBlock
    "ELLORAB5WIN"
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

  (ByrneAddBOM "ELLORA B 5 WINDOW" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nELLORA B 5 WINDOW insertado correctamente.")
  (princ)

)