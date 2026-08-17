(defun c:MHO_3WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_MHO" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MHO: ")

  (ByrnePurgeBlock "MHO_3_WIN_2_REAL")

  (ByrneInsertBlock
    "MHO_3_WIN_2_REAL"
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

  (princ "\nMHO 3 WINDOWS insertado correctamente.")
  (princ)

)