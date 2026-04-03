$ $Header$
$ ALTER for MSC/NASTRAN 2013.1.1 SOL 103 (Adattato da 2024.1)
$ SOL 103 MODAL ANALYSIS - output using standard OP2
$
$ OUTPUT FILES:
$   mbdyn_modal.mat : Modal matrices (MHH, KHH, LUMPMS) via OUTPUT4
$   <model>.op2     : Geometry (GEOM1) and mode shapes (OUG1) - standard Nastran output

ASSIGN OUTPUT4='mbdyn_modal.mat' STATUS=UNKNOWN UNIT=15

SOL 103

TIME 500

$ Output modal matrices after XREAD computes them
COMPILE      XREAD
ALTER        120, 120

$ Rename MIX to MHH (modal mass) for femgen compatibility
EQUIVX       MIX/MHH/-1 $

$ Build KHH (diagonal eigenvalues matrix) from LAMA table
LAMX         , ,LAMA/KHH/-1 $

$ Output MHH and KHH to mbdyn_modal.mat (continue writing, don't close)
OUTPUT4      MHH,KHH,,//-1/15 $

$ Ripristina il RETURN originale del modulo XREAD
RETURN       $
ENDALTER

$ Output lumped mass from SEDRCVR
COMPILE      SEDRCVR
ALTER        1178, 1178

DIAGONAL     MGG/LUMPMS/'COLUMN'/1. $
OUTPUT4      LUMPMS,,,//-2/15 $

$ Ripristina il RETURN originale del modulo SEDRCVR
RETURN       $
ENDALTER