(defun c:NODE_UP_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_NODE" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota NODE: ")

  (ByrnePurgeBlock "NODE_UP")

  (ByrneInsertBlock
    "NODE_UP"
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

  (princ "\nNODE insertado correctamente.")
  (princ)

)

