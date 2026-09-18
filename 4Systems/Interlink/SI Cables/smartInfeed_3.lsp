(defun c:SMI
       (/ startPt
          cable1
          cable2
          midPt
          endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_SMI" "0, 0, 0")

  ;; =========================
  ;; TERMINAL INICIAL
  ;; =========================

  (ByrnePurgeBlock "SMART_INFEED")
  (ByrnePurgeBlock "EndBlackConnector")
  (ByrnePurgeBlock "BlackEndTerminal")

  (prompt "\nInserta y rota Black End Terminal: ")

  (ByrneInsertBlock
    "BlackEndTerminal"
    pause
  )

  (setq startPt (getvar "LASTPOINT"))

  ;; =========================
  ;; CABLE 1
  ;; =========================

  (setvar "CECOLOR" "250")
  (setvar "CELWEIGHT" 0)

  (command "_.PLINE" 
		startPt
		"_W"
		1.0
		1.0
  )

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  (setq cable1 (entlast))

  (ByrneSendToBack cable1)

  ;; Endpoint cable 1

  (setq midPt
        (ByrneGetEndPoint cable1)
  )

  ;; =========================
  ;; SMART INFEED
  ;; =========================

  (prompt "\nInserta y rota SMART INFEED: ")

  (ByrneInsertBlock
    "SMART_INFEED"
    midPt
  )

  ;; =========================
  ;; CABLE 2
  ;; =========================

  (command "_.PLINE" 
		midPt
		"_w"
		1.0
		1.0
  )

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  (setq cable2 (entlast))

  (ByrneSendToBack cable2)

  ;; Endpoint cable 2

  (setq endPt
        (ByrneGetEndPoint cable2)
  )

  ;; =========================
  ;; CONECTOR FINAL
  ;; =========================

  (prompt "\nInserta y rota End Black Connector: ")

  (ByrneInsertBlock
    "EndBlackConnector"
    endPt
  )

  (ByrneAddBOM "Smart Infeed" 1)

  ;; Restaurar entorno Byrne

  (ByrneEnd)

  (princ "\nSmart Infeed creado correctamente.")
  (princ)
)