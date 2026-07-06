(defun c:P3DBSIDEACC ()
 
  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_P3_DOUBLE_BLOCK" "255, 255, 255")
 
  ;; =========================
  ;; INSERTAR ACCESORIO
  ;; =========================
 
  (prompt "\nInserta y rota PHASE 3 DOUBLE BLOCK: ")
 
  (ByrnePurgeBlock "DOUBLEBLOCKPHASE3")
 
  (ByrneInsertBlock
    "DOUBLEBLOCKPHASE3"
    pause
  )
 
 
  ;; =========================
  ;; RESTAURAR ENTORNO
  ;; =========================
 
  (ByrneEnd)
 
  (princ "\nDouble Block insertado correctamente.")
  (princ)
 
)
