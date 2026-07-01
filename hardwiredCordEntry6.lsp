(defun c:PLD (/ cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_POWER_INF" "0, 255, 0")

  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

  (command "_.PLINE")

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