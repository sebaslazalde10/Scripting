(defun c:BJUMPSIDE8TRACCABLE (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_8_TRAC_JUMPER" "16, 86, 137")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "MMJumpBegin"
  )

  (ByrneInsertBlock
    "MMJumpBegin"
    startPt
  )


  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

(setvar "CECOLOR" "RGB: 16,86, 137 ")
  (setvar "CELWEIGHT" 0)
  
  (command "_.PLINE" startPt
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
    "MMJumpEnd"
  )

  (ByrneInsertBlock
    "MMJumpEnd"
    endPt
  )

  ;;(ByrneAddBOM "M/M JUMPER" 1)

   Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\Nm/m JUMPER creado correctamente.")
  (princ)
)