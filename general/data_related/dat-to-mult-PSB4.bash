awk '{print $2}' aug-cc_BL.data aug-cc_B1.data aug-cc_B3.data aug-cc_BH.data aug-cc_CAM.data aug-cc_CC2.data aug-cc_CCSD.data > aug-temp
awk '{print $2}' ccpvdz_BL.data ccpvdz_B1.data ccpvdz_B3.data ccpvdz_BH.data ccpvdz_CAM.data ccpvdz_CC2.data ccpvdz_CCSD.data ccpvdz_CC3.data > cc-temp
awk '{print $2}' aug-pople_BL.data aug-pople_B1.data aug-pople_B3.data aug-pople_BH.data aug-pople_CAM.data aug-pople_CC2.data aug-pople_CCSD.data aug-pople_CC3.data > aug-p-temp
awk '{print $2}' pople_BL.data pople_B1.data pople_B3.data pople_BH.data pople_CAM.data pople_CC2.data pople_CCSD.data pople_CC3.data > pople-temp

tr -s '\n'  ' ' < aug-temp > aug-temp-PSB4
tr -s '\n'  ' ' < cc-temp > cc-temp-PSB4
tr -s '\n'  ' ' < aug-p-temp > aug-p-temp-PSB4
tr -s '\n'  ' ' < pople-temp > pople-temp-PSB4
rm *temp* 
