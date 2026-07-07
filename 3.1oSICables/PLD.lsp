(defun c:PLD (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_POWER_INF" "0, 255, 0")

  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

  (setvar "CECOLOR" "RGB: 0, 255, 0")
  (setvar "CELWEIGHT" 0)
  
 (setq startPt (getpoint "\nPunto inicial: "))

(command "_.PLINE"
         startPt
         "_W"
         2.0
         2.0
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
    "hardwiredPowerInfeedConnectorEnd_SOURCE"
  )

  (ByrneInsertBlock
    "hardwiredPowerInfeedConnectorEnd_SOURCE"
    endPt
  )

  (ByrneAddBOM "Power Infeed" 1)

  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nPLD creado correctamente.")
  (princ)
)