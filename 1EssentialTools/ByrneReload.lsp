;=================================================
; BYRNERELOAD.lsp
; Byrne México CAD Automation Library
;
; Recarga automáticamente todos los scripts .lsp
; dentro de la carpeta EssentialTools (y subcarpetas).
;
; NOVEDAD: ya no depende de una ruta hardcodeada.
; Se autodetecta a partir de su propia ubicación
; (la carpeta donde vive este mismo archivo .lsp).
; Si por algun motivo no logra autodetectarse (p.ej.
; la carpeta no esta en el Support File Search Path
; de AutoCAD), usa la ruta de respaldo definida abajo.
;=================================================

(vl-load-com)

;; -------------------------------------------------
;; Ruta de RESPALDO. Solo se usa si la autodeteccion
;; falla. Actualizala si cambias de equipo/carpeta.
;; -------------------------------------------------
(setq *ByrneRootFolderFallback*
      "C:\\Users\\lazaldes\\OneDrive - Byrne Electrical Specialists\\Documentos\\AutoCAD Files\\Scripting\\Scripting\\EssentialTools")

;=================================================
; ByrneGetSubFolders
; Devuelve, de forma recursiva, la carpeta dada mas
; todas sus subcarpetas (ignora "." ".." y carpetas
; ocultas/sistema que empiecen con ".").
;=================================================
(defun ByrneGetSubFolders (folder / subFolders allFolders item fullPath)
    (setq allFolders (list folder))
    (setq subFolders (vl-directory-files folder nil -1))
    (if subFolders
        (foreach item subFolders
            (if (and (/= item ".")
                     (/= item "..")
                     (/= (substr item 1 1) "."))
                (progn
                    (setq fullPath (strcat folder "\\" item))
                    (setq allFolders (append allFolders (ByrneGetSubFolders fullPath)))
                )
            )
        )
    )
    allFolders
)

;=================================================
; ByrneResolveRootFolder
; Intenta autodetectar la carpeta donde vive este
; mismo archivo. Si no puede, usa la de respaldo.
;=================================================
(defun ByrneResolveRootFolder (/ selfPath autoFolder)
    (setq selfPath (findfile "ByrneReload.lsp"))

    (setq autoFolder
        (if selfPath
            (vl-filename-directory selfPath)
            nil
        )
    )

    (cond
        ((and autoFolder (vl-file-directory-p autoFolder))
            (princ (strcat "\n[RELOAD] Carpeta raiz autodetectada: " autoFolder))
            autoFolder
        )
        ((vl-file-directory-p *ByrneRootFolderFallback*)
            (princ "\n[RELOAD] No se pudo autodetectar la carpeta (no esta en el Support File Search Path).")
            (princ (strcat "\n[RELOAD] Usando ruta de respaldo: " *ByrneRootFolderFallback*))
            *ByrneRootFolderFallback*
        )
        (T nil)
    )
)

;; =======================================================
;; COMANDO PRINCIPAL: c:BYRNERELOAD
;; =======================================================
(defun c:BYRNERELOAD (/ rootFolder folderList lispFiles loadedCount failedCount
                        fullPath fileName dir filesInDir)

    (setq rootFolder (ByrneResolveRootFolder))

    (if (not rootFolder)
        (progn
            (princ "\n[ERROR] No se encontro la carpeta raiz (ni autodetectada ni de respaldo).")
            (princ "\n[ERROR] Verifica *ByrneRootFolderFallback* al inicio de ByrneReload.lsp.")
        )
        (progn
            (setq folderList (ByrneGetSubFolders rootFolder))
            (setq loadedCount 0)
            (setq failedCount 0)

            (princ "\n[RELOAD] Escaneando y recargando archivos LISP en EssentialTools...\n")

            (foreach dir folderList
                (setq lispFiles (vl-directory-files dir "*.lsp" 1))
                (setq filesInDir 0)

                (if lispFiles
                    (foreach fileName lispFiles
                        ;; Evitar recargar este mismo archivo para no crear un bucle infinito
                        (if (/= (strcase fileName) "BYRNERELOAD.LSP")
                            (progn
                                (setq fullPath (strcat dir "\\" fileName))
                                (setq filesInDir (1+ filesInDir))

                                ;; Manejo de errores: si un archivo tiene un error, sigue con los demas
                                (if (vl-catch-all-error-p (vl-catch-all-apply 'load (list fullPath)))
                                    (progn
                                        (princ (strcat "\n  [FALLO] Error de sintaxis al cargar: " fullPath))
                                        (setq failedCount (1+ failedCount))
                                    )
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

            (princ (strcat "\n\n[EXITO] Entorno actualizado. " (itoa loadedCount) " archivos LISP recargados correctamente."))
            (if (> failedCount 0)
                (princ (strcat "\n[ATENCION] " (itoa failedCount) " archivo(s) fallaron al cargar (revisa los mensajes arriba)."))
            )
        )
    )
    (princ)
)

(princ "\nByrneReload.lsp cargado. Escribe BYRNERELOAD para actualizar toda la libreria.")
(princ)