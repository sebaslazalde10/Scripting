;=================================================
; ByrneResolver.lsp
; Byrne México CAD Automation Library
;
; Version: Resolver_v1.0
;=================================================

;=================================================
; ByrneGetCatalogEntry
;
; Returns the catalog entry for a block name.
;=================================================

(defun ByrneGetCatalogEntry (blockName / entry)

    (setq entry

        (vl-some

            '(lambda (catalogEntry)

                (if (= (cdr (assoc 'blockName catalogEntry))
                       blockName)

                    catalogEntry

                )

            )

            *ByrneCatalogPro*

        )

    )

    entry

)

(defun c:TESTCATALOG (/ entry)

    (setq entry
          (ByrneGetCatalogEntry "DEAN_3_WINDOW"))

    (print entry)

    (princ)

)

;=================================================
; ByrneResolveComponent
;
; Resolves a block reference into a Byrne Component.
;=================================================

(defun ByrneResolveComponent (blockEname
                              / blockData
                                blockName
                                catalogEntry)

    (setq blockData
          (entget blockEname))

    (setq blockName
          (cdr (assoc 2 blockData)))

    (setq catalogEntry
          (ByrneGetCatalogEntry blockName))

    (if catalogEntry

        (list

            (cons 'entity
                  blockEname)

            (cons 'handle
                  (cdr (assoc 5 blockData)))

            (cons 'blockName
                  blockName)

            (cons 'description
                  (cdr (assoc 'description catalogEntry)))

            (cons 'partNumber
                  (cdr (assoc 'partNumber catalogEntry)))

            (cons 'insertPoint
                  (cdr (assoc 10 blockData)))

        )

    )

)

(defun c:TESTRESOLVE (/ ent component)

    (setq ent
          (car (entsel "\nSelect Byrne block: ")))

    (setq component
          (ByrneResolveComponent ent))

    (print component)

    (princ)

)

;=================================================
; ByrneResolveComponent
;
; Resolves an INSERT into a Byrne Component.
;=================================================

(defun ByrneResolveComponent (blockEname
                              / blockData
                                blockName
                                catalogEntry
                                component)

    (setq blockData
          (entget blockEname))

    (setq blockName
          (cdr (assoc 2 blockData)))

    (setq catalogEntry
          (ByrneGetCatalogEntry blockName))

    (if catalogEntry

        (progn

            ;; Copia el registro del catálogo
            (setq component
                  (reverse (reverse catalogEntry)))

            ;; Añade información de la instancia

            (setq component
                  (append

                      component

                      (list

                          (cons 'entity blockEname)

                          (cons 'handle
                                (cdr (assoc 5 blockData)))

                          (cons 'insertPoint
                                (cdr (assoc 10 blockData)))

                      )

                  )
            )

            component

        )

    )

)

(defun c:TESTRESOLVE (/ ent component)

    (setq ent
          (car (entsel "\nSelect Byrne block: ")))

    (setq component
          (ByrneResolveComponent ent))

    (print component)

    (princ)

)

;=================================================
; ByrneResolveComponents
;
; Resolves all scanned INSERTs into Byrne Components.
;=================================================

(defun ByrneResolveComponents (viewportEname
                               / inserts
                                 components
                                 component)

    (setq components nil)

    (setq inserts
          (ByrneScanViewport viewportEname))

    (foreach insert inserts

        (setq component
              (ByrneResolveComponent insert))

        (if component

            (setq components
                  (cons component components))

        )

    )

    (reverse components)

)

;=================================================
; ByrneResolveModel
;
; Resolves all INSERTs from the Model Space into
; Byrne Components.
;=================================================
(defun ByrneResolveModel (/ inserts components component)
    (setq components nil)
    
    ;; 1. Obtener la LISTA de todas las entidades (enames) del Model Space
    (setq inserts (ByrneScanModel))
    
    ;; 2. Validar que la lista no esté vacía e iterar sobre ella
    (if inserts
        (foreach insert inserts
            ;; Resolver bloque por bloque (pasando una única entidad)
            (setq component (ByrneResolveComponent insert))
            
            ;; Si pertenece al catálogo de Byrne, agregarlo a la lista de componentes
            (if component
                (setq components (cons component components))
            )
        )
    )
    
    ;; 3. Retornar la lista final estructurada y filtrada para ByrneBuildInternalBOM
    (reverse components)
)

(defun c:TESTCOMPONENTS (/ viewportObj
                           viewportEname
                           components)

    (setq viewportObj
          (ByrneGetViewport))

    (if viewportObj

        (progn

            (setq viewportEname
                  (vlax-vla-object->ename viewportObj))

            (setq components
                  (ByrneResolveComponents viewportEname))

            (print components)

        )

    )

    (princ)

)