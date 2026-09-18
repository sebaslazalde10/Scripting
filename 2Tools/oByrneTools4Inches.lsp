;=================================================
; ByrneToolsInches.lsp
; Byrne México CAD Automation Library
;
; Version: Scripting_v7
; Author: Sebastián Lazalde + ChatGPT
; Date: June 2026
;
; Shared utility functions used by:
; - PLD
; - FFJUMP
; - 3WAYJUMP
; - IQC
; - SMI
; New:
; - BOM
;=================================================



;=================================================
; CAPAS
;=================================================

(defun ByrneSetLayer (layerName colorIndex /)

  (if (not (tblsearch "LAYER" layerName))
    (command "_.-LAYER"
             "_Make" layerName
             "_Color" "TrueColor" colorIndex layerName
             ""
    )
    (command "_.-LAYER"
             "_Make" layerName
             ""
    )
  )

  (setvar "CECOLOR" "BYLAYER")
  (setvar "CELWEIGHT" -1)

)



;=================================================
; ENTORNO DE TRABAJO
;=================================================

(defun ByrneStart (layerName colorIndex /)

  (setq *ByrneOldColor* (getvar "CECOLOR"))
  (setq *ByrneOldLW*    (getvar "CELWEIGHT"))
  (setq *ByrneOldLayer* (getvar "CLAYER"))

  (ByrneSetLayer layerName colorIndex)

)



(defun ByrneEnd ()

  (setvar "CECOLOR" *ByrneOldColor*)
  (setvar "CELWEIGHT" *ByrneOldLW*)
  (setvar "CLAYER" *ByrneOldLayer*)

  (princ)

)



;=================================================
; BLOQUES
;=================================================

(defun ByrnePurgeBlock (blkName)

  (command "_.-PURGE"
           "_B"
           blkName
           "_N"
  )

)



(defun ByrneInsertBlock (blk insPt)

  (command "_.-INSERT"
           blk
           insPt
           1
           1
           pause
  )

)



(defun ByrneInsertBlockNoRotate (blk insPt)

  (command "_.-INSERT"
           blk
           insPt
           1
           1
           0
  )

)

;=================================================
; GENERAL CORD
;=================================================

(defun ByrneGenericCord (startPt / cableEnt endPt)

  ;; =========================
  ;; CONFIGURAR CABLE
  ;; =========================

  (setvar "CECOLOR" "140")
  (setvar "CELWEIGHT" 0)

  ;; =========================
  ;; DIBUJAR POLYLINE
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

  ;; =========================
  ;; OBTENER POLYLINE
  ;; =========================

  (setq cableEnt (entlast))

  ;; Enviar cable hacia atrás

  (ByrneSendToBack cableEnt)

  ;; =========================
  ;; OBTENER ENDPOINT
  ;; =========================

  (setq endPt
        (ByrneGetEndPoint cableEnt)
  )

  ;; =========================
  ;; INSERTAR TERMINAL FINAL
  ;; =========================

  (prompt "\nRota la terminal final: ")

  (ByrneInsertBlock
    "BlackEndTerminal"
    endPt
  )

)

;=================================================
; GEOMETRÍA
;=================================================

(defun ByrneGetEndPoint (ent)

  (vlax-curve-getEndPoint
    (vlax-ename->vla-object ent)
  )

)



(defun ByrneSendToBack (ent)

  (command "_.DRAWORDER"
           ent
           ""
           "_Back"
  )

)





(princ "\nByrneTools v5.1 cargado.")
(princ)