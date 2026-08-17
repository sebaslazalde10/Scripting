(defun c:IQC (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_IQC" "0, 191, 255")

  ;; =========================
  ;; PUNTO INICIAL
  ;; =========================

  (setq startPt
        (getpoint "\nSelecciona el punto inicial del cable: ")
  )

  ;; =========================
  ;; DIBUJAR POLYLINE
  ;; =========================

  (setvar "CECOLOR" "140")
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

  ;; =========================
  ;; OBTENER POLYLINE
  ;; =========================

  (setq cableEnt (entlast))

  ;; Enviar cable hacia atrás
  (ByrneSendToBack cableEnt)

  ;; =========================
  ;; OBTENER ENDPOINT
  ;; =========================

  (setq endPt
        (ByrneGetEndPoint cableEnt)
  )

  ;; =========================
  ;; INSERTAR TERMINAL FINAL
  ;; =========================

  (prompt "\nRota la terminal final: ")

  (ByrneInsertBlock
    "C:/Users/lazaldes/OneDrive - Byrne Electrical Specialists/Documentos/AutoCAD Files/personalLibrary/IQ 2.0/BlackEndTerminal.dwg"
    endPt
  )


  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nIQ Cord creado correctamente.")
  (princ)
)