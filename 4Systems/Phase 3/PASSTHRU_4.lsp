(defun c:PASSTHRUCABLE4 (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_PASSTHRU" "39,118,187")

;; =========================
  ;; INSERTAR CONECTOR INICIAL
  ;; =========================
(setq startPt (getpoint "\nSelecciona el punto de inicio: "))
   (ByrnePurgeBlock
    "BLUEJUMPERBEGIN"
  )

  (ByrneInsertBlock
    "BLUEJUMPERBEGIN"
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
    "BLUEJUMPERFINISH4"
  )

  (ByrneInsertBlock
    "BLUEJUMPERFINISH4"
    endPt
  )

  ;;(ByrneAddBOM "BLUE JUMPER" 1)

   ;;Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n PASSTHRU CABLE creado correctamente.")
  (princ)
)