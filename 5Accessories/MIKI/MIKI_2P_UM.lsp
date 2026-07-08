(defun c:MIKI2PSUMACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "MIKI_2PORTS_UM" "255,0,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota MIKI 2 PORTS UM: ")

  (ByrnePurgeBlock "MIKI_2PORTS_UM")

  (ByrneInsertBlock
    "MIKI_2PORTS_UM"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "MIKI 2 PORTS UNDER MOUNT" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\n MIKI 2 PORTS UNDER MOUNT insertado correctamente.")
  (princ)

)