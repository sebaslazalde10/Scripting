(defun c:GEN_MINITAPACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MINITAP" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MINITAP: ")

  (ByrnePurgeBlock "MINITAP_4")

  (ByrneInsertBlock
    "MINITAP_4"
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

  (princ "\nMINITAP insertado correctamente.")
  (princ)

)