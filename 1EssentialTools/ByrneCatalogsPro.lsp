;=================================================
; ByrneCatalogPro.lsp
; Byrne México CAD Automation Library
;
; Version: CatalogPro_v1.0
;=================================================

(setq *ByrneCatalogPro*
'(

;=================================================
; JUMPERS AND INFEEDS
;=================================================

(
    (blockName  . "hardwiredPowerInfeedConnectorEnd_SOURCE")
    (description . "HARDWIRE POWER INFEED")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_HARDWIRE_POWER_INFEED") ;;OK
    (blockScale . 1.00)
)

  
(
    (blockName  . "CordedEndConnector")
    (description . "XX\" POWER INFEED")
    (partNumber . "PATTERN: BE07590-E-72 or BE07590-E-SB72")
    (symbolBlock . "SYM_CORD_CONNECTOR") ;;OK
    (blockScale . 1.00)
)
  
(
    (blockName  . "CordedInfeedXX")
    (description . "XX\" POWER INFEED")
    (partNumber . "PATTERN: BE07590-E-72 or BE07590-E-SB72")
    (symbolBlock . "SYM_CORD_CONNECTOR") ;;OK
    (blockScale . 1.00)
)
  
(
    (blockName  . "newJumperOrangeEndEnd")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)


(
    (blockName  . "newJumperOrangeEndEnd2")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)
  
(
    (blockName  . "newJumperOrangeEndEnd3")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)
  
(
    (blockName  . "newJumperOrangeEndEnd4")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)

;=================================================
; 4 TRAC
;=================================================

(
    (blockName  . "4T_Hardwired")
    (description . "XX\" LIQUID TIGHT CONDUIT")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_HARDWIRE_POWER_INFEED")   
    (blockScale . 1.00)
)

  
  (
    (blockName  . "4T_JUMPER_SIDE_BEGIN")
    (description . "XX\" F/F JUMPER")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
(
    (blockName  . "4T_3WAY_BEGIN")
    (description . "XX\" F/F/M JUMPER")
    (partNumber . "BE44631-X-XX")
    (symbolBlock . "SYM_3WAY_BLUEJumper")
    (blockScale . 0.002)
)
  
  (
    (blockName  . "4T_DUPLEX_RECEPTACLE_SIDE")
    (description . "DUPLEX RECEPTACLE")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "4T_DUPLEX_RECEPTACLE_SIDE")
    (blockScale . 0.06)
)
  
(
    (blockName  . "4T_DUPLEX_RECEPTACLE_UP")
    (description . "DUPLEX RECEPTACLE")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "4T_DUPLEX_RECEPTACLE_UP")
    (blockScale . 0.06)
)
  
(
    (blockName  . "4T_TRIPLEX_RECEPTACLE_UP")
    (description . "TRIPLEX RECEPTACLE")
    (partNumber . "XXX-XX-XX-XXX")
    (symbolBlock . "4T_TRIPLEX_RECEPTACLE_UP")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "4T_TRIPLEX_RECEPTACLE_SIDE")
    (description . "TRIPLEX RECEPTACLE")
    (partNumber . "XXX-XX-XX-XXX")
    (symbolBlock . "4T_TRIPLEX_RECEPTACLE_SIDE")
    (blockScale . 0.06)
)

;=================================================
; 8 TRAC
;=================================================


  (
    (blockName  . "MMJumpEnd")
    (description . "XX\" M/M JUMPER")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "SYM_MMJumper")
    (blockScale . 1.00)
)

  
(
    (blockName  . "8TRAC_SINGLE_HALFBLOCK_SIDE_REALISTIC")
    (description . "SINGLE HALF BLOCK")
    (partNumber . "BE08381-X-X-00")
    (symbolBlock . "8TRAC_SINGLE_HALFBLOCK_SIDE_REALISTIC")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "8TRAC_DOUBLE_HALFBLOCK_UP_REALISTIC")
    (description . "DOUBLE BLOCK")
    (partNumber . "BE08290-3-2-30-00")
    (symbolBlock . "8TRAC_DOUBLE_BLOCK_UP_REALISTIC")
    (blockScale . 0.06)
)
  
   (
    (blockName  . "8TRAC_DOUBLE_HALFBLOCK_SIDE_REALISTIC")
    (description . "DOUBLE HALF BLOCK")
    (partNumber . "BE08290-3-2-30-00")
    (symbolBlock . "8TRAC_DOUBLE_HALFBLOCK_SIDE_REALISTIC")
    (blockScale . 0.06)
)
  
(
    (blockName  . "8TRAC_DOUBLE_BLOCK_SIDE_REALISTIC")
    (description . "DOUBLE BLOCK")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_DOUBLE_BLOCK_SIDE_REALISTIC")
    (blockScale . 0.06)
)

