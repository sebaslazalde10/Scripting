(defun c:M2X_4WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_M2X_4WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota M2X_4WIN: ")

  (ByrnePurgeBlock "M2X_4_WIN_REAL")

  (ByrneInsertBlock
    "M2X_4_WIN_REAL"
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

  (princ "\nM2X 4 WIN insertado correctamente.")
  (princ)

)