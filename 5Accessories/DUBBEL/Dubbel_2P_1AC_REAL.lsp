(defun c:DUBBEL2P1ACREAL (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_DUBBEL_2P_1AC" "255, 0, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota DUBBEL 2P 1AC: ")

  (ByrnePurgeBlock "DUBBEL_2P_1AC_REAL")

  (ByrneInsertBlock
    "DUBBEL_2P_1AC_REAL"
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

  (princ "\nDUBBEL 2P 1AC insertado correctamente.")
  (princ)

)