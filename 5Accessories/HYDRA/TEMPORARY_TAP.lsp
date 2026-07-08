(defun c:TEMPORARYTAPACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_HYDRA" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota TEMPORARY TAP: ")

  (ByrnePurgeBlock "HYDRA_SMALL")

  (ByrneInsertBlock
    "HYDRA_SMALL"
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

  (ByrneAddBOM "HYDRA" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nTEMPORARY TAP/HYDRA insertado correctamente.")
  (princ)

)