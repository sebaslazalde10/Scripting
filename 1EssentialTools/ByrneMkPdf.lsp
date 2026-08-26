;;; ============================================================
;;; MKPDF.LSP
;;; Publica TODOS los layouts del DWG actual a un único PDF
;;; multipágina, sin interacción del usuario.
;;;
;;; PDF:
;;;   NombreDWG.pdf
;;;   NombreDWG-II.pdf
;;;   NombreDWG-III.pdf
;;;   ...
;;;
;;; El PDF se guarda en la misma carpeta del DWG.
;;; ============================================================

(vl-load-com)

;; ------------------------------------------------------------
;; Convierte entero a números romanos
;; ------------------------------------------------------------
(defun mkpdf:num->roman (n / pairs result)
  (setq
    pairs
    '(
      (1000 . "M")
      (900  . "CM")
      (500  . "D")
      (400  . "CD")
      (100  . "C")
      (90   . "XC")
      (50   . "L")
      (40   . "XL")
      (10   . "X")
      (9    . "IX")
      (5    . "V")
      (4    . "IV")
      (1    . "I")
     )
  )

  (setq result "")

  (foreach pair pairs
    (while (>= n (car pair))
      (setq result (strcat result (cdr pair)))
      (setq n (- n (car pair)))
    )
  )

  result
)


;; ------------------------------------------------------------
;; Obtiene un nombre de PDF que no exista
;;
;; Ejemplo:
;;   WORP 5169.pdf
;;   WORP 5169-II.pdf
;;   WORP 5169-III.pdf
;; ------------------------------------------------------------
(defun mkpdf:get-output-path (dwgPath baseName / pdfPath i suffix)

  (setq pdfPath
        (strcat dwgPath baseName ".pdf"))

  (setq i 2)

  (while (findfile pdfPath)

    (setq suffix
          (strcat "-"
                  (mkpdf:num->roman i)))

    (setq pdfPath
          (strcat dwgPath
                  baseName
                  suffix
                  ".pdf"))

    (setq i (1+ i))
  )

  pdfPath
)


