(defun c:ROLLEDCONNECTORCABLE (/ startPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_ROLLED_CONNECTOR" "255, 255, 255")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota ROLLED_CONNECTOR: ")

  (ByrnePurgeBlock "ROLLED_CONNECTOR")

  (ByrneInsertBlock
    "ROLLED_CONNECTOR"
    pause
  )

  
 
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nCable insertado correctamente.")
  (princ)

)