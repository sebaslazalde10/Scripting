(defun c:24BLOCKSIDEACC (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_PHASE3_24_BLOCK" "255,255,255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota 24 BLOCK SIDE VIEW: ")

  (ByrnePurgeBlock "SINGLEBLOCKPHASE3")

  (ByrneInsertBlock
    "SINGLEBLOCKPHASE3"
    pause
  )



  (ByrneEnd)

  (princ "\nSINGLE BLOCK PHASE 3 insertado correctamente.")
  (princ)

)
