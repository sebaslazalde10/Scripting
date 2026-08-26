(defun c:DEAN_Z_2W_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN__Z_2_W" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN_Z_2_W: ")

  (ByrnePurgeBlock "DEAN_Z_2_WINDOW_REAL")

  (ByrneInsertBlock
    "DEAN_Z_2_WINDOW_REAL"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "DEAN Z 2 WINDOW" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDEAN_Z_2_WINDOW_REAL insertado correctamente.")
  (princ)

)