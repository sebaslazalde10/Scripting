(defun c:KIA_SIDE_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_KIA" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota KIA SIDE: ")

  (ByrnePurgeBlock "KIA_SIDE")

  (ByrneInsertBlock
    "KIA_SIDE"
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

  (princ "\nKIA_SIDE insertado correctamente.")
  (princ)

)

