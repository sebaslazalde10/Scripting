(defun c:NODE_SIDEACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_NODE" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota NODE_SIDE: ")

  (ByrnePurgeBlock "NODE_SIDE")

  (ByrneInsertBlock
    "NODE_SIDE"
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