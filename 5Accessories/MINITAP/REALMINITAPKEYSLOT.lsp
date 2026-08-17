(defun c:MINITAP_KEY_ACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MINITAP" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MINITAP KEY MOUNT: ")

  (ByrnePurgeBlock "MINITAP_KEY_SLOT_2")

  (ByrneInsertBlock
    "MINITAP_KEY_SLOT_2"
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

  (ByrneAddBOM "MINITAP" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nMINITAP KEY SLOT insertado correctamente.")
  (princ)

)