(defun c:ELLORA_WELL_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ELLORA_WELL" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ELLORA WELL: ")

  (ByrnePurgeBlock "ELLORA_WELL")

  (ByrneInsertBlock
    "ELLORA_WELL"
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

  (princ "\nELLORA_WELL insertado correctamente.")
  (princ)

)

