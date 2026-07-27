(defun c:STARTZ2WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_START_Z_2_WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota START Z 2 WINDOWS: ")

  (ByrnePurgeBlock "START_Z_2_WIN")

  (ByrneInsertBlock
    "START_Z_2_WIN"
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

  (princ "\nStart Z 2 Windows insertado correctamente.")
  (princ)

)
