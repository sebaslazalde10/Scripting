(defun c:DEAN_Z_4W_2P_2AC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN__Z_4_W" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN_Z_4_W: ")

  (ByrnePurgeBlock "DEAN_4_W_IN_SURFACE_2P_2AC_REAL")

  (ByrneInsertBlock
    "DEAN_4_W_IN_SURFACE_2P_2AC_REAL"
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

  (princ "\nDEAN_Z_4_W_2P_2AC_REAL insertado correctamente.")
  (princ)

)