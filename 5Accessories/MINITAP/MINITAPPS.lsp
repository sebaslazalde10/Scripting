(defun c:MINITAPSLIDEACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MINITAP" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MINITAP: ")

  (ByrnePurgeBlock "MINITAP_SLIDE_MOUNT_2")

  (ByrneInsertBlock
    "MINITAP_SLIDE_MOUNT_2"
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

  (princ "\nMINITAP SLIDE MOUNT insertado correctamente.")
  (princ)

)