INCLUDE "consts.asm"
INCLUDE "sprites.asm"
INCLUDE "hardware.asm"

ORG &00

.c64start

INCLUDE "gamevars.asm"

.frametable
;INCBIN "frametable.bin"
.framedefs
;INCBIN "framedefs.bin"

ORG &FFFF
.c64end

SAVE "c64_built", c64start, c64end
