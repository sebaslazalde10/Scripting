(defun c:DEAN_UM_3WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_UM_3_WIN" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN_UM_3_WIN: ")

  (ByrnePurgeBlock "DEAN_UM_3_WINDOW_REAL")

  (ByrneInsertBlock
    "DEAN_UM_3_WINDOW_REAL"
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

  (princ "\nDEAN 3 WINDOW UM insertado correctamente.")
  (princ)

)