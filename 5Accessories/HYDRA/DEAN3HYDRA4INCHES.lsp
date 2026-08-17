(defun c:GEN_DEAN3_HYDRA4IN (/ cableEnt endPt startPt2)

  ;; Inicializar entorno
  (ByrneStart "BYRNE_DEAN3_HYDRA4" "0,255,255")

  ;; =========================
  ;; 1. INSERTAR BLOQUE DEAN3
  ;; =========================
  (prompt "\nInserta y rota el bloque DEAN3: ")
  
  (ByrnePurgeBlock "DEANHYDRA_3_WINDOW")
  (ByrneInsertBlock "DEANHYDRA_3_WINDOW" pause)

  ;; =========================
  ;; 2. DIBUJAR PRIMER CABLE
  ;; =========================
  (prompt "\nDibuja el cable hacia el TAPHYDRA4. Presiona ENTER cuando termines: ")
  
  ;; Optimización: Usamos "_W" (Width) dentro del comando como en ByrneGenericCord
  ;; Asumiendo que el cable interno es de grosor 0.5
  (command "_.PLINE"
           pause
           "_W"
           0.5
           0.5
  )
  
  (while (> (getvar "CMDACTIVE") 0)
    (command pause)
  )

  (setq cableEnt (entlast))
  
  ;; Optimización: Mandar cable atrás usando tu función existente
  (ByrneSendToBack cableEnt) 
  
  (setq endPt (ByrneGetEndPoint cableEnt))

  ;; =========================
  ;; 3. INSERTAR BLOQUE TAPHYDRA4
  ;; =========================
  (prompt "\nRotación para TAP_HYDRA_4W: ")
  
  (ByrnePurgeBlock "TAP_HYDRA_4W")
  (ByrneInsertBlock "TAP_HYDRA_4W" endPt)

  ;; =========================
  ;; 4. DIBUJAR SEGUNDO CABLE (GENERIC CORD)
  ;; =========================
  ;; Esta función ya se encargará del grosor 3.0, el draworder y de insertar el BlackEndTerminal.dwg
  (setq startPt2
      (getpoint "\nSelecciona punto de salida para el Generic Cord final: ")
  )
  (ByrneGenericCord startPt2)

  
  ;; =========================
  ;; CERRAR ENTORNO
  ;; =========================
  (ByrneEnd)

  (princ "\nSecuencia DEAN3 -> Cable -> TAPHYDRA4 -> Generic Cord creada correctamente.")
  (princ)
)