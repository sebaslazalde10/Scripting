(defun c:STARTACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START: ")

  (ByrnePurgeBlock "START")

  (ByrneInsertBlock
    "START"
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

  (ByrneAddBOM "START" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nSTART insertado correctamente.")
  (princ)

)