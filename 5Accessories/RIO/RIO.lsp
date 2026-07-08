(defun c:RIOACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_RIO" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota RIO: ")

  (ByrnePurgeBlock "RIO")

  (ByrneInsertBlock
    "RIO"
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

  (ByrneAddBOM "RIO" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nRIO insertado correctamente.")
  (princ)

)