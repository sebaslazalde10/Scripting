(defun c:MHOB4WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MHO_B" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MHO B: ")

  (ByrnePurgeBlock "MHOB_4_WIN_REAL")

  (ByrneInsertBlock
    "MHOB_4_WIN_REAL"
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

  (princ "\nMHO B 4 WINDOWS insertado correctamente.")
  (princ)

)