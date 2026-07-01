(defun c:GBJUMP (/ startPt cableEnt obj endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_JUMPER" "16, 86, 137")

  ;; =========================
  ;; CONECTOR INICIAL
  ;; =========================

  (prompt "\nInserta y rota el conector inicial: ")

  ;; Purga definición vieja
  (command "_.-PURGE"
           "_B"
           "JumperConnector"
           "_N"
  )

  (command "_.-INSERT"
           "C:/Users/lazaldes/OneDrive - Byrne Electrical Specialists/Documentos/AutoCAD Files/personalLibrary/JumperConnector.dwg"
           pause
           1
           1
           pause
  )

  ;; Obtener punto inicial
  (setq startPt (getvar "LASTPOINT"))

  ;; =========================
  ;; CONFIGURAR CABLE
  ;; =========================

  (command "_.COLOR"
           "_TrueColor"
           "16, 86, 137"
  )

  (setvar "CELWEIGHT" 20)

  ;; =========================
  ;; POLYLINE
  ;; =========================

  (command "_.PLINE"
           startPt
           "_W"
           1
           1
  )

  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  ;; Obtener polyline
  (setq cableEnt (entlast))

  ;; Enviar atrás
  (ByrneSendToBack cableEnt)

  ;; =========================
  ;; ENDPOINT
  ;; =========================

  (setq obj (vlax-ename->vla-object cableEnt))
  (setq endPt (vlax-curve-getEndPoint obj))

  ;; =========================
  ;; CONECTOR FINAL
  ;; =========================

  (prompt "\nRota el conector final: ")

  ;; Purga otra vez por seguridad
  (command "_.-PURGE"
           "_B"
           "JumperConnector"
           "_N"
  )

  (command "_.-INSERT"
           "C:/Users/lazaldes/OneDrive - Byrne Electrical Specialists/Documentos/AutoCAD Files/personalLibrary/JumperConnector.dwg"
           endPt
           1
           1
           pause
  )

  ;; =========================
  ;; BOM
  ;; =========================

  (ByrneAddBOM "JUMPER" 1)

  ;; Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\nGeneric Jumper creado correctamente.")
  (princ)
)