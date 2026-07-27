(defun c:MHOB3WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MHO_B_3_WIN" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MHO B 3 WINDOWS: ")

  (ByrnePurgeBlock "MHOB_3_WIN")

  (ByrneInsertBlock
    "MHOB_3_WIN"
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


  (ByrneEnd)

  (princ "\nMHO B 3 WINDOWS insertado correctamente.")
  (princ)

)