(
    (blockName  . "8TRAC_RECEPTACLE_C1_UP")
    (description . "DUPLEX RECEPTACLE C1")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C1_UP")
    (blockScale . 0.06) 
)
  
(
    (blockName  . "8TRAC_RECEPTACLE_C1_SIDE")
    (description . "DUPLEX RECEPTACLE C1")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C1_SIDE")
    (blockScale . 0.06)
)

(
    (blockName  . "8TRAC_RECEPTACLE_C2_UP")
    (description . "DUPLEX RECEPTACLE C2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C2_UP")
    (blockScale . 0.06) 
)
  
(
    (blockName  . "8TRAC_RECEPTACLE_C2_SIDE")
    (description . "DUPLEX RECEPTACLE C2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C2_SIDE")
    (blockScale . 0.06)
)

(
    (blockName  . "8TRAC_RECEPTACLE_C3_UP")
    (description . "DUPLEX RECEPTACLE C3")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C3_UP")
    (blockScale . 0.06) 
)
  
  (
    (blockName  . "8TRAC_RECEPTACLE_C3_SIDE")
    (description . "DUPLEX RECEPTACLE C3")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C3_SIDE")
    (blockScale . 0.06) 
)

(
    (blockName  . "8TRAC_RECEPTACLE_C4_UP")
    (description . "DUPLEX RECEPTACLE C4")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C4_UP")
    (blockScale . 0.06)
) 
  
(
    (blockName  . "8TRAC_RECEPTACLE_C4_SIDE")
    (description . "DUPLEX RECEPTACLE C4")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "8TRAC_RECEPTACLE_C4_SIDE")
    (blockScale . 0.06)
)


  
(
    (blockName  . "MM_CONNECTOR_UP")
    (description . "M/M CONNECTOR")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "MM_CONNECTOR_UP")
    (blockScale . 0.09)
)
  
  (
    (blockName  . "8TRAC_H_CONNECTOR")
    (description . "H CONNECTOR")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "8TRAC_H_CONNECTOR")
    (blockScale . 0.09)
)

;=================================================
; PHASE 3
;=================================================


  

(
    (blockName  . "SINGLEBLOCKPHASE3")
    (description . "PHASE 3 24\" BLOCK")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SINGLEBLOCKPHASE3")   
    (blockScale . 0.06)
)

  
(    (blockName  . "DOUBLEBLOCKPHASE3")
    (description . "PHASE 3 30\" BLOCK")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "DOUBLEBLOCKPHASE3")
    (blockScale . 0.06)
)
  
(
    (blockName  . "C1_RECEPTACLE")
    (description . "DUPLEX RECEPTACLE C1")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "C1_RECEPTACLE")
    (blockScale . 0.06)
)
  
(
    (blockName  . "C2_RECEPTACLE")
    (description . "DUPLEX RECEPTACLE C2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "C2_RECEPTACLE")
    (blockScale . 0.06)
)
  
(
    (blockName  . "C3_RECEPTACLE")
    (description . "DUPLEX RECEPTACLE C3")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "C3_RECEPTACLE")
    (blockScale . 0.06)
)
  
  
  

  
  (
    (blockName  . "BLUEJUMPERFINISH")
    (description . "XX\" F/F PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
  (
    (blockName  . "BLUEJUMPEREND")
    (description . "XX\" F/F/M 3-WAY PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_3WAY_BLUEJumper")
    (blockScale . 0.0015)
)


;=================================================
; PATTERN
;=================================================
  

(
    (blockName  . "WHITE_BLOCK")
    (description . "WHITE CONNECTION BLOCK")
    (partNumber . "BE07591-FFE")
    (symbolBlock . "WHITE_BLOCK")
    (blockScale . 0.06)
)

(
    (blockName  . "PINECONE_BLOCK")
    (description . "PINECONE CONNECTION BLOCK")
    (partNumber . "BE07591-FFF")
    (symbolBlock . "PINECONE_BLOCK")
    (blockScale . 0.06)
)

(
    (blockName  . "BLACK_BLOCK")
    (description . "BLACK CONNECTION BLOCK")
    (partNumber . "BE07591-E")
    (symbolBlock . "BLACK_BLOCK")
    (blockScale . 0.06)
)

(
    (blockName  . "GREY_BLOCK")
    (description . "GREY CONNECTION BLOCK")
    (partNumber . "BE07591-EF")
    (symbolBlock . "GREY_BLOCK")
    (blockScale . 0.06)
)

(
    (blockName  . "HCONNECTOR")
    (description . "H-CONNECTOR")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "HCONNECTOR")
    (blockScale . 0.06)
)

;=================================================
; INTERLINK
;=================================================

(
    (blockName  . "SMART_INFEED")
    (description . "IQ 2.0 CONTROL BOX")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_SMART_INFEED")
    (blockScale . 1.00)
)
  
  ;=================================================
; ACCESSORIES
;=================================================

(
    (blockName  . "AXIL_X")
    (description . "AXIL X")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "AXIL_X")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "AXIL_Z_3_WIN")
    (description . "AXIL Z 3 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "AXIL_Z_3_WIN")   
    (blockScale . 0.06)
)


