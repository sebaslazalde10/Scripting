(defun c:BJUMPER4T4 (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4T_JUMP" "16,86,137")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "4T_JUMPER_SIDE_BEGIN4"
  )

  (ByrneInsertBlock
    "4T_JUMPER_SIDE_BEGIN4"
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
    "4T_JUMPER_SIDE_END"
  )

  (ByrneInsertBlock
    "4T_JUMPER_SIDE_END"
    endPt
  )

  ;;(ByrneAddBOM "BLUE JUMPER" 1)

   ;;Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n4T JUMPER creado correctamente.")
  (princ)
)