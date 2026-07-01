(defun c:PINECONEBLOCKACC (/)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_PINECONE_BLOCK" "30")

  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================

  (prompt "\nInserta y rota PINECONE BLOCK: ")

  (ByrnePurgeBlock "PINECONE_BLOCK")

  (ByrneInsertBlock
    "PINECONE_BLOCK"
    pause
  )


  

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "PINECONE CONNECTION BLOCK" 1)

  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================

  (ByrneEnd)

  (princ "\nPINECONE CONNECTION BLOCK insertado correctamente.")
  (princ)

)