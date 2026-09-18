;=================================================
; ByrneCADPathTools.lsp
; Auto-configurador recursivo de SFSP para AutoCAD
; Ruta destino: personalLibrary\Accessories
;=================================================

(vl-load-com)

;; =======================================================
;; 1. MOTOR RECURSIVO: Escanea todas las subcarpetas
;; =======================================================
(defun ByrneGetSubFolders (folder / subFolders allFolders item fullPath)
  ;; Iniciar la lista con la carpeta examinada
  (setq allFolders (list folder))
  
  ;; Buscar elementos en el directorio (-1 indica carpetas)
  (setq subFolders (vl-directory-files folder nil -1))
  
  (if subFolders
    (foreach item subFolders
      ;; Ignorar directorios relativos del sistema
      (if (and (/= item ".") (/= item ".."))
        (progn
          (setq fullPath (strcat folder "\\" item))
          ;; Llamada recursiva hacia niveles inferiores
          (setq allFolders (append allFolders (ByrneGetSubFolders fullPath)))
        )
      )
    )
  )
  allFolders
)

;; =======================================================
;; 2. COMANDO PRINCIPAL: Inyecta las rutas a AutoCAD
;; =======================================================
(defun c:BYRNEPATHS (/ rootFolder prefs currentPaths folderList newPaths addedCount dir)
  
  ;; Ruta absoluta del repositorio local en OneDrive
  (setq rootFolder "C:\\Users\\lazaldes\\OneDrive - Byrne Electrical Specialists\\Documentos\\AutoCAD Files\\personalLibrary\\Accessories")

  ;; Validar existencia física del directorio antes de proceder
  (if (not (vl-file-directory-p rootFolder))
    (progn
      (princ (strcat "\n[ERROR] No se pudo acceder a la ruta raíz de soporte: " rootFolder))
      (princ "\nVerifica que la carpeta esté sincronizada localmente en OneDrive.")
      (exit)
    )
  )

  ;; Obtener interfaz de preferencias de archivos de AutoCAD
  (setq prefs (vla-get-Files (vla-get-preferences (vlax-get-acad-object))))
  (setq currentPaths (vla-get-SupportPath prefs))
  
  ;; Generar árbol completo de subdirectorios
  (setq folderList (ByrneGetSubFolders rootFolder))
  (setq newPaths currentPaths)
  (setq addedCount 0)

  (foreach dir folderList
    ;; Comprobar si la subcarpeta ya se encuentra en el SFSP global
    (if (not (vl-string-search (strcase dir) (strcase currentPaths)))
      (progn
        (setq newPaths (strcat newPaths ";" dir))
        (setq addedCount (1+ addedCount))
      )
    )
  )

  ;; Guardar los cambios en el registro del perfil actual de AutoCAD
  (if (> addedCount 0)
    (progn
      (vla-put-SupportPath prefs newPaths)
      (princ (strcat "\n[ÉXITO] Se agregaron " (itoa addedCount) " directorios de Accessories al Support Path."))
    )
    (princ "\n[OK] El Support Path ya se encuentra completamente actualizado.")
  )
  
  (princ)
)

(princ "\nByrneCADPathTools cargado. Ejecuta BYRNEPATHS para inicializar las carpetas.")
(princ)