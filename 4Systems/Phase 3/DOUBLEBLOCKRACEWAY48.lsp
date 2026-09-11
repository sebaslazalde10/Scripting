(defun c:P3_DOUBLEBLOCKRACEWAY48 (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_P3_DOUBLEBLOCKRACEWAY48" "0,0,0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota P3_DOUBLEBLOCKRACEWAY48: ")

  (ByrnePurgeBlock "DOUBLEBLOCKPHASE3RACEWAY48")

  (ByrneInsertBlock
    "DOUBLEBLOCKPHASE3RACEWAY48"
    pause
  )


  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)
  
  (princ "\nDOUBLE BLOCK RACEWAY 48 insertado correctamente.")
  (princ)

)

