(defun c:DEAN_2_W_IN_SURFACE_TOPVIEW_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_2_W_TOP" "255 ,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN Z 2 W TOP VIEW: ")

  (ByrnePurgeBlock "DEAN_2_W_IN_SURFACE_TOPVIEW")

  (ByrneInsertBlock
    "DEAN_2_W_IN_SURFACE_TOPVIEW"
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

  (princ "\nDEAN 2 WINDOWS IN SURFACE TOP V insertado correctamente.")
  (princ)

)

