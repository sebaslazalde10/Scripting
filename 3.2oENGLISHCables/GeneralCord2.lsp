(defun c:GCORD (/ startPt)

  (setq startPt
        (getpoint "\nSelecciona el punto inicial del cable: ")
  )

  (ByrneGenericCord startPt)

  (princ "\nGeneral Cord creado correctamente.")
  (princ)

)