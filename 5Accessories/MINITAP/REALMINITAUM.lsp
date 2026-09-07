(defun c:MINITAP_UM_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MINITAP" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MINITAP UNDER MOUNT: ")

  (ByrnePurgeBlock "MINITAP_UM_REAL")

  (ByrneInsertBlock
    "MINITAP_UM_REAL"
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

  (princ "\nMINITAP UNDER MOUNT insertado correctamente.")
  (princ)

)