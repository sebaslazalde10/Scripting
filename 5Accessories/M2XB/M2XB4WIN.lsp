(defun c:M2XB4WINACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_M2XB_4WIN" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota M2XB_4WIN: ")

  (ByrnePurgeBlock "M2XB_4_WIN")

  (ByrneInsertBlock
    "M2XB_4_WIN"
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

  (princ "\nM2XB 4 WIN insertado correctamente.")
  (princ)

)