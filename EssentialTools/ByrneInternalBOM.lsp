;=================================================
; ByrneInternalBOM.lsp
; Byrne México CAD Automation Library
;
; Version: InternalBOM_v1.0
;
; Builds the internal BOM used by:
;
; - Pretty Table
; - CSV Export
; - Balloons
;
;=================================================

(vl-load-com)

;=================================================
; ByrneCountInstances
;
; Counts how many resolved components match a block.
;=================================================

(defun ByrneCountInstances (blockName resolvedComponents
                            / count)

    (setq count 0)

    (foreach component resolvedComponents

        (if (= blockName
               (cdr (assoc 'blockName component)))

            (setq count
                  (1+ count))

        )

    )

    count

)

;=================================================
; ByrneGetInstances
;
; Returns every resolved component of a block.
;=================================================

(defun ByrneGetInstances (blockName resolvedComponents
                          / instances)

    (setq instances nil)

    (foreach component resolvedComponents

        (if (= blockName
               (cdr (assoc 'blockName component)))

            (setq instances
                  (cons component instances))

        )

    )

    (reverse instances)

)

;=================================================
; ByrneBuildInternalBOM
;
; Creates the Byrne Internal BOM.
;=================================================

;=================================================
; ByrneBuildInternalBOM
;
; Creates the Byrne Internal BOM.
;=================================================

(defun ByrneBuildInternalBOM (resolvedComponents
                              / bom
                                item
                                catalogEntry
                                blockName
                                qty
                                instances
                                bomEntry)

    (setq bom nil)

    (setq item 1)

    (foreach catalogEntry *ByrneCatalogPro*

        (setq blockName
              (cdr (assoc 'blockName catalogEntry)))

        (setq qty
              (ByrneCountInstances
                    blockName
                    resolvedComponents))

        (if (> qty 0)

            (progn

                (setq instances
                      (ByrneGetInstances
                            blockName
                            resolvedComponents))

                (setq bomEntry

    (list

        (cons 'item item)

        (assoc 'blockName catalogEntry)

        (assoc 'description catalogEntry)

        (assoc 'partNumber catalogEntry)

        (cons 'qty qty)

        (cons 'instances instances)

    )

)

                (setq bom
                      (append bom
                              (list bomEntry)))

                (setq item
                      (1+ item))

            )

        )

    )

    bom

)

;=================================================
; DEBUG
;=================================================

(defun c:TESTINTERNALBOM (/ viewportObj
                             viewportEname
                             components
                             bom)

    (setq viewportObj
          (ByrneGetViewport))

    (if viewportObj

        (progn

            (setq viewportEname
                  (vlax-vla-object->ename viewportObj))

            (setq components
                  (ByrneResolveComponents viewportEname))

            (setq bom
                  (ByrneBuildInternalBOM components))

            (print bom)

        )

    )

    (princ)

)