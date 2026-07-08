(defun c:DEAN4SURFACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DEAN_4_W_IN_SURFACE" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DEAN_4_W_IN_SURFACE: ")

  (ByrnePurgeBlock "DEAN_4_W_IN_SURFACE")

  (ByrneInsertBlock
    "DEAN_4_W_IN_SURFACE"
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

  (ByrneAddBOM "DEAN 4 WINDOWS IN-SURFACE" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nDEAN_4_W_IN_SURFACE insertado correctamente.")
  (princ)

)