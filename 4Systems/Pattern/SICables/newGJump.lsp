(defun c:NGJUMPPAT (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_JUMPER_ORANGE" "242, 103, 34")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "newJumperOrangeEndBegin"
  )

  (ByrneInsertBlock
    "newJumperOrangeEndBegin"
    startPt
  )


  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================
  
  (command "_.PLINE"
         startPt
         "_W"
         1.0
         1.0
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
    "newJumperOrangeEndEndPat"
  )

  (ByrneInsertBlock
    "newJumperOrangeEndEndPat"
    endPt
  )

  ;;(ByrneAddBOM "COMMERCIAL_NAME" 1)

   ;;Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n JUMPER creado correctamente.")
  (princ)
)
