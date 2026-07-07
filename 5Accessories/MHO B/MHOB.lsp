(defun c:MHOBACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MHO_B" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MHO B: ")

  (ByrnePurgeBlock "MHOB")

  (ByrneInsertBlock
    "MHOB"
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

  (ByrneAddBOM "MHO B" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nMHO B insertado correctamente.")
  (princ)

)