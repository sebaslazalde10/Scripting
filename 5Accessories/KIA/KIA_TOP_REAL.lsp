(defun c:KIA_TOP_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_KIA" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota KIA TOP: ")

  (ByrnePurgeBlock "KIA_TOP")

  (ByrneInsertBlock
    "KIA_TOP"
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

  (princ "\nKIA_TOP insertado correctamente.")
  (princ)

)

