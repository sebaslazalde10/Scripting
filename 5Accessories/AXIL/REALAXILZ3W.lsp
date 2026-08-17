(defun c:AXILZ3WINREAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_AXIL_Z_3_WIN" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota AXIL Z 3 WIN: ")

  (ByrnePurgeBlock "AXIL_Z_3_WIN")

  (ByrneInsertBlock
    "AXIL_Z_3_WIN"
    pause
  )

  (setq startPt
      (getpoint
        "\nSelecciona punto de salida del cord: "
      )
)

  (ByrneGenericCord startPt)

  (ByrneEnd)

  (princ "\nAxil Z 3 Win insertado correctamente.")
  (princ)

)