;; ------------------------------------------------------------
;; Comando principal
;; ------------------------------------------------------------
(defun c:MKPDF
  (
    /
    acadObj
    docObj
    layColl
    layList
    layName
    lay
    tabOrder

    dwgPath
    dwgName
    baseName
    fullDwgPath

    pdfPath
    dsdPath
    file

    oldFiledia
    oldBgPlot
    oldCmdEcho
    oldErr

    idx
    pubResult
  )

  (vl-load-com)

  ;; ----------------------------------------------------------
  ;; Guardar error handler original
  ;; ----------------------------------------------------------
  (setq oldErr *error*)

  ;; ----------------------------------------------------------
  ;; Error handler
  ;; ----------------------------------------------------------
  (defun *error* (msg)

    (if oldFiledia
      (setvar "FILEDIA" oldFiledia)
    )

    (if oldBgPlot
      (setvar "BACKGROUNDPLOT" oldBgPlot)
    )

    (if oldCmdEcho
      (setvar "CMDECHO" oldCmdEcho)
    )

    ;; Eliminar DSD temporal
    (if
      (and dsdPath
           (findfile dsdPath))
      (vl-file-delete dsdPath)
    )

    (setq *error* oldErr)

    (if
      (and msg
           (/=
             msg
             "Function cancelled"
           )
           (/=
             msg
             "quit / exit abort"
           )
      )
      (princ
        (strcat
          "\n[ERROR] "
          msg
        )
      )
    )

    (princ)
  )


  ;; ==========================================================
  ;; 1. Obtener información del DWG
  ;; ==========================================================

  (setq dwgPath
        (getvar "DWGPREFIX"))

  (setq dwgName
        (getvar "DWGNAME"))

  ;; DWGNAME vacío = dibujo no guardado
  (if (= dwgName "")
    (progn

      (princ
        "\n[ERROR] El DWG actual no ha sido guardado."
      )

      (setq *error* oldErr)

      (princ)

      (exit)
    )
  )

  (setq fullDwgPath
        (strcat
          dwgPath
          dwgName
        ))

  ;; Verificar que exista
  (if (not (findfile fullDwgPath))
    (progn

      (princ
        "\n[ERROR] No se encontró el DWG en disco."
      )

      (setq *error* oldErr)

      (princ)

      (exit)
    )
  )

  (setq baseName
        (vl-filename-base dwgName))


  ;; ==========================================================
  ;; 2. Determinar nombre del PDF
  ;; ==========================================================

  (setq pdfPath
        (mkpdf:get-output-path
          dwgPath
          baseName
        ))


  ;; ==========================================================
  ;; 3. Obtener TODOS los layouts excepto Model
  ;;    y ordenarlos por TabOrder
  ;; ==========================================================

  (setq acadObj
        (vlax-get-acad-object))

  (setq docObj
        (vla-get-ActiveDocument acadObj))

  (setq layColl
        (vla-get-Layouts docObj))

  (setq layList nil)

  (vlax-for lay layColl

    (setq layName
          (vla-get-Name lay))

    (if
      (/=
        (strcase layName)
        "MODEL"
      )

      (progn

        (setq tabOrder
              (vla-get-TabOrder lay))

        ;; (TabOrder . LayoutName)
        (setq layList
              (cons
                (cons tabOrder layName)
                layList
              )
        )
      )
    )
  )


  ;; ----------------------------------------------------------
  ;; Verificar que haya layouts
  ;; ----------------------------------------------------------

  (if (null layList)
    (progn

      (princ
        "\n[ERROR] El DWG no contiene layouts publicables."
      )

      (setq *error* oldErr)

      (princ)

      (exit)
    )
  )


  ;; ----------------------------------------------------------
  ;; Ordenar por TabOrder
  ;; ----------------------------------------------------------

  (setq layList
        (vl-sort
          layList
          '(lambda (a b)
             (<
               (car a)
               (car b)
             )
           )
        )
  )

  ;; Convertir:
  ;; ((1 . "A") (2 . "B"))
  ;; en:
  ;; ("A" "B")

  (setq layList
        (mapcar
          'cdr
          layList
        )
  )


  ;; ==========================================================
  ;; 4. Crear DSD temporal
  ;; ==========================================================

  (setq dsdPath
        (strcat
          dwgPath
          "mkpdf_temp.dsd"
        ))

  (setq file
        (open dsdPath "w"))


  (if (null file)

    (progn

      (princ
        "\n[ERROR] No se pudo crear el archivo DSD temporal."
      )

      (setq *error* oldErr)

      (princ)

      (exit)
    )
  )


  ;; ==========================================================
  ;; CABECERA DSD
  ;; ==========================================================

  (write-line
    "[DWF6Version]"
    file
  )

  (write-line
    "Ver=1"
    file
  )

  (write-line
    "[DWF6MinorVersion]"
    file
  )

  (write-line
    "MinorVer=1"
    file
  )


  ;; ==========================================================
  ;; SHEETS
  ;; ==========================================================

  (foreach lay layList

    (write-line
      (strcat
        "[DWF6Sheet:"
        baseName
        "-"
        lay
        "]"
      )
      file
    )

    (write-line
      (strcat
        "DWG="
        fullDwgPath
      )
      file
    )

    (write-line
      (strcat
        "Layout="
        lay
      )
      file
    )

    ;; Utilizar el Page Setup actual del layout
    (write-line
      "Setup="
      file
    )

    (write-line
      (strcat
        "OriginalSheetPath="
        fullDwgPath
      )
      file
    )

    (write-line
      "Has Plot Port=0"
      file
    )

    (write-line
      "Has3DDWF=0"
      file
    )
  )


  ;; ==========================================================
  ;; TARGET
  ;; Type=6 = Multi-sheet PDF
  ;; ==========================================================

  (write-line
    "[Target]"
    file
  )

  (write-line
    "Type=6"
    file
  )

  (write-line
    (strcat
      "DWF="
      pdfPath
    )
    file
  )

  (write-line
    (strcat
      "OUT="
      dwgPath
    )
    file
  )

  (write-line
    "PWD="
    file
  )


  ;; ==========================================================
  ;; PDF OPTIONS
  ;; ==========================================================

  (write-line
    "[PdfOptions]"
    file
  )

  (write-line
    "IncludeHyperlinks=TRUE"
    file
  )

  (write-line
    "CreateBookmarks=TRUE"
    file
  )

  (write-line
    "CaptureFontsInDrawing=TRUE"
    file
  )

  (write-line
    "ConvertTextToGeometry=FALSE"
    file
  )

  (write-line
    "VectorResolution=1200"
    file
  )

  (write-line
    "RasterResolution=400"
    file
  )


  ;; ==========================================================
  ;; SHEET SET PROPERTIES
  ;; ==========================================================

  (write-line
    "[SheetSet Properties]"
    file
  )

  (write-line
    "IsSheetSet=FALSE"
    file
  )

  (write-line
    "IsHomogeneous=FALSE"
    file
  )

  (write-line
    "SheetSet Name="
    file
  )

  (write-line
    "NoOfCopies=1"
    file
  )

  (write-line
    "PlotStampOn=FALSE"
    file
  )

  (write-line
    "ViewFile=FALSE"
    file
  )

  (write-line
    "JobID=0"
    file
  )

  (write-line
    "SelectionSetName="
    file
  )

  (write-line
    "AcadProfile="
    file
  )

  (write-line
    "CategoryName="
    file
  )

  (write-line
    "LogFilePath="
    file
  )

  (write-line
    "IncludeLayer=TRUE"
    file
  )

  (write-line
    "LineMerge=FALSE"
    file
  )

  (write-line
    "CurrentPrecision="
    file
  )

  (write-line
    "PromptForDwfName=FALSE"
    file
  )

  (write-line
    "PwdProtectPublishedDWF=FALSE"
    file
  )

  (write-line
    "PromptForPwd=FALSE"
    file
  )

  (write-line
    "RepublishingMarkups=FALSE"
    file
  )

  (write-line
    "PublishSheetSetMetadata=FALSE"
    file
  )

  (write-line
    "PublishSheetMetadata=FALSE"
    file
  )

  (write-line
    "3DDWFOptions=0 1"
    file
  )


  ;; ==========================================================
  ;; Cerrar DSD
  ;; ==========================================================

  (close file)


  ;; ==========================================================
  ;; 5. Publicar
  ;; ==========================================================

  (setq oldFiledia
        (getvar "FILEDIA"))

  (setq oldBgPlot
        (getvar "BACKGROUNDPLOT"))

  (setq oldCmdEcho
        (getvar "CMDECHO"))


  ;; Nada de diálogos
  (setvar "FILEDIA" 0)

  ;; Publicación en foreground
  (setvar "BACKGROUNDPLOT" 0)

  (setvar "CMDECHO" 0)


  (princ
    (strcat
      "\nGenerando PDF con "
      (itoa (length layList))
      " hoja(s):"
      "\n"
      pdfPath
    )
  )


  ;; ----------------------------------------------------------
  ;; Ejecutar PUBLISH
  ;; ----------------------------------------------------------

  (command "_.-PUBLISH" dsdPath)


  ;; ==========================================================
  ;; 6. Restaurar variables
  ;; ==========================================================

  (setvar
    "FILEDIA"
    oldFiledia
  )

  (setvar
    "BACKGROUNDPLOT"
    oldBgPlot
  )

  (setvar
    "CMDECHO"
    oldCmdEcho
  )


  ;; ==========================================================
  ;; 7. Eliminar DSD
  ;; ==========================================================

  (if (findfile dsdPath)
    (vl-file-delete dsdPath)
  )


  ;; ==========================================================
  ;; 8. Resultado
  ;; ==========================================================

 (if (findfile pdfPath)
  (princ
    (strcat
      "\n[ÉXITO] PDF generado:"
      "\n"
      pdfPath
    )
  )
  (princ
    "\n[ADVERTENCIA] PUBLISH terminó pero no se encontró el PDF."
  )
)

  ;; Restaurar error handler
  (setq *error* oldErr)

  (princ)
)


(princ
  "\nMKPDF cargado. Escribe MKPDF para publicar todos los layouts."
)

(princ)