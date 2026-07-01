(defun c:8TRAC_H_CONNECTORACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8TRAC_H_CONNECTOR" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota H CONNECTOR: ")

  (ByrnePurgeBlock "8TRAC_H_CONNECTOR")

  (ByrneInsertBlock
    "8TRAC_H_CONNECTOR"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "H CONNECTOR" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nH CONNECTOR insertado correctamente.")
  (princ)

)