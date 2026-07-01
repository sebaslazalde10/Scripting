(defun c:3WAYJUMPER (/ startPt cableEnt endPt)

  ;; Inicializar entorno Byrne
  (ByrneStart "BYRNE_3_WAY_JUMP" "39,118,187")

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

  (command "_.PLINE" startPt)

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
    "BLUEJUMPEREND"
  )

  (ByrneInsertBlock
    "BLUEJUMPEREND"
    endPt
  )

  ;;(ByrneAddBOM "BLUE JUMPER" 1)

   Restaurar entorno Byrne
  (ByrneEnd)

  (princ "\n3 WAY JUMPER creado correctamente.")
  (princ)
)