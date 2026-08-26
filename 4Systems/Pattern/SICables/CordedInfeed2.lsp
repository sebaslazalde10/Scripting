(defun c:CORDPLDPAT2 (/ oldPlineWid cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_POWER_INF" "0, 255, 0")

  ;; Guardar ancho actual
  (setq oldPlineWid (getvar "PLINEWID"))

  ;; Cable de 0.5"
  (setvar "PLINEWID" 2.0)

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
    "CordedEndConnectorPat1"
  )

  (ByrneInsertBlock
    "CordedEndConnectorPat1"
    endPt
  )

  ;; Restaurar ancho anterior
  (setvar "PLINEWID" oldPlineWid)

  (ByrneAddBOM "Corded Power Infeed" 1)

  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nCorded PLD creado correctamente.")
  (princ)
)