(
    (blockName  . "DEAN")
    (description . "DEAN")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "DEAN")
    (blockScale . 0.06)
)

(
    (blockName  . "DEAN_2_WINDOW")
    (description . "DEAN 2 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "DEAN_2_WINDOW")
    (blockScale . 0.06)
)

(
    (blockName  . "DEAN_3_WINDOW")
    (description . "DEAN 3 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DEAN_3_WINDOW")
    (blockScale . 0.06)
)

  
(
    (blockName  . "E2XB_4WIN_REAL")
    (description . "E2XB 4 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "E2XB_4WIN_REAL")
    (blockScale . 0.06)
)
(
    (blockName  . "ELLORAB_4WIN_REAL")
    (description . "ELLORA B 4 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "ELLORAB_4WIN_REAL")
    (blockScale . 0.06)
)  
  

  (
    (blockName  . "ELLORAB_4WIN_REAL_IQ")
    (description . "ELLORA B 4 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "ELLORAB_4WIN_REAL_IQ")
    (blockScale . 0.06)
)
  

(
    (blockName  . "ELLORAB5WIN")
    (description . "ELLORA B 5 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "ELLORAB5WIN")
    (blockScale . 0.06)
)

(
    (blockName  . "ELLORAB6WIN")
    (description . "ELLORA B 6 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "ELLORAB6WIN")   
    (blockScale . 0.06)
)
  
(
    (blockName  . "DEANHYDRA_3_WINDOW")
    (description . "DEAN HYDRA 3 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "HYDRA_ICON")   
    (blockScale . 1.00)
)

  
  (
    (blockName  . "M2XB_4_WIN")
    (description . "M2XB")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "M2XB_4_WIN")
    (blockScale . 0.06)
)
  
(
    (blockName  . "MHO_3_WIN_2_REAL")
    (description . "MHO 3 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MHO_3_WIN_2_REAL")
    (blockScale . 0.06)
)

  
(
    (blockName  . "MHO_4_WIN_REAL")
    (description . "MHO 4 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MHO_4_WIN_REAL")
    (blockScale . 0.06)
) 
  
(
    (blockName  . "MHOB_3_WIN_2")
    (description . "MHO B HDMI + ETHERNET")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MHOB_3_WIN_2")
    (blockScale . 0.06)
)  
  
(
    (blockName  . "MHOB_3_WIN")
    (description . "MHO B 3 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MHOB_3_WIN")
    (blockScale . 0.06)
)
  

  
(
    (blockName  . "MIKI_2PORTS_UM")
    (description . "XX\" MIKI")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MIKI_2PORTS_UM")
    (blockScale . 0.0015)
)

(
    (blockName  . "MINITAP_4")
    (description . "MINITAP")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MINITAP_4")
    (blockScale . 0.06)
)
  
(
    (blockName  . "MINITAP_SLIDE_MOUNT_2")
    (description . "MINITAP SLIDE MOUNT")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MINITAP_SLIDE_MOUNT_2")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "MINITAP_KEY_SLOT_2")
    (description . "MINITAP KEY SLOT")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MINITAP_KEY_SLOT_2")
    (blockScale . 0.06)
)

(
    (blockName  . "NACRE")
    (description . "NACRE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NACRE")
    (blockScale . 0.06)
)

(
    (blockName  . "NACRE_2_PORT")
    (description . "NACRE 2 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NACRE_2_PORT")
    (blockScale . 0.06)
)

(
    (blockName  . "NAICA")
    (description . "NAICA")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NAICA")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "NAICA_4W")
    (description . "NAICA 4 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NAICA_4W")   
    (blockScale . 0.0007)
)

  
  (
    (blockName  . "NODE_SIDE")
    (description . "NODE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NODE_SIDE")
    (blockScale . 0.06)
)

(
    (blockName  . "RIO")
    (description . "RIO")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "RIO")
    (blockScale . 0.06)
)

(
    (blockName  . "START")
    (description . "START")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START")
    (blockScale . 0.06)
)
  
(
    (blockName  . "START_EM_2_WIN")
    (description . "START EM 2 WIN")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_EM_2_WIN")   
    (blockScale . 0.06)
)
  
(
    (blockName  . "START_EM_3_WIN")
    (description . "START EM 3 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_EM_3_WIN")   
    (blockScale . 0.06)
)


  
(
    (blockName  . "START_Z_2_WIN")
    (description . "START Z 2 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_Z_2_WIN")
    (blockScale . 0.06)
)

(
    (blockName  . "START_Z_3_WIN")
    (description . "START Z 3 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_Z_3_WIN")
    (blockScale . 0.06)
)

)

)