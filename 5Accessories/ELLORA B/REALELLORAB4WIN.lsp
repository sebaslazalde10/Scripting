(defun c:ELLORA_B_4WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ELLORAB_4_WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ELLORA B 4 WINDOW: ")

  (ByrnePurgeBlock "ELLORAB_4WIN_REAL")

  (ByrneInsertBlock
    "ELLORAB_4WIN_REAL"
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

  (ByrneAddBOM "ELLORA B 4 WINDOW" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nELLORA B 4 WINDOW insertado correctamente.")
  (princ)

)