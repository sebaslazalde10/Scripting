(defun c:NGJUMP4 (/ startPt cableEnt endPt)

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
         0.5
         0.5
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
    "newJumperOrangeEndEnd"
  )

  (ByrneInsertBlock
    "newJumperOrangeEndEnd4"
    endPt
  )

  ;;(ByrneAddBOM "COMMERCIAL_NAME" 1)

   ;;Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n JUMPER creado correctamente.")
  (princ)
)
