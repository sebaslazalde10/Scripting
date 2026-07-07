(defun c:AXIL_XACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_AXIL_X" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota AXIL_X: ")

  (ByrnePurgeBlock "AXIL_X")

  (ByrneInsertBlock
    "AXIL_X"
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

  (ByrneAddBOM "AXIL X" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nAXIL X insertado correctamente.")
  (princ)

)
