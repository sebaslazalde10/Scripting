(defun c:DEAN3WZREAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_3_W_Z_REAL" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN Z 3 W: ")

  (ByrnePurgeBlock "DEAN_Z_3_WINDOW_REAL")

  (ByrneInsertBlock
    " DEAN_Z_3_WINDOW_REAL "
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

  (princ "\nDEAN Z 3 W insertado correctamente.")
  (princ)

)

