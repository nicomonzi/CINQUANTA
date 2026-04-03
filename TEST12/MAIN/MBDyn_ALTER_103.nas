$ $Header$
$ ALTER for MSC/NASTRAN (Versione Formattata per compatibilità universale)
$ SOL 103 MODAL ANALYSIS - output using standard OP2
$
$ OUTPUT FILES:
$    mbdyn_modal.op4 : Modal matrices (MHH, KHH, LUMPMS) via OUTPUT4 (ASCII)
$    <model>.op2     : Geometry (GEOM1) and mode shapes (OUG1)

$ MODIFICA: Aggiunto FORM=FORMATTED per evitare errori binari in femgen/MATLAB
ASSIGN OUTPUT4='mbdyn_modal.op4' STATUS=UNKNOWN UNIT=15 FORM=FORMATTED

SOL 103
TIME 500

$ Output modal matrices after XREAD computes them
COMPILE      XREAD
ALTER        120, 120

$ Rename MIX to MHH (modal mass)
EQUIVX        MIX/MHH/-1 $

$ Build KHH (diagonal eigenvalues matrix) from LAMA table
LAMX          , ,LAMA/KHH/-1 $

$ Output MHH and KHH (Formato testo)
OUTPUT4      MHH,KHH,,//-1/15 $

RETURN       $
ENDALTER

$ Output lumped mass from SEDRCVR
COMPILE      SEDRCVR
ALTER        1178, 1178

DIAGONAL     MGG/LUMPMS/'COLUMN'/1. $
OUTPUT4      LUMPMS,,,//-2/15 $

RETURN       $
ENDALTER