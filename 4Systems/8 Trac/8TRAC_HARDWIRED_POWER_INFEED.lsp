(defun c:PLD8TRACSIDECABLE (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_POWER_INFEED" "0, 255, 0")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "InfeedBeginSide"
  )

  (ByrneInsertBlock
    "InfeedBeginSide"
    startPt
  )


  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

(setvar "CECOLOR" "RGB:0, 255, 0")
  (setvar "CELWEIGHT" 0)
  
  (command "_.PLINE" startPt
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

  ;;(ByrneAddBOM "HARDWIRED POWER INFEED" 1)

   Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nHARDWIRED POWER INFEED creado correctamente.")
  (princ)
)