(defun c:GEN_DEAN2WINDOWACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_2_WINDOW" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN 2 WINDOW: ")

  (ByrnePurgeBlock "DEAN_2_WINDOW")

  (ByrneInsertBlock
    "DEAN_2_WINDOW"
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

  (princ "\nDEAN 2 WINDOW insertado correctamente.")
  (princ)

)