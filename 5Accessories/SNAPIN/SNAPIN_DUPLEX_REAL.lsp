(defun c:SNAPINDUPX_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_SNAPIN_DUPLEX_REAL" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota SNAPIN DUPLEX REAL: ")

  (ByrnePurgeBlock "SNAPIN_DUPLEX_REAL")

  (ByrneInsertBlock
    "SNAPIN_DUPLEX_REAL"
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

  (princ "\nSNAPIN DUPLEX REAL insertado correctamente.")
  (princ)

)