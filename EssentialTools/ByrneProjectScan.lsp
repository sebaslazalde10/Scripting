;=================================================
; ByrneProjectScan.lsp
; Byrne México CAD Automation Library
;
; Version: ProjectScan_v9.0
;
; Global project scan used by:
;
; - ByrnePrettyTable
; - BalloonEngine
;
;=================================================

(vl-load-com)

(setq *ByrneProjectScan* nil)

;=================================================
; ByrneBuildProjectScan
;
; Builds the complete project scan using the entire
; Model Space.
;=================================================

(defun ByrneBuildProjectScan (/)

    (setq *ByrneProjectScan*

        (ByrneBuildInternalBOM

            (ByrneResolveModel)

        )

    )

    *ByrneProjectScan*

)

;=================================================
; ByrneGetProjectScan
;
; Returns the current project scan.
;=================================================

(defun ByrneGetProjectScan ()

    *ByrneProjectScan*

)

;=================================================
; ByrneGetGlobalItemNumber
; Extrae el número de ítem oficial de un componente
; cruzándolo contra el Master Project Scan.
;=================================================

(defun ByrneGetGlobalItemNumber (blockName masterBOM / itemNum)
    (setq itemNum nil)
    
    (if masterBOM
        (foreach entry masterBOM
            (if (= blockName (cdr (assoc 'blockName entry)))
                (setq itemNum (cdr (assoc 'item entry)))
            )
        )
        (princ "\n[ADVERTENCIA] No hay un escaneo global activo. Ejecuta ByrneBuildProjectScan primero.")
    )
    
    itemNum ; Retorna el entero (ej. 4) o nil si no existe
)