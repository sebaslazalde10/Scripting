(defun c:E2XB_4WIN_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_E2XB_4_WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota E2XB 4 WINDOW: ")

  (ByrnePurgeBlock "E2XB_4WIN_REAL")

  (ByrneInsertBlock
    "E2XB_4WIN_REAL"
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

  (princ "\nE2XB 4 WINDOW insertado correctamente.")
  (princ)

)