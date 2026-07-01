(defun c:HCONNNACC (/ )

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_HCONNECTOR" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota HCONNECTOR: ")

  (ByrnePurgeBlock "HCONNECTOR")

  (ByrneInsertBlock
    "HCONNECTOR"
    pause
  )

  
  

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "H-CONNECTOR" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nH-CONNECTOR insertado correctamente.")
  (princ)

)