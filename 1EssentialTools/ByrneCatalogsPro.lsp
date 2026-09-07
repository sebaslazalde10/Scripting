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
    (blockName  . "4T_CORDED_PLD_REAL")
    (description . "XX\" Corded Power Entry")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYMBOL_4T_CORDED_PLD")   
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
    (blockName  . "4T_JUMPER_SIDE_BEGIN2")
    (description . "XX\" F/F JUMPER")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
  (
    (blockName  . "4T_JUMPER_SIDE_BEGIN3")
    (description . "XX\" F/F JUMPER")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
  
  (
    (blockName  . "4T_JUMPER_SIDE_BEGIN4")
    (description . "XX\" F/F JUMPER")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)

 (
    (blockName  . "4T_JUMPER_SIDE_BEGIN_REAL_2")
    (description . "XX\" F/F JUMPER")
    (partNumber . "BE41917-X-X-XX-XX")
    (symbolBlock . "SYM_BLUEJumper_4T")
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
    (blockName  . "4T_C1_DUPLEX_RECEPTACLE_UP_REAL")
    (description . "RECEPTACLE BLOCK CIRCUIT 1")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_C1_DUPLEX_RECEPTACLE_UP_REAL")   
    (blockScale . 0.06)
)


(
    (blockName  . "4T_C2_DUPLEX_RECEPTACLE_UP_REAL")
    (description . "RECEPTACLE BLOCK CIRCUIT 2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_C2_DUPLEX_RECEPTACLE_UP_REAL")   
    (blockScale . 0.06)
)
  
  (
    (blockName  . "4T_C3_DUPLEX_RECEPTACLE_UP_REAL")
    (description . "RECEPTACLE BLOCK CIRCUIT 2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_C3_DUPLEX_RECEPTACLE_UP_REAL")   
    (blockScale . 0.06)
)
  
  (
    (blockName  . "4T_C4_DUPLEX_RECEPTACLE_UP_REAL")
    (description . "RECEPTACLE BLOCK CIRCUIT 2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_C4_DUPLEX_RECEPTACLE_UP_REAL")   
    (blockScale . 0.06)
)
  
  (
    (blockName  . "4T_C6_DUPLEX_RECEPTACLE_UP_REAL")
    (description . "RECEPTACLE BLOCK CIRCUIT 2")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_C6_DUPLEX_RECEPTACLE_UP_REAL")   
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
  
(
    (blockName  . "4T_RCP_TO_RCP")
    (description . "RECEPTACLE TO RECEPTACLE BLOCK CONNECTOR")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_RCP_TO_RCP")   
    (blockScale . 0.06)
)

  
  (
    (blockName  . "4T_JUMP_BEGIN_REAL")
    (description . "XX\" F/F Jumper")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYMBOL_4T_JUMP")   
    (blockScale . 1.00)
)



(
    (blockName  . "4T_H_CONNECTOR_REAL")
    (description . "H CONNECTOR, 4 WAY MALE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "4T_H_CONNECTOR_REAL")   
    (blockScale . 1.00)
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
    (blockName  . "BLUEJUMPERFINISH2")
    (description . "XX\" F/F PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
  (
    (blockName  . "BLUEJUMPERFINISH3")
    (description . "XX\" F/F PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_BLUEJumper")
    (blockScale . 1.00)
)
  
  (
    (blockName  . "BLUEJUMPERFINISH4")
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

  
  (
    (blockName  . "BLUEJUMPEREND2")
    (description . "XX\" F/F/M 3-WAY PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_3WAY_BLUEJumper")
    (blockScale . 0.0015)
)
  
  (
    (blockName  . "BLUEJUMPEREND3")
    (description . "XX\" F/F/M 3-WAY PASS THRU")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "SYM_3WAY_BLUEJumper")
    (blockScale . 0.0015)
)

;=================================================
; PATTERN
;=================================================

  (
    (blockName  . "CordedEndConnectorPat")
    (description . "XX\" POWER INFEED")
    (partNumber . "BE07590-E-72")
    (symbolBlock . "SYM_CORD_CONNECTOR") ;;OK
    (blockScale . 1.00)
)
  
   (
    (blockName  . "CordedEndConnectorPat1")
    (description . "XX\" POWER INFEED")
    (partNumber . "BE07590-E-72")
    (symbolBlock . "SYM_CORD_CONNECTOR") ;;OK
    (blockScale . 1.00)
)
  
   (
    (blockName  . "CordedEndConnectorPat2")
    (description . "XX\" POWER INFEED")
    (partNumber . "BE07590-E-72")
    (symbolBlock . "SYM_CORD_CONNECTOR") ;;OK
    (blockScale . 1.00)
)
  
  (
    (blockName  . "SNAPIN_DUPLEX_REAL")
    (description . "SNAPIN DUPLEX REAL")
    (partNumber . "BE010115-F-X-XX")
    (symbolBlock . "SNAPIN_DUPLEX_REAL")
    (blockScale . 0.03)
)
  
  (
    (blockName  . "GREY_BLOCK")
    (description . "GREY CONNECTION BLOCK")
    (partNumber . "BE07591-EF")
    (symbolBlock . "GREY_BLOCK")
    (blockScale . 0.06)
)

  (
    (blockName  . "newJumperOrangeEndEndPat2")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)
  
  (
    (blockName  . "newJumperOrangeEndEndPat")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)



  
(
    (blockName  . "newJumperOrangeEndEndPat3")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)
  
(
    (blockName  . "newJumperOrangeEndEndPat4")
    (description . "XX\" JUMPER")
    (partNumber . "PATTERN: BE07592-E-XX")
    (symbolBlock . "SYM_NEW_JUMPER_ORANGE") ;;OK
    (blockScale . 1.00)
)

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
    (blockName  . "DEAN_EM_3_WINDOW_REAL")
    (description . "DEAN 3 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DEAN_EM_3_WINDOW_REAL")
    (blockScale . 0.018)
)
  
  (
    (blockName  . "DEAN_UM_3_WINDOW_REAL")
    (description . "DEAN 3 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DEAN_UM_3_WINDOW_REAL")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "DEAN_Z_2_WINDOW_REAL")
    (description . "DEAN Z 2 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DEAN_Z_2_WINDOW_REAL")
    (blockScale . 0.06)
)
  
  (
    (blockName  . "DEAN_2_W_IN_SURFACE_TOPVIEW")
    (description . "DEAN X W IN SURFACE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "DEAN_2_W_IN_SURFACE_TOPVIEW") 
    (blockScale . 0.06 )
)

  
   (
    (blockName  . "DEAN_4_W_IN_SURFACE_2P_2AC_REAL")
    (description . "DEAN Z 4 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DEAN_4_W_IN_SURFACE_2P_2AC_REAL")
    (blockScale . 0.06)
)

(
    (blockName  . "DUBBEL_2P_1AC_REAL")
    (description . "DUBBEL 2P 1AC")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "DUBBEL_2P_1AC_REAL")
    (blockScale . 0.06)
)

  
(
    (blockName  . "E2XB_4WIN_REAL")
    (description . "E2XB 4 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "E2XB_4WIN_REAL")
    (blockScale . 0.06)
)
  
  
    ;=================================================
  ;ELLORA
  ;=================================================
  
  
  (
    (blockName  . "ELLORA_6WIN_REAL")
    (description . "ELLORA 6 WINDOW")
    (partNumber . "XXXX-XXX") 
    (symbolBlock . "ELLORA_6WIN_REAL")
    (blockScale . 0.06)
) 
  
  
  ;=================================================
  ;ELLORA B
  ;=================================================
  
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
  
  
  
;=================================================
;ELLORA WELL
;================================================= 
  
 (
    (blockName  . "ELLORA_WELL")
    (description . "ELLORA WELL")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "ELLORA_WELL")   
    (blockScale . 0.03)
) 
  
  
(
    (blockName  . "DEANHYDRA_3_WINDOW")
    (description . "DEAN HYDRA 3 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "HYDRA_ICON")   
    (blockScale . 1.00)
)
  
  
(
    (blockName  . "HYDRA_SMALL")
    (description . "HYDRA")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "HYDRA_SMALL")   
    (blockScale . 0.06)
)
  
  
  (
    (blockName  . "KIA_SIDE")
    (description . "KIA")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "KIA_SIDE")   
    (blockScale . 0.03)
)
  
  (
    (blockName  . "KIA_TOP")
    (description . "KIA")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "KIA_TOP")   
    (blockScale . 0.03)
)
  
  
  
  
  
  
  
(
    (blockName  . "M2X_4_WIN_REAL")
    (description . "M2X 4 WINDOW")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "M2X_4_WIN_REAL")
    (blockScale . 0.06)
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
    (blockName  . "MINITAP_UM_REAL")
    (description . "MINITAP UNDER MOUNT")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "MINITAP_UM_REAL")
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
    (blockName  . "NODE_UP")
    (description . "NODE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NODE_UP") 
    (blockScale . 0.03 )
)
  
  (
    (blockName  . "NODE_UP2")
    (description . "NODE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NODE_UP2") 
    (blockScale . 0.03 )
)
  
  (
    (blockName  . "NODE_UP3")
    (description . "NODE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NODE_UP3") 
    (blockScale . 0.06 )
)
  
(
    (blockName  . "NODE_UP4")
    (description . "NODE")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "NODE_UP4") 
    (blockScale . 0.06 )
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
    (blockName  . "START_UM_2_WIN_REAL")
    (description . "START UM 2 WIN")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_UM_2_WIN_REAL")   
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

  
  (
    (blockName  . "START_ZM_4_WINDOWS_REAL")
    (description . "START Z 4 WINDOWS")
    (partNumber . "XXXX-XXX")
    (symbolBlock . "START_ZM_4_WINDOWS_REAL")
    (blockScale . 0.02)
)
)

)