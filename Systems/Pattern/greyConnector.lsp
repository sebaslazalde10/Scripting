(defun c:GREYBLOCKACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_GREYBLOCK" "99, 100, 102")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota GREY BLOCK: ")

  (ByrnePurgeBlock "GREY_BLOCK")

  (ByrneInsertBlock
    "GREY_BLOCK"
    pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "GREY CONNECTION BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nGREY CONNECTION BLOCK insertado correctamente.")
  (princ)

)