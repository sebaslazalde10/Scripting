(defun c:R2R_4T (/ )

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_RCP_2_RCP_CONNECTOR" "255,0 ,0")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota RECEPTACLE TO RECEPTACLE CONNECTOR: ")

  (ByrnePurgeBlock "4T_RCP_TO_RCP")

  (ByrneInsertBlock
    "4T_RCP_TO_RCP"
    pause
  )
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nRCP 2 RCP Connector insertado correctamente.")
  (princ)

)