;=================================================
; BYRNERELOAD.lsp
; Byrne México CAD Automation Library
;
; Recarga automáticamente todos los scripts .lsp
; exclusivamente dentro de la carpeta EssentialTools.
;=================================================

(vl-load-com)

;; =======================================================
;; COMANDO PRINCIPAL: c:BYRNERELOAD
;; =======================================================
(defun c:BYRNERELOAD (/ rootFolder ByrneGetSubFolders folderList lispFiles loadedCount fullPath fileName)
  
  ;; 1. Función recursiva encapsulada para obtener subcarpetas
  (defun ByrneGetSubFolders (folder / subFolders allFolders item fullPath)
    (setq allFolders (list folder))
    (setq subFolders (vl-directory-files folder nil -1))
    (if subFolders
      (foreach item subFolders
        (if (and (/= item ".") (/= item ".."))
          (progn
            (setq fullPath (strcat folder "\\" item))
            (setq allFolders (append allFolders (ByrneGetSubFolders fullPath)))
          )
        )
      )
    )
    allFolders
  )

  ;; 2. Configurar el directorio raíz de desarrollo (Hardcodeado)
  (setq rootFolder "C:\\Users\\lazaldes\\OneDrive - Byrne Electrical Specialists\\Documentos\\AutoCAD Files\\Scripting\\Scripting\\EssentialTools")

  (if (not (vl-file-directory-p rootFolder))
    (progn
      (princ (strcat "\n[ERROR] No se encontró el directorio raíz: " rootFolder))
      (exit)
    )
  )

  ;; 3. Escanear e inyectar
  (setq folderList (ByrneGetSubFolders rootFolder))
  (setq loadedCount 0)

  (princ "\n[RELOAD] Escaneando y recargando archivos LISP en EssentialTools...\n")

  (foreach dir folderList
    ;; Buscar específicamente archivos con extensión .lsp
    (setq lispFiles (vl-directory-files dir "*.lsp" 1)) 
    
    (if lispFiles
      (foreach fileName lispFiles
        
        ;; Evitar recargar este mismo archivo para no crear un bucle infinito
        (if (/= (strcase fileName) "BYRNERELOAD.LSP")
          (progn
            (setq fullPath (strcat dir "\\" fileName))
            
            ;; Manejo de errores: si un archivo tiene un error, sigue con los demás
            (if (vl-catch-all-error-p (vl-catch-all-apply 'load (list fullPath)))
              (princ (strcat "\n[FALLO] Error de sintaxis al cargar: " fileName))
              (progn
                (princ (strcat "\n  -> Recargado: " fileName))
                (setq loadedCount (1+ loadedCount))
              )
            )
          )
        )
      )
    )
  )

  (princ (strcat "\n\n[ÉXITO] Entorno actualizado. " (itoa loadedCount) " archivos LISP recargados correctamente."))
  (princ)
)