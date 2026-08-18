(defun c:REALCORDED_PLD4TCABLE (/ startPt cableEnt endPt oldWidth)

  ;; Guardar ancho previo y definir nuevo ancho
  (setq oldWidth (getvar "PLINEWID"))
  (setvar "PLINEWID" 1.0)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4T_PLD" "0,255,0")

  ;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
  (setq startPt (getpoint "\nSelecciona el punto de inicio: "))
  (ByrnePurgeBlock "4T_CORDED_PLD_REAL")
  (ByrneInsertBlock "4T_CORDED_PLD_REAL" startPt)

  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================
  ;; Se pasa únicamente el startPt; el ancho ya está predefinido en PLINEWID
  (command "_.PLINE" startPt)

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  ;; Obtener polyline
  (setq cableEnt (entlast))

  ;; =========================
  ;; OBTENER ENDPOINT E INSERTAR FINAL
  ;; =========================
  (setq endPt (ByrneGetEndPoint cableEnt))

  (ByrnePurgeBlock "CordedEndConnector2")
  (ByrneInsertBlock "CordedEndConnector2" endPt)

  ;; Restaurar entorno y variables
  (setvar "PLINEWID" oldWidth)
  (ByrneEnd)

  (princ "\n4T Corded Power Entry creado correctamente.")
  (princ)
)