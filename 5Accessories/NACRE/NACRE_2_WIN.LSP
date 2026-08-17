(defun c:NACRE_2WINACC_REAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_NACRE_2_WINDOW" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota NACRE 2 WINDOW: ")

  (ByrnePurgeBlock "NACRE_2_PORT")

  (ByrneInsertBlock
    "NACRE_2_PORT"
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

  (ByrneAddBOM "NACRE 2 WINDOW" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nNACRE 2 WINDOW insertado correctamente.")
  (princ)

)