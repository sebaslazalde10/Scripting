(defun c:MHO_4WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MHO" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MHO: ")

  (ByrnePurgeBlock "MHO_4_WIN_REAL")

  (ByrneInsertBlock
    "MHO_4_WIN_REAL"
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

  (princ "\nMHO 4 WINDOWS insertado correctamente.")
  (princ)

)