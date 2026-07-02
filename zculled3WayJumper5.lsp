(defun c:3WAYJUMP (/ startPt endPt cableEnt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_3WAY" "144")

  ;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================

  (prompt "\nInserta y rota el conector inicial 3WAY: ")

  (ByrnePurgeBlock "3WayJumperEnd")

  (ByrneInsertBlock
    "3WayJumperEnd"
    pause
  )

  ;; Obtener punto inicial DESPUÉS de rotar
  (setq startPt (getvar "LASTPOINT"))

  ;; =========================
  ;; INICIAR POLYLINE
  ;; =========================

  (command "_.PLINE" startPt)

  ;; Mantener dinámica hasta ENTER
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

  (ByrneAddBOM "3-Way Jumper" 1)

  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n3-Way Jumper creado correctamente.")
  (princ)
)