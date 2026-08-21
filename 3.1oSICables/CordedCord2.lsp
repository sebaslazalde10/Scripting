(defun c:CRDBYRNE (/ startPt oldPlineWid cableEnt endPt)

  ;; Inicializar entorno Byrne (si aplica)
  (ByrneStart "BYRNE_POWER_INF" "0,191,255")

  ;; Save actual properties
  (setq oldPlineWid (getvar "PLINEWID"))
  (setvar "CECOLOR" "140")
  (setvar "CELWEIGHT" 0)
  (setvar "PLINEWID" 2.0)

  ;; =========================
  ;; SOLICITAR Y DIBUJAR POLYLINE
  ;; =========================
  (if (setq startPt (getpoint "\nSeleccione el punto inicial del cable: "))
    (progn
      (command "_.PLINE" startPt)

      (while (> (getvar "CMDACTIVE") 0)
        (command pause)
      )

      ;; =========================
      ;; OBTENER POLYLINE Y PROCESAR
      ;; =========================
      (setq cableEnt (entlast))

      ;; Enviar cable hacia atrás
      (ByrneSendToBack cableEnt)

      ;; Obtener punto final
      (setq endPt (ByrneGetEndPoint cableEnt))

      ;; =========================
      ;; INSERTAR TERMINAL FINAL
      ;; =========================
      (prompt "\nRota la terminal final: ")
      (ByrneInsertBlock "CordedEndBlackConnector" endPt)
    )
  )

  ;; Restaurar variables
  (setvar "PLINEWID" oldPlineWid)
  (setvar "CECOLOR" "BYLAYER")

  (ByrneEnd)
  (princ "\nCRDBYRNE creado correctamente.")
  (princ)
)