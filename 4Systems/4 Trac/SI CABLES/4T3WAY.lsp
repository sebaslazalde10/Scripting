(defun c:3WAY4TJUMPER (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_4T_3_WAY_JUMP" "16,86,137")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "4T_3WAY_BEGIN"
  )

  (ByrneInsertBlock
    "4T_3WAY_BEGIN"
    startPt
  )


  ;; =========================
  ;; DIBUJAR CABLE
  ;; =========================

  (command "_.PLINE"
         startPt
         "_W"
         2.0
        2.0
           
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
    "4T_3WAY_END"
  )

  (ByrneInsertBlock
    "4T_3WAY_END"
    endPt
  )

  ;;(ByrneAddBOM "BLUE JUMPER" 1)

   ;;Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n4T 3 WAY JUMPER creado correctamente.")
  (princ)
)