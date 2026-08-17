(defun c:PLD4TCABLE (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4T_PLD" "0,255,0")

  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

  (setvar "CECOLOR" "RGB: 0,255,0")
  (setvar "CELWEIGHT" 0)
  
 (setq startPt (getpoint "\nPunto inicial: "))

(command "_.PLINE"
         startPt
         "_W"
         0.5
         0.5
)

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  ;; Obtener polyline
  (setq cableEnt (entlast))

  ;; =========================
  ;; OBTENER ENDPOINT
  ;; =========================

  (setq endPt
        (ByrneGetEndPoint cableEnt)
  )

  ;; =========================
  ;; INSERTAR CONECTOR FINAL
  ;; =========================

  (ByrnePurgeBlock
    "4T_Hardwired"
  )

  (ByrneInsertBlock
    "4T_Hardwired"
    endPt
  )

 
  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n 4T Power Infeed creado correctamente.")
  (princ)
)
