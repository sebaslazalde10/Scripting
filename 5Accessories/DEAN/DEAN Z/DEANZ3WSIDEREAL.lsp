(defun c:DEANZ3WSIDEREAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_Z_3_W" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN_Z_3_W: ")

  (ByrnePurgeBlock "DEAN_Z_3_WINDOW_SIDE_REAL")

  (ByrneInsertBlock
    "DEAN_Z_3_WINDOW_SIDE_REAL"
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

  (princ "\nDEAN Z 3 WINDOW SIDE REAL insertado correctamente.")
  (princ)

)