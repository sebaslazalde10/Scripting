(defun c:FFJUMP (/ startPt endPt cableEnt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_FFJUMP" "144")

  ;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================

  (prompt "\nInserta y rota el conector inicial: ")

  (ByrnePurgeBlock "FFJumperEnd")

  (ByrneInsertBlock
    "FFJumperEnd"
    pause
  )

  ;; Obtener punto inicial
  (setq startPt (getvar "LASTPOINT"))

  ;; =========================
  ;; INICIAR POLYLINE
  ;; =========================

  (command "_.PLINE" startPt)

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  ;; Obtener polyline
  (setq cableEnt (entlast))

  ;; Mandar cable hacia atrás
  (ByrneSendToBack cableEnt)

  ;; =========================
  ;; OBTENER ENDPOINT
  ;; =========================

  (setq endPt
        (ByrneGetEndPoint cableEnt)
  )

  ;; =========================
  ;; INSERTAR CONECTOR FINAL
  ;; =========================

  (prompt "\nRota el conector final: ")

  (ByrneInsertBlock
    "FFJumperEnd"
    endPt
  )

   (ByrneAddBOM "FF Jumper" 1)

  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nFF Jumper creado correctamente.")
  (princ)
)