INCLUDE "hardware.asm"
INCLUDE "consts.asm"
INCLUDE "sprites.asm"
INCLUDE "rooms.asm"

ORG &00

.c64start

INCLUDE "gamevars.asm"

; Zero page vars
v0001 = &01
v0002 = &02

v0035 = &35
v0036 = &36

v0045 = &45

v00AC = &AC
v00AD = &AD
v00AE = &AE
v00AF = &AF
v00B0 = &B0
v00B1 = &B1
v00B2 = &B2
v00B3 = &B3
v00B4 = &B4
v00B5 = &B5
v00B6 = &B6
v00B7 = &B7

v00BE = &BE

v00C2 = &C2
v00C3 = &C3
v00C4 = &C4
v00C5 = &C5

v00CC = &CC

; Cache for something
v00FB = &FB
v00FC = &FC
v00FD = &FD
v00FE = &FE
v00FF = &FF

; 6502 stack
ORG &0100
{
  LDA #&00
  STA v00FB
  STA v00FC

  LDA #&80:STA vDE00

  LDX #&FB
  TXS
  STX v00CC

  LDA CIA2_PRA:AND #&CF:STA CIA2_PRA

.l0118
  BIT CIA2_PRA
  BVC l0118
  BPL l0118

.l011F
  BIT GFX_VICII_REG1
  BPL l011F

.l0124
  BIT GFX_VICII_REG1
  BMI l0124

  JSR lFDA3

  LDA GFX_VICII_REG1:ORA #&10:STA GFX_VICII_REG1

  JSR l7F40
  JSR l1B00

  CLI

  JMP l2000
}

v0200 = &0200
v0282 = &0282
v028D = &028D
v0288 = &0288
v0300 = &0300
v0314 = &0314
v0315 = &0315
v0339 = &0339
v033D = &033D
v033E = &033E
v033F = &033F
v0340 = &0340
v0342 = &0342
v0343 = &0343
v0344 = &0344
v0345 = &0345
v0346 = &0346
v0347 = &0347
v0349 = &0349
v034A = &034A
v034B = &034B
v034E = &034E
v0352 = &0352
v0354 = &0354
v0355 = &0355
v0356 = &0356
v0357 = &0357
v035C = &035C
v035E = &035E
v035F = &035F
v0360 = &0360
v0361 = &0361
v0366 = &0366
v0368 = &0368
v0369 = &0369
v036A = &036A
v036B = &036B
v0370 = &0370
v037A = &037A
v0384 = &0384
v038E = &038E
v0398 = &0398
v03A2 = &03A2
v03AC = &03AC
v03B6 = &03B6
v03C1 = &03C1
v03C2 = &03C2
v03C3 = &03C3
v03C4 = &03C4
v03C5 = &03C5
v03C6 = &03C6
v03C7 = &03C7
v03C8 = &03C8
v03C9 = &03C9
v03D5 = &03D5
v03D6 = &03D6
v03D7 = &03D7
v03D8 = &03D8
v03D9 = &03D9
v03DA = &03DA
v03DB = &03DB
v03DC = &03DC
v03DD = &03DD
v03DF = &03DF
v03E0 = &03E0
v03E1 = &03E1
v03E2 = &03E2
v03E3 = &03E3
v03E4 = &03E4
v03E5 = &03E5
v03E7 = &03E7
v0600 = &0600

ORG &087F
{
  LDA #&00
  TAY

.l0882
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l0890

  CPY #&1A
  BCC l0893

.l0890
  STA v0300,Y

.l0893
  INY
  BNE l0882

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80
  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l08B7

  LDY #&A0

.l08B7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

; &08CA
EQUB &6A
EQUB &FC
EQUB &CD
EQUB &FB
EQUB &31
EQUB &EA
EQUB &2C
EQUB &F9

{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
}

.v08FC
.v0915
.v092E
.v0947

ORG &0961
.stringptr_lo
{
  EQUB LO(string0)
  EQUB LO(string1)
  EQUB LO(string2)
  EQUB LO(string3)
  EQUB LO(string4)
  EQUB LO(string5)
  EQUB LO(string6)
  EQUB LO(string7)
  EQUB LO(string8)
  EQUB LO(string9)
  EQUB LO(string10)
  EQUB LO(string11)
  EQUB LO(string12)
  EQUB LO(string13)
  EQUB LO(string14)
  EQUB LO(string15)
  EQUB LO(string16)
  EQUB LO(string17)
  EQUB LO(string18)
  EQUB LO(string19)
  EQUB LO(string20)
  EQUB LO(string21)
  EQUB LO(string22)
  EQUB LO(string23)
  EQUB LO(string24)
}
.stringptr_hi
{
  EQUB HI(string0)
  EQUB HI(string1)
  EQUB HI(string2)
  EQUB HI(string3)
  EQUB HI(string4)
  EQUB HI(string5)
  EQUB HI(string6)
  EQUB HI(string7)
  EQUB HI(string8)
  EQUB HI(string9)
  EQUB HI(string10)
  EQUB HI(string11)
  EQUB HI(string12)
  EQUB HI(string13)
  EQUB HI(string14)
  EQUB HI(string15)
  EQUB HI(string16)
  EQUB HI(string17)
  EQUB HI(string18)
  EQUB HI(string19)
  EQUB HI(string20)
  EQUB HI(string21)
  EQUB HI(string22)
  EQUB HI(string23)
  EQUB HI(string24)
}

; Set char mapping for small font
MAPCHAR ';','Z', 187

.string0 EQUS "DANGER@:BLASTING:AREA@_"
.string1 EQUS "IF:YOU:ARE:LOOKING:FOR:MORE:COINS<:THEN:TRY:EVERYWHERE@:YOU:CAN;T:ALWAYS:SEE:THEM>:YOU:MAY:HAVE:TO:PICK:THINGS:UP:FIRST@_"
.string2 EQUS "THE:SNOGGLES:TREEHOUSE:COMPLEX:=:DESERTED:NOW<:SINCE:THE:THREAT:OF:TOURISTS:RUINING:THE:PEACEFUL:LIFE>_"
.string3 EQUS "LEGEND:HAS:IT:THAT:HOOKJAW:THE:PIRATE<:BURIED:HERE<:STILL:GUARDS:HIS:TREASURE>_"
.string4 EQUS "WARNING@:MAGIC:WALL:OF:WATER@_"
.string5 EQUS "THE:SMUGGLER;S:CAVE:INGENIOUS:GLASS:SWORD:ON:GRAVESTONE:LOCK>:COPYRIGHT:ROGER:=:INFAMOUS:=:PIRATE_"
.string6 EQUS "YOU;VE:FOUND:BLACKBEARD;S:SECRET:KITCHEN:=:IDEAL:FOR:MIDNIGHT:SNACKS@_"
.string7 EQUS "NO:BOARDING:THE:BOAT:UNTIL:IT:IS:MOVING@_"
.string8 EQUS "CONGRATULATIONS@:YOU:HAVE:SOLVED:ALL:THE:PUZZLES:AND:TRULY:EARNED:YOUR:FREEDOM@:GOOD:LUCK:DIZZY@@_"
.string9 EQUS "SUPPOSE:YOU:WANT:OFF:THIS:ISLAND?:I;LL:SWAP:YOU:A:BOAT:FOR:SOMETHING:VALUABLE>_"
.string10 EQUS "I:GUESS:YOU;LL:BE:WANTING:A:MOTOR>:GOT:ONE:BACK:HERE:=:BUT:IT;LL:COST:YOU@_"
.string11 EQUS "WHAT:DO:YOU:MEAN:YOU:NEED:PETROL?:WELL<:YOU:AIN;T:HAVING:IT:FREE@_"
.string12 EQUS "BACK:AGAIN@@:AHH<:YOU;LL:WANT:AN:IGNITION:KEY>:I;D:LOVE:TO:GIVE:IT:TO:YOU<:BUT:I;VE:MY:OVERHEADS:TO:COVER>:_"
.string13 EQUS "THAT;LL:DO:NICELY<:THANK:YOU>:HERE;S:THE:BOAT:YOU:NEED:=:TAKE:IT:TO:THE:PIER>_"
.string14 EQUS "AHH:THANKS>:HERE;S:THE:MOTOR:I:PROMISED:YOU>_"
.string15 EQUS "HELLO:SIR@:BACK:FOR:THAT:PETROL?:I;LL:THROW:THE:CAN:IN:FOR:FREE:=:CAN;T:SAY:FAIRER:THAN:THAT@_"
.string16 EQUS "WELL<:HERE:YOU:GO@:YOU;VE:BEEN:MY:BEST:CUSTOMER:=:ACTUALLY:YOU;VE:BEEN:MY:ONLY:CUSTOMER@_"
.string17 EQUS "NO:GOOD:TO:ME:=:AND:IF:IT:WAS<:I;D:HAVE:BOUGHT:IT:MYSELF@_"
.string18 EQUS "HERE@:THERE;S:TAX:TO:PAY:ON:THOSE:BOXING:GLOVES@:NEXT:TIME<:BRING:ME:THIRTY:GOLD:COINS>_"
.string19 EQUS "THIRTY:GOLD:COINS@@:WELL:DONE<:DIZZY@:A:BRILLIANT:PERFORMANCE@@_"
.string20 EQUS "COMMODORE:PROGRAM:BY:IAN:GRAY::DESIGN:BY:THE:OLIVER:TWINS:::::GRAPHICS:BY:NEIL:ADAMSON::::::::::::CODEMASTERS_"
.string21
.string22
.string23
.string24 EQUS "_"

; Reset char mappings
MAPCHAR ';','Z', 59

ORG &0FE8
{
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA
  LDA #&00
}

.v1140
.v1180

ORG &11C0
{
  EQUS "::::::AN:OLD:SOLID:CHEST::::::"
  EQUS ":::::::::::A:BIBLE::::::::::::"
  EQUS ":::::::A:RUBBER:SNORKEL:::::::"
  EQUS ":::::::A:MICROWAVE:OVEN:::::::"
  EQUS ":::::A:TUBE:OF:TOOTHPASTE:::::"
  EQUS "::::::::A:BAG:OF:GOLD:::::::::"
  EQUS "::::::::A:RUSTY:BUCKET::::::::"
  EQUS "::::::::A:CAN:OF:PETROL:::::::"
  EQUS ":::::A:SMALL:VIDEO:CAMERA:::::"
  EQUS ":::::SINCLAIR:ABUSER:MAG::::::"
  EQUS "::::::A:DEHYDRATED:BOAT@::::::"
  EQUS "::::::AN:OUTBOARD:MOTOR:::::::"
  EQUS ":::::::::A:GOLDEN:KEY:::::::::"
  EQUS ":::::::THE:IGNITION:KEY:::::::"
  EQUS ":::::A:SHARP:GLASS:SWORD::::::"
  EQUS "::::AN:INFRA=RED:DETONATOR::::"
  EQUS "::::TWO:STICKS:OF:DYNAMITE::::"
  EQUS "::::::A:SALT=WATER:SPADE::::::"
  EQUS "::::::A:WOODCUTTER;S:AXE::::::"
  EQUS ":::::THE:CURSED:TREASURE::::::"

  EQUS "::::AN:EXTINCT:SPECIES@@::::::"
  EQUS ":::::A:WOODEN:SAFETY:RAIL:::::"
  EQUS ":::::A:BIT:OF:TREE:TRUNK::::::"
  EQUS ":::::A:BIT:OF:TREE:TRUNK::::::"
  EQUS ":::::A:WOODEN:SAFETY:RAIL:::::"
  EQUS ":::::A:CLUMP:OF:MUSHROOMS:::::"
  EQUS ":::::A:MISTY:GLASS:WINDOW:::::"
  EQUS "::::AN:ENDANGERED:SPECIES:::::"
  EQUS ":::::A:PROTECTED:SPECIES::::::"
  EQUS "::::::AN:IMITATION:SKULL::::::"
  EQUS "::::::AN:IMITATION:SKULL::::::"
  EQUS ":::::A:BIG:RED:HEAVY:ROCK:::::"
  EQUS "::::AN:ENDANGERED:SPECIES:::::"
  EQUS ":::::::::::NOTHING::::::::::::"
}

.v1644
.v164E
.v1658
.v1662
.v166C
.v1676
.v1680
.v1692
.v1694
.v1697
.v1699
.v169E
.v16A3
.v16A8
.v16AD
.v16B2
.v16BC
.v1800
.v1818
.v1900
.v1A00
.v1B00
.l1B00
.v1B39
.v1B72

ORG &2000
.l2000
{
  JMP l20E7
}

.v200E
.v2028
.v2077
.v2097
.v209F
.v20B8 ; lowercase alphabet
.v20D1
.v20D8

.v20D9 ; ?? just dropped object id ??
.v20DA ; holding object id #1
.v20DB ; holding object id #2
.v20DC ; holding object id #3
.v20DD ; ?? just picked up object id ??

.v20DE ; score (hundred thousands)
.v20E0 ; score (thousands)
.v20E1 ; score (hundreds)

.v20E4

.v20E5 ; coins (tens)
.v20E6 ; score (units)

ORG &20E7
.l20E7
{
  JSR l3080

  LDX #&C9
  LDA #&00

.l20EE
  STA v0339,X

  DEX
  BNE l20EE

  JSR l3B84

  LDA #&00
  JSR l3B84
  JSR l2F77
  JSR l2F91
  JSR l2F91

.^l2105
  LDX #&00:STX GFX_BORDER_COLOUR

.l210A
  JSR l3679

  INX
  CPX #&08
  BCC l210A

  LDX #&FF:STX SPR_ENABLE
  LDA #&00:STA v033F
  LDA #&01
  JSR l2EEF

  LDA #&FF:STA v03DF
  LDA #&B8:STA v03E1
  LDA #&30:STA v03E3
  LDA #&58:STA v03DC
  LDA #&00:STA roomno

  JSR l340B
  JSR l3595
  JSR l2F91

  LDX #&14
  JSR lCB1C

.l2148
  JSR getplayerinput

  LDA player_input
  AND #&10
  BNE l2159

  JSR mergekeypress

  CPY #&3C
  BNE l2148

.l2159
  JSR l3528

  LDX #&00
  TXA

.l215F
  STA v5800,X
  STA v58C8,X
  STA v5990,X
  STA v5A58,X
  STA v5B20,X

  INX
  CPX #&C8
  BCC l215F

  LDA #&03
  JSR l2EEF

  LDA #&00
  STA v20E4
  STA v20E5
  STA v20E6

  LDA #ROOM_START:STA roomno
  LDA #&01:STA SPR_0_COLOUR

  LDA #&00
  LDX #&08

.l2191
  DEX
  STA v20DE,X

  CPX #&00
  BNE l2191

  JSR l2F91

  LDA #&00
  JSR l3B84

  LDA #&00
  STA SPR_Y_EXP
  STA SPR_X_EXP
  STA SPR_MULTICOLOUR
  STA vCFF8
  STA v03E4
  STA SPR_PRIORITY

  LDX #numobjects
.l21B7
  DEX
  LDA orig_rooms,X:STA objs_rooms,X
  LDA orig_xlocs,X:STA objs_xlocs,X
  LDA orig_ylocs,X:STA objs_ylocs,X
  LDA orig_attrs,X:STA objs_attrs,X
  LDA orig_frames,X:STA objs_frames,X

  CPX #&00
  BNE l21B7

  LDA #&1C
  STA v03D6
  STA dizzyx

  LDA #&43
  STA v03D7
  STA dizzyy

  JSR l2F77

  LDA #&06:STA v56F6 ; bucket attrib

  LDX #&00
  TXA

.l21F5
  STA vCA00,X
  DEX
  BNE l21F5

  LDA #&FF:STA v03DF

  LDA #&00
  STA vF084
  STA v03E0

  JSR l3498
  JSR l3AAA

  LDA #&64
  JSR delay

  JSR l30D9

  LDA #&02
  JSR l2EEF

.^l221B
  LDX #&FF
}

.l221D
{
  INX
  CPX #&05
  BCS l2263

  LDA v16A8,X
  BEQ l221D

  AND #&80
  BNE l221D

  LDA v169E,X
  BNE l2243

  INC v16AD,X
  LDA v16AD,X
  CMP v16A3,X
  BCC l221D

  LDA #&00:STA v16AD,X

  JMP l224B
}

.l2243
{
  JSR l3862

  CMP v16A3,X
  BCC l221D

.^l224B
  LDA v1694,X:STA frmx
  LDA v1699,X:STA frmy
  LDA v16A8,X:STA frmattr

  JSR l363E

  JMP l221D
}

.l2263
{
  LDX #&01

.^l2265
  INX
  CPX #&08
  BCS l22A7

  LDA v1680,X
  BEQ l2265

  LDA v1662,X
  BNE l2287

  INC v1676,X

  LDA v1676,X
  CMP v166C,X
  BCC l2265

  LDA #&00:STA v1676,X

  JMP l228F
}

.l2287
{
  JSR l3862

  CMP v166C,X
  BCC l2265

.^l228F
  LDA dizzyx,X:STA frmx
  LDA dizzyy,X:STA frmy
  LDA v1680,X:STA frmattr

  JSR l363E

  JMP l2265
}

.l22A7
{
  LDX #&01
.^l22A9
  INX
  CPX #&08
  BCS l22EB

  JSR l22DA

  BNE l22A9

  LDA v037A,X
  BEQ l22A9

  STX v034E
  INC v03A2,X
  LDA v03A2,X
  CMP v0398,X
  BCC l22D4

  LDA #&00:STA v03A2,X
  LDA v038E,X:STA v5FF8,X

  JMP l22A9
}

.l22D4
{
  INC v5FF8,X

  JMP l22A9
}

.l22DA
{
  INC v16BC,X
  LDA v16BC,X
  CMP v16B2,X
  BCC done

  LDA #&00:STA v16BC,X

.done
  RTS
}

.l22EB
{
  LDX #&00

.^l22ED
  INX
  CPX #&08
  BCC l22F5

  JMP l24CD
}

.l22F5
{
  LDA v037A,X
  BEQ l22ED

  STX v034E

.^l22FD
  LDA v0370,X
  BNE l230D

  JSR l2328

  LDA v037A,X
  BEQ l22ED

  JMP l22FD
}

.l230D
{
  DEC v0370,X
  LDA v0366,X
  CMP #&10
  BCC l231A

  JSR l36D7

.l231A
  JSR l38A8

  LDA v0370,X
  BEQ l22FD

  JSR l37F9

  JMP l22ED
}

.l2328
{
  LDA v037A,X
  TAY

  LDA v1800,Y:STA v00FB
  LDA v1818,Y:STA v00FC

  LDA v0384,X
  TAY
  INC v0384,X

  LDA (&FB),Y
  BNE l2345

  JSR l3679

  RTS
}

.l2345
{
  CMP #&01
  BNE l2350

  JSR l369F

  STA v0366,X

  RTS
}

.l2350
{
  CMP #&02
  BNE l235B

  JSR l369F

  STA v0370,X

  RTS
}

.l235B
{
  CMP #&03
  BNE l2366

  JSR l369F

  STA v03B6,X

  RTS
}

.l2366
{
  CMP #&04
  BNE l2371

  JSR l369F

  STA v03AC,X

  RTS
}

.l2371
{
  CMP #&05
  BNE l237F

  JSR l369F

  STA dizzyx,X

  JSR l37F9

  RTS
}

.l237F
{
  CMP #&06
  BNE l238D

  JSR l369F

  STA dizzyy,X

  JSR l37F9

  RTS
}

.l238D
{
  CMP #&0A
  BNE l2398

.^l2391
  JSR l369F

  STA v0384,X

  RTS
}

.l2398
{
  CMP #&0B
  BNE l23A3

  JSR l369F

  STA v1644,X

  RTS
}

.l23A3
{
  CMP #&0C
  BNE l23AE

  JSR l369F

  STA v164E,X

  RTS
}

.l23AE
{
  CMP #&0F
  BNE l23BB

  JSR l369F

  STA v037A,X

  JMP l2391
}

.l23BB
{
  CMP #&10
  BNE l23C6

  JSR l369F
  JSR l392B

  RTS
}

.l23C6
{
  CMP #&07
  BNE l23E8

  JSR l369F

  STA v038E,X
  STA v5FF8,X

  JSR l369F

  STA v0398,X

  LDA #&00
  STA v03A2,X
  STA v16BC,X

  JSR l369F

  STA v16B2,X

  RTS
}

.l23E8
{
  CMP #&08
  BNE l2400

  JSR l369F

  CMP #&80
  BCC l23F9

  AND v1658,X

  JMP l23FC
}

.l23F9
{
  ORA v1658,X

.^l23FC
  STA v1658,X

  RTS
}

.l2400
{
  CMP #&09
  BNE l244F

  JSR l369F

  STA frmx

  LDA #&01:STA frmy

.l240F
  ASL frmy
  DEX
  BNE l240F

  LDX v034E
  LDY #&1D
  LDA #&01
  JSR l2435

  LDY #&17
  LDA #&02
  JSR l2435

  LDY #&1C
  LDA #&04
  JSR l2435

  LDY #&1B
  LDA #&08
  JSR l2435

  RTS
}

.l2435
{
  AND frmx
  BEQ l2444

  LDA SPR_0_X,Y
  ORA frmy

.^l2440
  STA SPR_0_X,Y

  RTS
}

.l2444
{
  LDA frmy
  EOR #&FF
  AND SPR_0_X,Y

  JMP l2440
}

.l244F
{
  CMP #&0D
  BNE l246B

  JSR l369F

  STA v1662,X

  JSR l369F

  STA v166C,X

  JSR l369F

  STA v1680,X

  LDA #&00:STA v1676,X

  RTS
}

.l246B
{
  CMP #&0E
  BNE l2485

  LDA dizzyx,X:STA frmx
  LDA dizzyy,X:STA frmy

  JSR l369F

  STA frmattr

  JSR l363E

  RTS
}

.l2485
{
  CMP #&11
  BNE l24AB

  LDA v0366,X
  AND #&03
  BEQ l2492

  EOR #&03

.l2492
  STA frmx

  LDA v0366,X
  AND #&0C
  BEQ l24A4

  EOR #&0C
  ORA frmx
  STA frmx

.l24A4
  LDA frmx:STA v0366,X

  RTS
}

.l24AB
{
  CMP #&12
  BNE l24B6

  JSR l369F

  STA SPR_0_COLOUR,X

  RTS
}

.l24B6
{
  CMP #&13
  BNE l24CC

  LDA v1692,X:STA dizzyx,X
  LDA v1697,X:STA dizzyy,X
  LDA #&00:STA v0370,X

  RTS
}

.l24CC
{
  BRK
}

.l24CD
{
  JSR mergekeypress

  CPY #&3E
  BNE l24D7

  JMP l2105
}

.l24D7
{
  CPY #&29
  BNE l24EC

.l24DB
  JSR mergekeypress

  CPY #&40
  BNE l24DB

.l24E2
  JSR mergekeypress

  CPY #&40
  BEQ l24E2

  JMP l250A
}

.l24EC
{
  CPY #&24
  BNE l250A

  JSR l30D9

  LDA v309F
  BEQ l2500

  LDA #&02

  JSR l2EEF

  JMP l2503
}

.l2500
{
  JSR l30F5

.^l2503
  JSR mergekeypress
 
  CPY #&24
  BEQ l2503

.^l250A
  JSR checkcheatmode
  JSR getplayerinput

  LDA #&00:STA v03C1

  LDA #&0F
  JSR delay

  INC v03C4

  NOP
  NOP
  NOP

  LDA #&06:STA v0342

.^l2525
  LDA v03C9
  BEQ l252D

  JMP l25E1
}

.l252D
{
  LDA #&16:STA frmy
  LDA #&01:STA frmx

.l2537
  INC frmx

  LDA frmx
  CMP #&06
  BCS l2550

  JSR l375F

  BEQ l2537

  LDA v033F
  AND #&40
  BEQ l2537

  JMP l2558
}

.l2550
{
  LDA #&03:STA v03C8

  INC dizzyy

.^l2558
  LDA v03C8
  CMP #&03
  BNE l25B4

  LDA #&16:STA frmy
  LDA #&01:STA frmx

.l2569
  INC frmx
  LDA frmx
  CMP #&06
  BCS l25A4

  JSR l375F

  LDA v033E
  BEQ l2569

  LDA v033F
  AND #&40
  BEQ l2569

  LDA player_input
  AND #&0D
  BNE l2594

  LDA #&00
  STA v03C8
  STA v03C7

  JMP l25B4
}

.l2594
{
  LDA #&01:STA v03C8
  LDA v03C2:STA v03C7
  LDA #&00

  JMP l25B4
}

.l25A4
{
  DEC v0342
  LDA v0342
  BEQ l25AF

  JMP l2525
}

.l25AF
{
  LDA #&00:STA player_input

.^l25B4
  LDA v03C8
  CMP #&02
  BCS l25E1

  LDA player_input
  AND #&04
  BNE l25CC

  LDA player_input
  AND #&08
  BNE l25DC

  JMP l25E1
}

.l25CC
{
  LDA #&02

.^l25CE
  STA v03C7
  STA v03C2

  LDA #&01:STA v03C8

  JMP l25E1
}

.l25DC
{
  LDA #&01
  JMP l25CE
}

.l25E1
{
  LDA v03C8
  CMP #&03
  BNE l25EB

.^l25E8
  JMP l26D1
}

.l25EB
{
  CMP #&02
  BEQ l2619

  LDA player_input
  AND #&01
  BNE l25F9

  JMP l25E8
}

.l25F9
{
  LDA player_input
  AND #&0F
  CMP #&01
  BNE l260A

  LDA #&00
  STA v03C7
  STA v03C2

.l260A
  LDA #&02:STA v03C8
  LDA #&00:STA v03C9
  LDA #&11:STA v03C3

.^l2619
  INC v03C9
  LDA v03C9
  CMP #&09
  BCS l2661

  JSR l26AE

.^l2626
  LDA #&00:STA frmy
  LDA #&01:STA frmx

.l2630
  INC frmx
  LDA frmx
  CMP #&06
  BCS l2649

  JSR l375F

  BEQ l2630

  BCC l2630

  LDA #&02:STA v03C1

  JMP l26D1
}

.l2649
{
  DEC dizzyy
  DEC v0342
  LDA v0342
  BNE l2626

  LDA v03C3
  CMP #&0A
  BCC l26D1

  DEC v03C3

  JMP l26D1
}

.l2661
{
  JSR l26AE

.^l2664
  LDA #&16:STA frmy
  LDA #&01:STA frmx

  LDA v03C9
  CMP v03C3
  BCC l26D1

.l2676
  INC frmx
  LDA frmx
  CMP #&06
  BCS l268A

  JSR l375F

  BEQ l2676

  BCC l2676

  JMP l269D
}

.l268A
{
  INC dizzyy
  DEC v0342
  LDA v0342
  BNE l2664

  LDA #&00:STA v03C3

  JMP l26D1
}

.l269D
{
  LDA v03C9
  CMP #&11
  BCS l26A9

  LDA #&01:STA v03C1

.l26A9
  LDA #&00
  JMP l26D1
}

.l26AE
{
  LDA v03C9
  CMP #&07
  BCC l26BE

  CMP #&0B
  BCS l26BE

  LDA #&02

  JMP l26CD
}

.l26BE
{
  CMP #&02
  BCC l26CB

  CMP #&10
  BCS l26CB

  LDA #&04

  JMP l26CD
}

.l26CB
{
  LDA #&06

.^l26CD
  STA v0342

  RTS
}

.l26D1
{
  LDA v03C8
  CMP #&02
  BCS l26F7

  CMP #&00
  BEQ l26E5

  JSR l303C

  DEC v03C8

  JMP l26F7
}

.l26E5
{
  STA v03C8
  STA v03C7
  STA v03C3
  STA v03C9
  STA v03C1

  JMP l2708
}

.l26F7
  LDA v03C7
  BNE l26FF

  JMP l2708

.l26FF
  CMP #&01
  BEQ l271A

  LDA #&00
  JMP l271C

.l2708
{
  LDA v03C1
  CMP #&01
  BNE l2717

  LDA #&00:STA v03C1

  JMP l2626
}

.l2717
{
  JMP l2790
}

.l271A
{
  LDA #&07

.^l271C
  STA frmx

  LDA #&01:STA frmy

  JSR l375F

  BCC l274B

  LDA v03C1
  CMP #&02
  BNE l2738

  LDA #&00:STA v03C1

  JMP l2746
}

.l2738
{
  LDA v03C3
  CMP #&0A
  BCC l2708

  LDA v03C9
  CMP #&09
  BCC l2708

.^l2746
  LDA v033E
  BNE l2708

.^l274B
  LDA #&01:STA frmy

  JSR l375F

  BCS l2708

  LDA #&0C:STA frmy

  JSR l375F

  BCC l2761

  BNE l2708

.l2761
  LDA #&0D:STA frmy

  JSR l375F

  BCC l276D

  BNE l2708

.l276D
  LDA v03C9
  BEQ l277D

  CMP #&09
  BCS l277D

  LDA v033F
  AND #&40
  BNE l2708

.l277D
  LDA v03C7
  CMP #&01
  BNE l278A

  INC dizzyx

  JMP l2790
}

.l278A
{
  DEC dizzyx
  JMP l2790
}

.l2790
{
  LDA v03C8
  CMP #&02
  BNE l27CB

  LDA v03C9
  CMP #&09
  BCC l27CB

  AND #&07
  BNE l27CB

  LDA #&16:STA frmy
  LDA #&00:STA frmx

.l27AC
  INC frmx
  LDA frmx
  CMP #&06
  BCS l27CB

  JSR l375F

  BCC l27AC
  BEQ l27AC

  LDA #&00
  STA v03C8
  STA v03C7
  STA v03C9
  STA v03C3

.l27CB
  LDA #&15:STA frmy

.^l27D0
  LDA #&01:STA frmx

.l27D5
  INC frmx
  LDA frmx
  CMP #&06
  BCS l27EC

  JSR l375F

  BCC l27D5
  BEQ l27D5

  DEC dizzyy

  JMP l2790
}

.l27EC
{
  DEC frmy
  LDA frmy
  CMP #&12
  BCS l27D0

  ; Fall through
}

.checkright
{
  ; Check Dizzy X position < 57 (not gone off screen to right)
  LDA dizzyx
  CMP #57
  BCC checkleft

  ; Dizzy has gone off screen to the right
  LDA #2:STA v03D6 ; Set Dizzy position to far left
  LDA dizzyy:STA v03D7

  ; Go right a room
  INC roomno

  JMP enternewroom
}

.checkleft
{
  ; Check Dizzy X position >= 2 (not gone off screen to left)
  CMP #2
  BCS checkvertup

  LDA #&38:STA v03D6
  LDA dizzyy:STA v03D7

  ; Go left a room
  DEC roomno

  JMP enternewroom
}

.checkvertup
{
  ; Check Dizzy Y position < 128
  LDA dizzyy
  CMP #128
  BCC setdizzyspritepos

  CMP #192
  BCS checkvertdown

  LDA #&00:STA v03D7
  LDA dizzyx:STA v03D6

  ; Go down a room
  LDA roomno:SEC:SBC #MAP_WIDTH:STA roomno

  JMP enternewroom
}

.checkvertdown
{
  ; Check Dizzy Y position < 192 - this will _never_ be the case
  LDA dizzyy
  CMP #192
  BCC setdizzyspritepos

  ; Dizzy has gone off the top of the screen
  LDA #114:STA v03D7 ; Set Dizzy position to bottom
  LDA dizzyx:STA v03D6

  LDA roomno:CLC:ADC #MAP_WIDTH:STA roomno

  ; Fall through
}

.enternewroom
{
  LDA #&00:STA v03E0

  LDA roomno
  JSR l3498

.^setdizzyspritepos
  ; Set Dizzy hardware sprite Y position
  LDA dizzyy:CLC:ADC #90:STA SPR_0_Y

  ; Set Dizzy hardware sprite X position
  LDA dizzyx
  ASL  A      ; * 4
  ASL  A      ;
  CLC:ADC #56 ; + 56
  STA SPR_0_X

  ; Check for overflow
  BCC sprite_lhs

  ; Overflow happened (Dizzy at far rhs), so set bottom bit
  LDA SPR_MSB_X:ORA #&01

  JMP l288E
}

.sprite_lhs
{
  ; No overflow (Dizzy not at far rhs), so clear bottom bit
  LDA SPR_MSB_X:AND #&FE

  ; Fall through
}

.l288E
{
  STA SPR_MSB_X

  LDA v03C8
  BNE l28A3

  LDA v03C7
  BNE l28CC

  ; Set sprite for "idle" animation
  LDA v03C4
  AND #&01
  JMP l28E6
}

.l28A3
{
  CMP #2
  BNE l28CC

  LDA v03C7
  BNE l28B1

  LDA #&02
  JMP l28BC
}

.l28B1
{
  CMP #&01
  BNE l28BA

  LDA #&1A
  JMP l28BC
}

.l28BA
{
  LDA #&22
.^l28BC
  STA v00FF

  LDA v03C9
  SEC:SBC #1
  AND #&07
  CLC:ADC v00FF

  JMP l28E6
}

.l28CC
{
  LDA v03C2
  BEQ l28E6

  CMP #&01
  BNE l28DA

  LDA #&0A
  JMP l28DC

.l28DA
  LDA #&12

.l28DC
  STA v00FF

  LDA v03C4
  AND #&07
  CLC:ADC v00FF

  ; Fall through
}

.l28E6
{
  STA v5FF8
 
  LDA #&FF:STA SPR_ENABLE ; Show sprites

  LDX #&FF
  STX v20D9
  STX v20DD

  LDA v03C7
  BNE l2903

  LDA v03C8
  BNE l2903

  JMP l290B
}

.l2903
{
  LDA player_input
  AND #&EF ; Mask out "FIRE" press
  STA player_input
}

.l290B
{
  LDA player_input
  AND #JOY_FIRE ; Mask only "FIRE" press
  BNE checkpickup

  JMP l2981
}

.checkpickup
{
  LDA dizzyx:CLC:ADC #30
  STA frmx ; X position

  CLC:ADC #8
  STA frmattr ; attribute

  LDA dizzyy
  CLC:ADC #26
  STA frmy ; Y position

  CLC:ADC #34
  STA v033D

  INC v03D9

  LDX v03D9
  CPX #&3F
  BCC objloop

  LDX #&00:STX v03D9
.objloop
  {
  ; Is object in this room ?
  LDA objs_rooms,X
  CMP roomno
  BNE nextobj

  ; Is object X position < (dizzyx + 30) ?
  LDA objs_xlocs,X
  CMP frmx
  BCC nextobj

  ; Is object X position >= (dizzyx + 30 + 8) ?
  CMP frmattr
  BCS nextobj

  ; Is object Y position < (dizzyy + 26) ?
  LDA objs_ylocs,X
  CMP frmy
  BCC nextobj

  ; Is object Y position >= (dizzyy + 26 + 34) ?
  CMP v033D
  BCS nextobj

  ; At this point the object overlaps dizzy
  STX v03D9
  STX v20DD

  JMP l2981

.nextobj
  INX
  CPX v03D9
  BEQ l297C

  ; Is it a collectable object
  CPX #63
  BCC objloop

  LDX #&FF

  JMP nextobj
  }
}

.l297C
{
  LDX #&FF:STX v20DD

.^l2981
  LDA #&00:STA v03DA
  LDA #&03:STA frmx
  LDA #&01:STA frmy

  JSR l375F

  LDA v033F
  AND #&20
  BEQ l299F

  LDA #&0B:STA v03DA

.l299F
  LDA #&01
  STA frmy
  STA v03E7

.l29A7
  LDA #&01:STA frmx

  JSR l375F

  LDA v033F:ORA v03E7:STA v03E7

  LDA #&03:STA frmx

  JSR l375F

  LDA v033F:ORA v03E7:STA v03E7

  LDA #&06:STA frmx
  JSR l375F

  LDA v033F:ORA v03E7:STA v03E7

  LDA frmy
  CLC:ADC #&08
  STA frmy

  CMP #&14
  BCC l29A7

  LDA player_input
  AND #&10
  BNE l29F1

  JMP l2C98
}

.l29F1
{
  LDA v03E7
  AND #&80
  BNE l2A0A

  LDA v03E7
  AND #&30
  CMP #&10
  BNE l2A07

  JSR lCB00

  JMP l2C98
}

.l2A07
{
  JMP l2BED
}

.l2A0A
{
  LDA roomno
  LDX v20DA
  CMP #ROOM_76
  BNE l2A28

  CPX #&00
  BNE l2A28

  JSR l2EB0

  LDA #&4C:STA v559D

  LDX #&3F

  JSR l2ED1

  JMP l2C10
}

.l2A28
{
  CMP #&31
  BNE l2A3B

  CPX #&11
  BNE l2A3B

  LDA #&31:STA v55AF

  JSR l2EB0

  JMP l2C10
}

.l2A3B
{
  CMP #&53
  BNE l2A63

  CPX #&0E
  BNE l2A63

  JSR l2EB0

  LDX #&4A
  JSR l392F

  LDX #&4B
  JSR l392F

  LDX #&4C
  JSR l392F

  LDA #&FD
  STA v55A8
  STA v55A9
  STA v55AA

  JMP l2C10
}

.l2A63
{
  CMP #&35
  BNE l2A7B

  CPX #&0C
  BNE l2A7B

  JSR l2EB0

  LDX #&48

  JSR l392F

  LDA #&FD:STA v55A6

  JMP l2C10
}

.l2A7B
{
  CMP #&6A
  BNE l2A9B

  CPX #&12
  BNE l2A9B

  JSR l2EB0

  LDX #&4E
  JSR l392F

  LDX #&4F
  JSR l392F

  LDA #&FD
  STA v55AC
  STA v55AD

  JMP l2C10
}

.l2A9B
{
  CMP #&62
  BNE l2ABD

  CPX #&10
  BNE l2ABD

  JSR l2EB0

  LDA #&62:STA v55A4
  LDA #&54:STA v5629

  LDX #&45

  JSR l2ED1

  LDX #&46
  JSR l2ED1

  JMP l2C10
}

.l2ABD
{
  CMP #&62
  BNE l2AF3

  CPX #&0F
  BNE l2AF3

  LDA v55A4
  CMP #&62
  BNE l2AF3

  LDA #&07:STA v5736 ; dynamite attrib

  LDX #&46
  JSR l2ED1
  JSR l2EB0

  LDA #&FD
  STA v55A2
  STA v55A4

  LDA #&05
  JSR delay

  LDX #&46
  JSR l392F

  LDX #&44
  JSR l392F

  JMP l2C10
}

.l2AF3
{
  LDA roomno
  LDX v20DA
  CMP #ROOM_86
  BEQ l2B00

  JMP l2B8C
}

.l2B00
{
  LDA v03E4
  AND #&01
  BNE l2B21

  INC v03E4
  LDA v03E4
  CMP #&08
  BCS l2B1E

  LSR  A
  CLC:ADC #&09
  TAX

  JSR lCB1C

  LDX #&06

  JSR l2ED1

.^l2B1E
  JMP l2B8C
}

.l2B21
{
  CPX #&03
  BEQ l2B42

  CPX #&05
  BEQ l2B42

  CPX #&08
  BEQ l2B42

  CPX #&13
  BEQ l2B42

  CPX #&46
  BCS l2B1E

  LDX #&11
  JSR lCB1C

  LDX #&06
  JSR l2ED1

  JMP l2B8C
}

.l2B42
{
  INC v03E4

  JSR l2EB0

  LDA v03E4
  CMP #&09
  BCS l2B8C

  LSR  A
  CLC:ADC #&0C
  TAX

  JSR lCB1C

  LDX #&06
  JSR l2ED1

  LDA v03E4
  LSR  A
  CMP #&01
  BNE l2B69

  LDX #&0A
  JMP l2B81
}

.l2B69
{
  CMP #&02
  BNE l2B72

  LDX #&0B
  JMP l2B81
}

.l2B72
{
  CMP #&03
  BNE l2B7B

  LDX #&07
  JMP l2B81
}

.l2B7B
{
  CMP #&04
  BNE l2B8C

  LDX #&0D
.^l2B81
  STX v20DD

  LDA #ROOM_2:STA objs_rooms,X

  JMP l2C10
}

.l2B8C
{
  LDA roomno
  LDX v20DA
  CMP #ROOM_88
  BNE l2BB1

  LDA v55A5
  CMP #&58
  BEQ l2BB4

  CPX #&0A
  BNE l2BB1

  LDA #&58:STA v55A5

  LDX #&47
  JSR l2ED1
  JSR l2EB0

  JMP l2C10
}

.l2BB1
{
  JMP l2BED
}

.l2BB4
{
  CPX #&07
  BEQ l2BC0

  CPX #&0B
  BEQ l2BC0

  CPX #&0D
  BNE l2BB1

.l2BC0
  DEC v5737

  LDX #&47
  JSR l2ED1
  JSR l2EB0

  LDA v5565
  CMP #&FD
  BNE l2BEA

  LDA v5569
  CMP #&FD
  BNE l2BEA

  LDA v556B
  CMP #&FD
  BNE l2BEA

  LDA #&43:STA v5737
  LDA #&59:STA v55C0

.l2BEA
  JMP l2C10
}

.l2BED
{
  LDA v03DA
  BEQ l2C10

  LDX v20DA
  CPX #&09
  BNE l2C10

  JSR l2EB0

  LDA #&14:STA v034E

.l2C01
  LDA #&01
  JSR l3B84

  LDA #&01
  JSR delay

  DEC v034E
  BNE l2C01

.^l2C10
  LDA v20DD
  CMP #&14
  BCC l2C23

  CMP #&32
  BCS l2C23

  LDA v20D9
  BEQ l2C23

  JMP l2C29
}

.l2C23
{
  LDX v20DA:STX v20D9

.^l2C29
  LDX v20D9
  CPX #&FF
  BNE l2C37

  LDX v20DD
  CPX #&FF
  BEQ l2C95

.l2C37
  LDA #&3F:STA v03DD
  LDA #&00:STA v03D5

.l2C41
  LDA GFX_RASTER_LINE
  CMP #&FA
  BCC l2C41

  JSR l3968

  LDX v20DD
  CPX #&FF
  BEQ l2C5A

  LDA #ROOM_2:STA objs_rooms,X

  JSR l2F35

.l2C5A
  LDX v20D9
  CPX #&FF
  BEQ l2C85

  LDA objs_rooms,X
  CMP #&FD
  BEQ l2C85

  LDX v20DA
  LDA roomno:STA objs_rooms,X

  LDA dizzyx
  CLC:ADC #&21
  AND #&FE
  STA objs_xlocs,X

  LDA dizzyy
  CLC:ADC #&2D
  STA objs_ylocs,X

.l2C85
  LDA #&3F:STA v03DD
  LDA #&FF:STA v03D5
  JSR l3968
  JSR l3595

.l2C95
  JSR l2EFD

.^l2C98
  LDA roomno
  CMP #ROOM_21
  BEQ l2CCF

  LDA SPR_COLLISION
  AND #&01
  BNE l2CBD

  LDA v03DA
  BEQ l2CC0

  LDA roomno
  CMP #ROOM_88
  BEQ l2CBD

  CMP #ROOM_89
  BEQ l2CBD

  LDA v5560
  CMP #&02
  BEQ l2CC0

.l2CBD
  JMP l2EE2
}

.l2CC0
{
  LDA roomno
  CMP #ROOM_105
  BNE l2CCF

  CMP v55A0
  BNE l2CCF

  JMP l2EE2
}

.l2CCF
{
  LDA v03E7
  AND #&80
  BNE l2CD9

  JMP l2D9D
}

.l2CD9
{
  LDA roomno
  CMP #ROOM_165
  BNE l2CED

  LDA v5638
  CMP #&2C
  BNE l2CED

  INC v5638
  JMP l2D9D
}

.l2CED
{
  LDA roomno
  CMP #ROOM_105
  BNE l2D0F

  LDA v5571
  CMP #&02
  BNE l2D0F

  LDA v555F
  CMP #&02
  BEQ l2D0F

  LDA #&69:STA v55A0

  LDX #&42

  JSR l2ED1

  JMP l2D9D
}

.l2D0F
{
  LDA roomno
  CMP #ROOM_134
  BNE l2D33

.l2D16
  LDA v56C0 ; cage Y pos
  CMP #&3C
  BCS l2D30

  LDA #&05
  JSR delay

  INC v56C0 ; cage Y pos
  INC v56C0 ; cage Y pos

  LDX #&56
  JSR l394A

  JMP l2D16
}

.l2D30
{
  JMP l2EE2
}

.l2D33
{
  LDA roomno
  CMP #ROOM_100
  BNE l2D54

.l2D3A
  LDA v56C2 ; cage Y pos
  CMP #&2A
  BCS l2D30

  LDA #&05
  JSR delay

  INC v56C2 ; cage Y pos
  INC v56C2 ; cage Y pos

  LDX #&58
  JSR l394A

  JMP l2D3A
}

.l2D54
{
  LDA roomno
  CMP #ROOM_102
  BNE l2D75

.l2D5B
  LDA v56C4 ; cage Y pos
  CMP #&8A
  BCS l2D30

  LDA #&05
  JSR delay

  INC v56C4 ; cage Y pos
  INC v56C4 ; cage Y pos

  LDX #&5A
  JSR l394A

  JMP l2D5B
}

.l2D75
{
  LDA roomno
  CMP #ROOM_89
  BNE l2D9D

  LDA v20E4
  CMP #&03
  BNE l2D90

  LDA #&05
  JSR l2EEF

  LDX #&13
  JSR lCB1C

  JMP l2105
}

.l2D90
{
  LDA v20E6
  BNE l2D9D

  LDX #&12:STX v20E6
  JSR lCB1C

.^l2D9D
  LDA roomno
  CMP #ROOM_49
  BNE l2DBF

  LDX #&4D
  JSR l392F

  LDA v56B7
  CMP #&A8
  BNE l2DB5

  LDA #&A6
  JMP l2DB7
}

.l2DB5
{
  LDA #&A8

.^l2DB7
  STA v56B7

  LDX #&4D
  JSR l394A

.^l2DBF
  LDA roomno
  CMP #ROOM_49
  BNE l2DEF

  LDA v55AF
  CMP #&31
  BNE l2DEF

  LDX #&51
  JSR l392F

  DEC v56BB ; bubble Y pos
  LDA v56BB ; bubble Y pos
  CMP #&1E
  BCS l2DE1

  LDA #&A0:STA v56BB ; bubble Y pos

.l2DE1
  AND #&02
  LSR  A
  CLC:ADC #&B8
  STA v57C7 ; bubble frame

  LDX #&51
  JSR l394A

.l2DEF
  LDA roomno
  CMP #ROOM_165
  BNE l2E16

  LDA v5638
  CMP #&2C
  BEQ l2E16

  CMP #&3E
  BCS l2E16

  AND #&FE
  STA v5638

  LDX #&54
  JSR l394A

  INC v5638
  INC v5638

  LDX #&54
  JSR l394A

.l2E16
  LDA roomno
  CMP #ROOM_133
  BNE l2E3B

  LDA v5638
  CMP #&2C
  BEQ l2E3B

  LDA v56BF
  CMP #&70
  BCS l2E3B

  LDX #&55
  JSR l392F

  INC v56BF

  LDX #&55
  JSR l2ED1

  JMP l2EA7
}

.l2E3B
{
  LDA v5737
  CMP #&40
  BCC l2EA7

  LDA #&00:STA v03DB

  LDA roomno
  CMP #ROOM_88
  BEQ l2E5D

  CMP #ROOM_89
  BNE l2E65

  LDX #&62:STX v03DB
  JSR l392F

  JMP l2E65
}

.l2E5D
{
  LDX #&47:STX v03DB

  JSR l392F

.^l2E65
  LDA v5737
  AND #&80
  BNE l2E87

  INC v562B
  INC v5646

  LDA v562B
  CMP #&5F
  BCC l2E9F

  LDA v5737
  ORA #&80
  STA v5737
  STA v5752

  JMP l2E9F
}

.l2E87
{
  DEC v562B
  DEC v5646

  LDA v562B
  CMP #&4B
  BCS l2E9F

  LDA v5737
  AND #&7F
  STA v5737
  STA v5752

.^l2E9F
  LDX v03DB
  BEQ l2EA7

  JSR l394A

.^l2EA7
  JSR l3C52
  JSR lCD73

  JMP l221B
}

.l2EB0
{
  LDA #&05
  JSR l3B84
  STX v034E

  LDA #&05
  JSR l392B

  LDA #&0F:STA vCFF8

  LDX v20DA
  LDA #&FD
  STA objs_rooms,X

  STX v20D9
  LDX v034E

  RTS
}

.l2ED1
{
  LDA #&58:STA v03DC
  JSR l394A

  LDA #&00:STA v03DC
  JSR l394A

  RTS
}

.l2EE2
{
  LDA #&07
  JSR l392B

  LDA #&C8
  JSR delay

  JMP l3B24
}

.l2EEF
{
  PHA

  JSR l30D9

  LDA #&00:STA v309F

  PLA

  STA vE000

  RTS
}

.l2EFD
{
  LDX v20DD
  CPX #&14
  BCC l2F15

  CPX #&32
  BCS l2F15

  LDX #&FF:STX v20DD

  LDX v20D9
  CPX #&FF
  BNE l2F15

  RTS
}

.l2F15
{
  LDA #&04
  JSR l392B

  LDX #&00
.l2F1C
  LDA v20DA,X:STA v20D9,X
  INX
  CPX #&04
  BCC l2F1C

  LDA #&FF:STA v20DD

  LDA #&10:STA v0342

  JSR lCE14

  RTS
}

.l2F35
{
  LDX v20DD
  CPX #&14
  BCC l2F64

  CPX #&32
  BCS l2F65

  LDA #&FE:STA objs_rooms,X
  LDA #&06
  JSR l392B

  LDA #&0F:STA vCFF8

  LDA v20E5
  CLC:ADC #&01
  CMP #&0A
  BCC l2F5E

  INC v20E4
  LDA #&00

.l2F5E
  STA v20E5

  JSR l2F91

.^l2F64
  RTS
}

.l2F65
{
  CPX #&3F
  BCS l2F64

  LDA v5551,X
  CMP #&01
  BNE l2F64

  LDA roomno:STA v5551,X

  RTS
}

.l2F77
{
  LDA #&FF
  STA v20D9
  STA v20DA
  STA v20DB
  STA v20DC
  STA v20DD

  LDA #&10:STA v0342

  JSR lCE14

  RTS
}

.l2F91
{
  LDA #&4C:STA frmx
  LDA #&08:STA frmy
  STA v03E3

  LDA #&06:STA frmattr

  LDA v20E4
  CLC:ADC #&30
  JSR l3132

  LDA #&4E:STA frmx
  LDA #&08:STA frmy
  STA v03E3

  LDA #&06:STA frmattr

  LDA v20E5
  CLC:ADC #&30

  JSR l3132

  RTS
}

ORG &2FC8

; Cheat mode key-sequence
.eclipse
{
  EQUB KEY_E
  EQUB KEY_S
  EQUB KEY_P
  EQUB KEY_I
  EQUB KEY_L
  EQUB KEY_C
  EQUB KEY_E
}

cheatcodelen = * - eclipse

; Room number adjustments based on key pressed
;   These indexes map to JOYSTICK bitfield
.roomchange
{
  EQUB 0
  EQUB 32   ; Go up (+32)    Joystick UP / Keyboard "SHIFT" or "COMMODORE" or "CONTROL"
  EQUB 0-32 ; Go down (-32)  Joystick DOWN
  EQUB 0
  EQUB 0-1  ; Go left (-1)   Joystick LEFT / Keyboard "Z"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 1    ; Go right (+1)  Joystick RIGHT / Keyboard "X"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
}

.checkcheatmode
{
  LDX #&00

.nextchar
  ; check last key pressed
  LDA KEY_PRESSED
  CMP eclipse,X
  BEQ awaitchar

  RTS

.awaitchar
  ; Wait for last key pressed to change
  LDA KEY_PRESSED
  CMP eclipse,X
  BEQ awaitchar

  ; Move on to check next character of cheat code
  INX
  CPX #cheatcodelen
  BCC nextchar

  ; ### Cheat mode activate ###

  LDA #&00:STA SPR_ENABLE ; Hide sprites

.cheatloop
  {
  LDA #CHEAT_DELAY:JSR delay

  JSR getplayerinput
  AND #JOY_FIRE+JOY_RIGHT+JOY_LEFT+JOY_DOWN+JOY_UP
  ; If FIRE or RETURN are pressed, exit cheat mode
  CMP #JOY_FIRE
  BCS done

  ; Mask off FIRE button
  AND #JOY_RIGHT+JOY_LEFT+JOY_DOWN+JOY_UP
  TAX
  LDA roomchange,X
  BEQ cheatloop

  CLC:ADC roomno ; Calculate new room number

  ; Is it < 21 (lowest visitable room)
  CMP #&15
  BCC cheatloop

  ; Is it > 168 (highest visitable room)
  CMP #&A8
  BCS cheatloop

  STA roomno

  ; Set position where Dizzy entered the room
  LDA dizzyx:STA v03D6 ; x
  LDA dizzyy:STA v03D7 ; y

  JSR l3498 ; ?? Redraw room ??

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  JMP cheatloop
  }

.done
  LDA #&FF:STA SPR_ENABLE ; Show sprites

  RTS
}

.l303C
{
  LDA vCFF8
  BEQ l3045

  DEC vCFF8

  RTS
}

.l3045
{
  LDA v03C8
  CMP #&01
  BNE done

  LDA v03C4
  AND #&01
  BNE done

  LDA v03C4
  AND #&02
  LSR  A
  CLC:LDA #&01
  JSR l392B

.done
  RTS
}

.v3060

.l3080
{
  SEI

  LDA #HI(isr_routine):STA ISR
  LDA #LO(isr_routine):STA ISR+1

  LDA #&00
  STA v309E
  STA v309F
  STA vE000
  STA vF084

  JSR l30D9

  CLI

  RTS
}

.v309E ; raster count
.v309F

; ISR routine
ORG &30A0
.isr_routine
{
  LDA CPU_CONFIG
  AND #&F8
  ORA #&05
  STA CPU_CONFIG

  LDA v309F
  BEQ l30B9

  JSR l30FE
  JSR lEE04
  JSR l3118
  JMP l30CE

.l30B9
  INC v309E
  LDA v309E
  AND #&07
  CMP #&07
  BEQ l30CE

  JSR l30FE
  JSR lE002
  JSR l3118

.l30CE
  LDA CPU_CONFIG
  AND #&F8
  ORA #&06
  STA CPU_CONFIG

  JMP lEA31
}

.l30D9
{
  SEI

  LDA CPU_CONFIG
  AND #&F8
  ORA #&05
  STA CPU_CONFIG

  JSR l30FE
  JSR lEE00
  JSR l3118

  LDA CPU_CONFIG
  AND #&F8
  ORA #&06
  STA CPU_CONFIG

  CLI

  RTS
}

.l30F5
{
  JSR l30D9

  LDA #&01:STA v309F

  RTS
}

.l30FE
{
  LDA v00FB:STA vF3FB
  LDA v00FC:STA vF3FC
  LDA v00FD:STA vF3FD
  LDA v00FE:STA vF3FE
  LDA v00FF:STA vF3FF

  RTS
}

.l3118
{
  LDA vF3FB:STA v00FB
  LDA vF3FC:STA v00FC
  LDA vF3FD:STA v00FD
  LDA vF3FE:STA v00FE
  LDA vF3FF:STA v00FF

  RTS
}

.l3132
{
  STA v00FB
  STA v0340
  STX v0345

  LDA frmx
  CMP #&5D
  BCC l3142

  RTS

.l3142
  JSR lCD19
  BCC l3148

  RTS

.l3148
  STA v00B5

  LDA frmy
  LSR  A
  LSR  A
  LSR  A
  TAX

  LDA v0340
  CMP #&64
  BCC l317C

  CMP #&69
  BCS l3175

  STX v03E0
  STX v03DA

  LDA v033F:ORA #&30:STA v033F
  LDA frmy:AND #&F8:STA frmy

  JMP l317C

.l3175
  BNE l317C

  LDA #&10:STA v033F

.l317C
  LDA v209F,X:STA v00FB
  LDA v20B8,X:STA v00FC

  LDA frmy
  AND #&07
  CLC:ADC v00FB
  BCC l3192

  INC v00FC

.l3192
  SEC:SBC #&60
  BCS l3199

  DEC v00FC

.l3199
  STA v00FB

  LDA frmx
  AND #&FE
  ASL  A
  CLC
  ASL  A
  BCC l31A7

  INC v00FC

.l31A7
  CLC:ADC v00FB
  BCC l31AE

  INC v00FC

.l31AE
  STA v00FB

  LDA frmy
  LSR  A
  LSR  A
  LSR  A
  TAX

  LDA v2028,X
  SEC:SBC v03DC
  STA v00FE

  LDA v200E,X
  SEC:SBC #&0C
  BCS l31CA

  DEC v00FE

.l31CA
  STA v00FD

  LDA frmx
  LSR  A
  CLC:ADC v00FD
  BCC l31D7

  INC v00FE

.l31D7
  STA v00FD
  STA v0035

  LDA v03DC
  BNE l31E8

  LDA v00FE
  SEC:SBC #&04

  JMP l31ED

.l31E8
  LDA v00FE
  CLC:ADC #&54

.l31ED
  STA v0036

  LDY #&00
  LDA (&B4),Y
  STA v033D

  LSR v033D
  INY
  LDA (&B4),Y
  STA v033E

  LDA v00B4
  CLC:ADC #&02
  BCC l3208

  INC v00B5

.l3208
  STA v00B4

  JSR l3361

  LDA v03E2
  BNE l3215

  STA v03DF

.l3215
  LDA #&00:STA v034A
  LDA v033D:STA v034B

  LDA frmx
  AND #&FE
  CMP #&22
  BCS l3234

  STA v00FF

  LDA #&22
  SEC:SBC v00FF
  LSR  A
  STA v034A

.l3234
  LDA frmx:AND #&FE:STA v00FF

  LDA #&5E
  SEC:SBC v00FF
  LSR  A
  CMP v034B
  BCS l3249

  STA v034B

.l3249
  LDA #&00:STA v0349

.l324E
  LDA frmy
  CMP v03E3
  BCS l3259

  JMP l32BB

.l3259
  LDY #&00

.l325B
  LDA (&B4),Y:STA v3060,Y
  INY
  CPY v033D
  BCC l325B

  LDA frmattr
  AND #&80
  BEQ l3270

  JSR l33C0

.l3270
  LDA frmx
  AND #&01
  BEQ l327A

  JSR l3327

.l327A
  LDX v034A

.l327D
  LDA v2077,X
  TAY

  LDA v3060,X
  AND v03DF
.^v3287
  EOR (&FB),Y
  STA (&FB),Y

  LDA v0349
  BNE l32B5

  TXA
  TAY
  LDA v033F
  AND #&08
  BNE l32AC

  LDA v03E2
  BEQ l32A0

  STA (&FD),Y

.l32A0
  LDA (&35),Y
  AND #&20
  ORA v033F
  STA (&35),Y

  JMP l32B5

.l32AC
  LDA (&35),Y
  AND #&F0
  ORA v033F
  STA (&35),Y

.l32B5
  INX
  CPX v034B
  BCC l327D

.l32BB
  DEC v033E
  BNE l32D8

.l32C0
  LDX v0345

  LDA #&FF:STA v03DF
  LDA #&00:STA v03DC
  LDA #&30:STA v03E3
  LDA #&B8:STA v03E1

  RTS

.l32D8
  INC frmy

  LDA frmy
  CMP v03E1
  BCS l32C0

  LDA v00B4
  CLC:ADC v033D
  BCC l32ED

  INC v00B5

.l32ED
  STA v00B4

  LDA frmy
  AND #&07
  BEQ l3305

  INC v0349
  INC v00FB
  BEQ l3300

  JMP l324E

.l3300
  INC v00FC

  JMP l324E

.l3305
  INC v00FC
  STA v0349

  LDA v00FB
  CLC:ADC #&39
  BCC l3313

  INC v00FC

.l3313
  STA v00FB

  LDA v00FD
  CLC:ADC #&28
  BCC l3320

  INC v00FE
  INC v0036

.l3320
  STA v00FD
  STA v0035

  JMP l324E
}

.l3327
{
  LDX v033D
  LDA #&00:STA v3060,X

.loop
  {
  LDA v3060-1,X
  ASL  A
  ASL  A
  ASL  A
  ASL  A
  ORA v3060,X
  STA v3060,X

  LDA v3060-1,X
  LSR  A
  LSR  A
  LSR  A
  LSR  A
  STA v3060-1,X

  DEX
  BNE loop
  }

  LDA v033D
  CMP v034B
  BCC done

  LDA frmx
  LSR  A
  CLC:ADC v033D
  CMP #&2F
  BCS done

  INC v034B

.done
  RTS
}

.l3361
{
  LDA frmattr
  AND #&07
  TAX

  LDA v2097,X:STA v03E2
  BEQ l337E

  LDA frmx
  AND #&01
  BEQ l337E

  LDA frmattr:ORA #&10:STA frmattr

.l337E
  LDA frmattr
  AND #&40
  BEQ l338B

  ORA v033F
  STA v033F

.l338B
  LDA frmattr
  AND #&20
  BEQ l339A

  LDA v033F:ORA #&80:STA v033F

.l339A
  LDA frmattr
  AND #&18
  LSR  A
  LSR  A
  LSR  A
  BNE l33AC

  LDA #&EA:STA v3287+1

  JMP l33BC

.l33AC
  LDX #&FB:STX v3287+1
  CMP #&01
  BNE l33BA

  LDA #&51
  JMP l33BC

.l33BA
  LDA #&11

.l33BC
  STA v3287

  RTS
}

.l33C0
{
  LDX v033D:DEX:STX v0346
  LDX #&00:STX v0347

.l33CC
  LDX v0347
  CPX v0346
  BEQ l3400
  BCS done

  LDA v3060,X
  TAY

  LDA vAA00,Y:STA v00FF

  LDX v0346

  LDA v3060,X
  TAY

  LDA vAA00,Y

  LDX v0347
  STA v3060,X

  LDX v0346
  LDA v00FF:STA v3060,X

  DEC v0346
  INC v0347

  JMP l33CC

.l3400
  LDA v3060,X
  TAY
  LDA vAA00,Y:STA v3060,X

.done
  RTS
}

.l340B
{
  STA v0340

  JSR l3528

  LDA #&80:STA v00FC
  LDA v0340
  CLC:ADC v0340
  BCC l3420

  INC v00FC

.l3420
  STA v00FB

  LDA #&00
  STA v00B0
  STA v00B2

  LDA #&82
  STA v00B1
  STA v00B3

  LDY #&01
  LDA (&FB),Y
  CLC:ADC v00B1
  STA v00B1

  DEY
  LDA (&FB),Y
  CLC:ADC v00B0
  BCC l3441

  INC v00B1

.l3441
  STA v00B0

  LDY #&03
  LDA (&FB),Y
  CLC:ADC v00B3
  STA v00B3

  DEY
  LDA (&FB),Y
  CLC:ADC v00B2
  BCC l3456

  INC v00B3

.l3456
  STA v00B2

.^l3458
  LDA v00B0
  CMP v00B2
  BNE l3465

  LDA v00B1
  CMP v00B3
  BNE l3465

  RTS
}

.l3465
{
  LDY #&03
  LDA (&B0),Y
  EOR #&40
  STA frmattr

  LDA #&00:STA v033F
  DEY
  LDA (&B0),Y
  STA frmy

  DEY
  LDA (&B0),Y:STA frmx

  DEY
  LDA #&58:STA v03DC

  LDA (&B0),Y
  JSR l3132

  LDA v00B0
  CLC:ADC #&04
  BCC l3493

  INC v00B1

.l3493
  STA v00B0

  JMP l3458
}

.l3498
{
  LDA #&00
  STA SPR_ENABLE
  STA v03E0
  STA v03DA

  LDA v03C4:AND #&F8:STA v03C4

  LDA #&00
  TAX

.l34AE
  STA v1694,X

  INX
  CPX #&19
  BCC l34AE

  LDA #&00
  TAY

.l34B9
  STA v1B00,Y
  STA v1B39,Y
  STA v1B72,Y

  INY
  CPY #&37
  BCC l34B9

  JSR l3C05

  LDX #&01

.l34CC
  JSR l3679

  INX
  CPX #&08
  BCC l34CC

  LDA SPR_COLLISION2
  LDA SPR_COLLISION2

  LDX roomno
  LDA v1A00,X
  TAX
  CPX #&00
  BEQ l34F4

  JSR l388D

  LDY #&00

.l34EA
  LDA (&FB),Y:STA v1694,Y
  INY
  CPY #&19
  BCC l34EA

.l34F4
  LDX roomno
  LDA vCA00,X
  BNE l3504

  LDA #&01:STA vCA00,X

  JSR l3B84

.l3504
  LDA #&FF:STA v03DF

  LDA roomno
  JSR l340B

  LDA #&FF:STA v03D5
  LDA #&86:STA v03DD

  JSR l3968
  JSR l3595
  JSR lCD37

  LDA #&FF:STA SPR_ENABLE

  RTS
}

.l3528
{
  LDA #&06:STA frmx

.l352D
  LDX frmx
  LDA v20B8,X:STA v00FC

  LDA v209F,X
  CLC:ADC #&28
  BCC l353F

  INC v00FC

.l353F
  STA v00FB

  LDA v2028,X:STA v00FE

  LDA v200E,X
  CLC:ADC #&05
  BCC l3550

  INC v00FE

.l3550
  STA v00FD
  STA v00B0
  STA v00B2

  LDA v00FE
  SEC:SBC #&04
  STA v00B1

  SEC:SBC #&54
  STA v00B3

  LDY #&F0
  LDA #&00

.l3566
  DEY
  STA (&FB),Y

  CPY #&00
  BNE l3566

  LDY #&1E

.l356F
  DEY
  STA (&B0),Y
  STA (&FD),Y

  LDA #&10:STA (&B2),Y

  LDA #&00
  CPY #&00
  BNE l356F

  INC frmx
  LDA frmx
  CMP #&17
  BCC l352D

  LDA #&00
  TAX

.l358B
  STA v5800,X
  STA v5900,X

  INX
  BNE l358B

  RTS
}

.l3595
{
  LDX #&06

.l3597
  LDA v2028,X
  STA v00FC

  SEC:SBC #&04
  STA v0036

  SEC:SBC #&54
  STA v00FE

  LDA v200E,X
  STA v00FB
  STA v00FD
  STA v0035

  LDY #&22

.l35B1
  LDA (&35),Y
  AND #&07
  BEQ l35C3

  STX v0346
  TAX

  LDA v2097,X
  LDX v0346
  BNE l35C5

.l35C3
  LDA (&FD),Y

.l35C5
  STA (&FB),Y

  DEY
  CPY #&04
  BNE l35B1

  INX
  CPX #&17
  BCC l3597

  RTS
}

.l35D2
{
  LDX frmy
  CPX #&05
  BCC l35DA

  RTS
}

.l35DA
{
  LDA v2028,X:STA v00FE

  LDA v200E,X
  CLC:ADC #&04
  BCC l35E9

  INC v00FE

.l35E9
  STA v00FD

  LDY frmattr
  LDA v2097,Y
  LDY frmx
  STA (&FD),Y

  LDA v20B8,X:STA v00FE

  LDA v209F,X
  CLC:ADC #&20
  BCC l3605

  INC v00FE

.l3605
  STA v00FD

  LDX frmx
  LDA v2077,X
  CLC:ADC v033D
  STA v00FF

  LDA v033E
  CLC:ADC #&02
  STA v033F

  LDX #&02

.l361E
  TXA
  TAY
  LDA (&B4),Y
  LDY v00FF
  STA (&FD),Y

  INC v00FF
  INX
  CPX v033F
  BCC l361E

  CPX #&09
  BNE done

  LDA v033D
  BNE done

  LDA #&00
  LDY v00FF
  STA (&FD),Y

.done
  RTS
}

.l363E
{
  STX v0345

  INX
  INX

  LDA frmx:STA dizzyx,X
  LDA frmy:STA dizzyy,X
  LDA frmattr:STA v037A,X

  LDA #&00
  STA v0384,X
  STA v0370,X
  STA v1680,X

  LDA v037A,X
  CMP #&64
  BCC l3675

  SEC:SBC #&64
  STA v037A,X

  LDX v0345
  LDA #&00:STA v16A8,X

.l3675
  LDX v0345

  RTS
}

.l3679
{
  STX v034E

  LDA #&00
  STA v164E,X
  STA v1658,X
  STA dizzyx,X
  STA dizzyy,X
  STA v037A,X
  STA v1680,X
  STA v0370,X
  STA v0366,X

  LDA #&45:STA v5FF8,X

  JSR l37F9

  RTS
}

.l369F
{
  LDA v0384,X
  TAY
  LDA (&FB),Y
  CMP #&FF
  BEQ l36AD

  INC v0384,X

  RTS
}

.l36AD
{
  STY v033E

  JSR l3875

  CLC:ADC v033E
  STA v033E

  TAY
  INC v033E

  SEC
  LDA #&04
  SBC v03C6
  CLC

  ADC v033E
  STA v0384,X

  LDA (&FB),Y
  RTS

  LDA #&00:STA v033E

  LDX v0345

  RTS
}

.l36D7
{
  LDA v0366,X
  CMP #&40
  BEQ l3725

  AND #&0F
  STA frmx

  LDA v0366,X
  AND #&20
  BEQ l3701

  LDA dizzyx,X
  CMP dizzyx
  BEQ l3701
  BCS l36F9

  LDA #&08
  JMP l36FB
}

.l36F9
{
  LDA #&04

.^l36FB
  ORA frmx
  STA frmx

.^l3701
  LDA v0366,X
  AND #&10
  BEQ l3719

  LDA dizzyy,X
  CMP dizzyy
  BNE l3715

  LDA #&00
  JMP l3719
}

.l3715
{
  BCS l3720

  LDA #&02

.^l3719
  ORA frmx
  STA frmx

  RTS
}

.l3720
{
  LDA #&01
  JMP l3719
}

.l3725
{
  LDA #&00:STA frmx

  LDA dizzyx,X
  CMP v1692,X
  BEQ l373E
  BCS l3739

  LDA #&08
  JMP l373B
}

.l3739
{
  LDA #&04

.^l373B
  STA frmx

.^l373E
  LDA dizzyy,X
  CMP v1697,X
  BEQ l3755
  BCS l374D

  LDA #&02
  JMP l374F
}

.l374D
{
  LDA #&01

.^l374F
  ORA frmx
  STA frmx

.^l3755
  LDA frmx
  BEQ l375B

  RTS
}

.l375B
{
  STA v0370,X

  RTS
}

.l375F
{
  LDA dizzyx
  CLC:ADC frmx
  STA frmattr

  DEC frmattr

  LDA dizzyy
  CLC:ADC frmy
  CLC:ADC #&28
  STA v033D

  DEC v033D

  LDA v033D
  LSR  A
  LSR  A
  LSR  A
  TAX

  LDA v209F,X:STA v00FB
  LDA v20B8,X:STA v00FC
  LDA v200E,X:STA v00FD

  LDA v2028,X
  SEC:SBC #&04
  STA v00FE

  LDA v033D
  AND #&07
  CLC:ADC v00FB
  CLC:ADC #&20
  STA v00FB

  LDA frmattr
  LSR  A
  CLC:ADC #&04
  TAY

  LDA (&FD),Y:STA v033F

  LDA frmattr
  AND #&01
  BEQ l37C0

  LDA #&0F
  JMP l37C2
}

.l37C0
{
  LDA #&F0

.^l37C2
  STA v033E

  LDA frmattr
  LSR  A
  TAX
  LDA v2077,X
  TAY
  LDA (&FB),Y
  AND v033E
  STA v033E

  LDA v033F
  AND #&40
  CMP #&01
  LDA v033E

  RTS
}

.delay
{
  STA v0340 ; delay amount
  STX v0345 ; preserve X

.loop
  {
  LDX #&FF ; game speed

.innerloop
  {
  NOP
  NOP
  NOP
  NOP

  DEX
  BNE innerloop
  }

  DEC v0340
  BNE loop
  }

  LDX v0345 ; restore X

  RTS
}

.l37F9
{
  STX v0345
  STY v0347

  LDY #&00
  LDA #&01:STA v0342

  LDX v034E

.l3809
  CPX #&00
  BEQ l3816

  INY
  INY
  ASL v0342
  DEX

  JMP l3809
}

.l3816
{
  LDX v034E
  LDA dizzyx,X
  CMP #&1C
  BCC l3827

  CMP #&91
  BCS l3827

  JMP l3829
}

.l3827
{
  LDA #&00

.^l3829
  CLC
  ROL  A
  STA SPR_0_X,Y
  BCC l383C

  LDA SPR_MSB_X
  ORA v0342
  STA SPR_MSB_X

  JMP l3847
}

.l383C
{
  LDA v0342
  EOR #&FF
  AND SPR_MSB_X
  STA SPR_MSB_X

.^l3847
  INY
  LDA dizzyy,X
  CMP #&4A
  BCC l3856

  CMP #&E6
  BCS l3856

  JMP l3858
}

.l3856
{
  LDA #&00

.^l3858
  STA SPR_0_X,Y

  LDX v0345
  LDY v0347

  RTS
}

.l3862
{
  STX v0345
  INC v03C5
  LDX v03C5
  LDA v1900,X:STA v03C6
  LDX v0345

  RTS
}

.l3875
{
  STX v0346
  INC v03C5
  LDX v03C5
  LDA v1900,X:AND #&03:CLC:ADC #&01:STA v03C6
  LDX v0346

  RTS
}

.l388D
{
  LDA #&10;STA v00FC
  LDA #&00:STA v00FB
  CPX #&00
  BEQ done

.l3899
  LDA v00FB
  CLC:ADC #&19
  BCC l38A2

  INC v00FC

.l38A2
  STA v00FB
  DEX
  BNE l3899

.done
  RTS
}

.l38A8
{
  STX v0345
  STA v0340

  LDX v034E
  LDA v20D1,X
  AND #&00
  BEQ l38CB

  LDA v164E,X
  BEQ l38CB

  STA v037A,X

  LDA #&00
  STA v0370,X
  STA v0384,X

  JMP l3927
}

.l38CB
{
  LDA v0340
  AND #&03
  BEQ l38ED

  AND #&01
  BEQ l38E3

  LDA dizzyy,X
  SEC:SBC v03B6,X
  STA dizzyy,X

  JMP l38ED
}

.l38E3
{
  LDA dizzyy,X
  CLC:ADC v03B6,X
  STA dizzyy,X

.^l38ED
  LDA v0340
  AND #&0C
  BEQ l390F

  AND #&04
  BEQ l3905

  LDA dizzyx,X
  SEC:SBC v03AC,X
  STA dizzyx,X

  JMP l390F
}

.l3905
{
  LDA dizzyx,X
  CLC:ADC v03AC,X
  STA dizzyx,X

.^l390F
  LDA dizzyx,X
  CMP #&E6
  BCC l3920

  CMP #&F3
  BCS l3920

.^l391A
  JSR l3679

  JMP l3927
}

.l3920
{
  LDA dizzyy,X
  CMP #&08
  BCC l391A

.^l3927
  LDX v0345

  RTS
}

.l392B
{
  STA vF084

  RTS
}

.l392F
{
  LDA objs_xlocs,X:STA frmx
  LDA objs_ylocs,X:STA frmy

  LDA #&00
  STA frmattr
  STA v033F

  LDA objs_frames,X
  JSR l3132

  RTS
}

.l394A
{
  LDA objs_xlocs,X:STA frmx
  LDA objs_ylocs,X:STA frmy
  LDA objs_attrs,X:STA frmattr
  LDA #&00:STA v033F

  LDA objs_frames,X

  JSR l3132

  RTS
}

.l3968
{
  LDX v03DD

.^l396B
  CPX #&00
  BNE l397A

  LDA #&86:STA v03DD
  LDA #&FF:STA v03D5

  RTS
}

.l397A
{
  DEX

  LDA objs_rooms,X
  BEQ l396B

  CMP roomno
  BNE l396B

  LDA objs_xlocs,X:STA frmx
  LDA objs_ylocs,X:STA frmy
  LDA objs_attrs,X:STA frmattr

  LDY #&00
  CPX #&3F
  BCS l39B2

  AND #&07
  AND v03D5
  ORA #&08
  TAY
  JSR l39C3

  LDA frmattr
  AND #&A7
  ORA v00FF
  STA frmattr

.l39B2
  STY v033F

  LDA #&58:STA v03DC

  LDA objs_frames,X
  JSR l3132

  JMP l396B
}

.l39C3
{
  LDA #&08:STA v00FF

  LDA v03D5
  BEQ done

  LDA objs_rooms,X
  CMP orig_rooms,X
  BNE done

  LDA objs_xlocs,X
  CMP orig_xlocs,X
  BNE done

  LDA objs_ylocs,X
  CMP orig_ylocs,X
  BNE done

  LDA #&00:STA v00FF

.done
  RTS
}

.getplayerinput
{
  LDA CIA1_PRA ; Read Joystick 2 state
  EOR #&FF ; Make bitfield active high
  AND #&1F ; Mask to just joystick input bits
  STA player_input
 
  ; Merge in keypresses from keyboard to bitfield (Z, X, Shift, Return)
  JSR mergekeypress

  ; Check if button was pressed before and now
  LDA v03D8
  AND #&10 ; Mask off to just button
  AND player_input
  BEQ cache_input

  LDA player_input:AND #&0F:STA player_input

  RTS

.cache_input
  LDA player_input:STA v03D8

  RTS
}

.l3A10
{
  STA frmx

  LDA dizzyx
  ASL  A
  CLC:ADC #&1C
  STA dizzyx

  LDA dizzyy
  CLC:ADC #&5A
  STA dizzyy

  LDX #&02

.l3A28
  STX v034E

  JSR l3679

  LDA #&01:STA SPR_0_COLOUR,X
  LDA #&33:STA v5FF8,X
  LDA #&04:STA v03AC,X
  LDA #&02:STA v03B6,X

  INX
  CPX #&06
  BCC l3A28

  LDA dizzyx
  SEC:SBC frmx
  STA v0354
  STA v0355

  LDA dizzyx
  CLC:ADC frmx
  STA v0356
  STA v0357

  LSR frmx

  LDA dizzyy
  SEC:SBC frmx
  STA v035E
  STA v0360

  LDA dizzyy
  CLC:ADC frmx
  STA v035F
  STA v0361

  RTS
}

.l3A7F
{
  LDX #&05:STX v0346

.l3A84
  LDX #&02

.l3A86
  STX v034E

  LDA dizzyx,X
  BEQ l3A9A

  LDA v0366,X
  JSR l38A8
  JSR l37F9

  LDX v034E

.l3A9A
  INX
  CPX #&06
  BCC l3A86

  LDA #&08
  JSR delay

  DEC v0346
  BNE l3A84

  RTS
}

.l3AAA
{
  LDA v03D6:STA dizzyx
  LDA v03D7:STA dizzyy

  LDA #&3C
  JSR l3A10

  LDA #&37:STA v5FF8
  LDX #&00:STX v034E

  JSR l37F9

  LDA #&0A:STA v0368
  LDA #&09:STA v0369
  LDA #&06:STA v036A
  LDA #&05:STA v036B

  LDY #&03

.l3ADE
  JSR l3A7F

  DEC v5FF8
  DEY
  BNE l3ADE

  JSR l3C05

  LDA #&00
  STA v03C8
  STA v03C7
  STA v03C9
  STA v03C2
  STA v5FF8
  STA v03C1

  LDX #&01

.l3B00
  STX v034E

  JSR l3679

  INX
  CPX #&08
  BCC l3B00

  LDA v03D6:STA dizzyx
  LDA v03D7:STA dizzyy

  LDA SPR_COLLISION
  LDA SPR_COLLISION2
  LDA SPR_COLLISION
  LDA SPR_COLLISION2

  RTS
}

.l3B24
{
  NOP
  LDA #&00
  JSR l3A10

  LDA #&34:STA v5FF8
  LDX #&00:STX v034E
  JSR l37F9

  LDA #&04
  JSR l2EEF

  LDA #&05:STA v0368
  LDA #&06:STA v0369
  LDA #&09:STA v036A
  LDA #&0A:STA v036B

  LDY #&0A

.^l3B52
  JSR l3A7F

  LDA v5FF8
  CMP #&37
  BCC l3B64

  LDA #&45:STA v5FF8

  JMP l3B67
}

.l3B64
{
  INC v5FF8

.^l3B67
  DEY
  BNE l3B52

  LDX #&00

.l3B6C
  STX v034E

  JSR l3679

  INX
  CPX #&08
  BCC l3B6C

  LDA #&FF
  JSR delay

  LDA #&C8
  JSR delay

  JMP l2105
}

.l3B84
{
  STA v0340
  STX v0346

  CMP #&0A
  BCC l3B94

  INC v20E0

  JMP l3B9B
}

.l3B94
{
  CLC:ADC v20E1:STA v20E1

.^l3B9B
  LDX #&03

.l3B9D
  LDA v20DE,X
  CMP #&0A
  BCC l3BAD

  SEC:SBC #&0A
  STA v20DE,X

  INC v20DD,X

.l3BAD
  DEX
  BNE l3B9D

  LDX #&06

.l3BB2
  TXA
  ASL  A
  CLC:ADC #&20
  STA frmx

  LDA #&08:STA frmy

  LDA #&00
  STA v033F
  STA v03E3

  LDA #&06:STA frmattr

  LDA v20D8,X
  CLC:ADC #&30
  JSR l3132

  INX
  CPX #&0C
  BCC l3BB2

  LDX v0346

  RTS
}

.mergekeypress
{
  ; Check last pressed key
  LDY KEY_PRESSED
  LDX KEY_SHIFT

  ; Load current bitfield
  LDA player_input

  CPY #KEY_Z
  BNE checkx

  ; Simulate joystick left
  ORA #JOY_LEFT
  JMP checkshift

.checkx
  CPY #KEY_X
  BNE checkshift

  ; Simulate joystick right
  ORA #JOY_RIGHT

.checkshift
  CPX #0
  BEQ checkreturn

  ; Simulate joystick up
  ORA #JOY_UP

.checkreturn
  CPY #KEY_RETURN
  BNE done

  ; Simulate joystick fire
  ORA #JOY_FIRE

.done
  STA player_input

  RTS
}

.l3C05
{
  LDA v03D6:STA v0340
  LDA v03D7:STA v0342

  LDX #&32
  LDA #&00

.loop
  {
  DEX
  STA dizzyx,X
  STA v0384,X
  STA v038E,X
  STA v1644,X
  STA v1662,X
  STA v16AD,X

  CPX #&00
  BNE loop
  }

  LDA v0342
  STA v03D7
  STA dizzyy

  LDA v0340
  STA v03D6
  STA dizzyx

.^v3C3E
  RTS
}

ORG &3C42
.v3C42

ORG &3C52
.l3C52
{
  LDA v03DA
  BEQ l3CAD

  LDA dizzyy
  CMP #&08
  BCC l3CAD

  JSR l3875

  DEC v03C6

  LDA v03C6
  BEQ l3CAD

  TAX
  LDY #&00

.l3C6C
  LDA v1B00,Y
  BEQ l3C79

  INY
  CPY #&37
  BCC l3C6C

  JMP l3CAD
}

.l3C79
{
  TXA
  STY v00FF
  LDX v00FF
  STA v1B00,X

  LDA dizzyy
  CLC:ADC #&38
  AND #&F8
  STA v1B72,X

  LDA dizzyx
  LSR  A
  CLC:ADC #&03
  STA v1B39,X

  JSR l3875

  DEC v03C6
  LDA v03C6
  BNE l3CA3

  LDA #&02

.l3CA3
  CLC:ADC v1B39,X
  STA v1B39,X

  JSR l3D02

.^l3CAD
  LDX #&00

.^l3CAF
  LDA v1B00,X
  BNE l3CB7

  JMP l3CF9
}

.l3CB7
{
  JSR l3D02

  LDA v1B00,X
  TAY
  LDA v3C3E,Y
  STA v00FF

  LDA v1B72,X
  SEC:SBC v00FF
  STA v1B72,X

  LDA v1B72,X
  CMP #&30
  BCC l3CEE

  LSR  A
  LSR  A
  LSR  A
  TAY
  LDA v200E,Y:STA v00FB

  LDA v2028,Y
  SEC:SBC #&04
  STA v00FC

  LDA v1B39,X
  TAY
  LDA (&FB),Y
  AND #&50
  BEQ l3CF6

.l3CEE
  LDA #&00:STA v1B00,X

  JMP l3CF9
}

.l3CF6
{
  JSR l3D02

.^l3CF9
  INX
  CPX #&37
  BCS l3D01

  JMP l3CAF
}

.l3D01
{
  RTS
}

.l3D02
{
  STX v0345

  LDA v1B72,X
  LSR  A
  LSR  A
  LSR  A
  TAY
  LDA v20B8,Y:STA v00FC

  LDA v1B72,X
  AND #&07
  CLC:ADC v209F,Y
  CLC:ADC #&20
  STA v00FB

  LDA v1B39,X
  SEC:SBC #&04
  TAY
  CPY #&1E
  BCC l3D2B

  RTS
}

.l3D2B
{
  LDA v2077,Y
  TAY
  LDA v1B00,X
  ASL  A
  ASL  A
  TAX

  LDA #&04:STA frmx

.l3D3A
  LDA v3C42,X:STA v00FF

  LDA (&FB),Y:EOR v00FF:STA (&FB),Y

  INY
  INX
  DEC frmx
  BNE l3D3A

  LDX v0345

  RTS
}

ORG &3D7F
{
  LDA #&00
  TAY

.l3D82
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l3D90

  CPY #&1A
  BCC l3D93

.l3D90
  STA v0300,Y

.l3D93
  INY
  BNE l3D82

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80

  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l3DB7

  LDY #&A0

.l3DB7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

ORG &3DD2
{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA

  LDA #&38 ; ??
  LDA v00AC ; ??
  SBC v00AE

  LDA v00AD
  SBC v00AF

  RTS
}

{
  INC v00AC
  BNE done

  INC v00AD

.done
  RTS
}

{
  LDX #&FF

  SEI

  TXS
  CLD

  JSR lFD02

  BNE l3E1E

  JMP (&8000)
}

.l3E1E
{
  STX GFX_VICII_REG2

  JSR lFDA3
  JSR lFD50
  JSR lFD15
  JSR lFF5B

  CLI

  JMP (&A000)
}

{
  LDX #&05

.l3E33
  LDA vFD0F,X
  CMP roomtable+3,X
  BNE done

  DEX
  BNE l3E33

.done
  RTS
}

ORG &3E44
{
  LDX #&30
  LDY #&FD
  CLC
  STX v00C3
  STY v00C4

  LDY #&1F

.l3E4F
  LDA ISR,Y
  BCS l3E56

  LDA (&C3),Y

.l3E56
  STA (&C3),Y
  STA ISR,Y

  DEY

  BPL l3E4F

  RTS
}

ORG &3E7F
{
  LDA #&00
  TAY

.l3E82
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l3E90

  CPY #&1A
  BCC l3E93

.l3E90
  STA v0300,Y

.l3E93
  INY
  BNE l3E82

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80
  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l3EB7

  LDY #&A0

.l3EB7
  LDX #&00
  STY v00C2
  CLC

  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

ORG &3ED2
{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA

  LDA #&38 ; ??
  LDA v00AC ; ??
  SBC v00AE
  LDA v00AD
  SBC v00AF

  RTS

  INC v00AC
  BNE done

  INC v00AD

.done
  RTS
}

{
  LDX #&FF

  SEI

  TXS
  CLD
  JSR lFD02

  BNE l3F1E

  JMP (&8000)
}

.l3F1E
{
  STX GFX_VICII_REG2

  JSR lFDA3
  JSR lFD50
  JSR lFD15
  JSR lFF5B

  CLI

  JMP (&A000)
}

{
  LDX #&05

.l3F33
  LDA vFD0F,X
  CMP roomtable+3,X
  BNE done

  DEX
  BNE l3F33

.done
  RTS
}

ORG &3F7F
{
  LDA #&00
  TAY

.l3F82
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l3F90

  CPY #&1A
  BCC l3F93

.l3F90
  STA v0300,Y

.l3F93
  INY
  BNE l3F82

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80
  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l3FB7

  LDY #&A0

.l3FB7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

ORG &3FD2
{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA
}

; Sprites
ORG &4000
; TODO

ORG &51B7
.l51B7
{
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA

  LDA #&38 ; ??
  LDA v00AC ; ??
  SBC v00AE
  LDA v00AD
  SBC v00AF

  RTS
}

{
  INC v00AC
  BNE done

  INC v00AD

.done
  RTS
}

{
  LDX #&FF

  SEI

  TXS
  CLD
  JSR lFD02

  BNE l521E

  JMP (&8000)
}

.l521E
{
  STX GFX_VICII_REG2

  JSR lFDA3
  JSR lFD50
  JSR lFD15
  JSR lFF5B

  CLI

  JMP (&A000)
}

{
  LDX #&05

.l5233
  LDA vFD0F,X
  CMP roomtable+3,X
  BNE done

  DEX
  BNE l5233

.done
  RTS
}

{
  LDX #&30
  LDY #&FD
  CLC
  STX v00C3
  STY v00C4

  LDY #&1F

.l524F
  LDA ISR,Y
  BCS l5256

  LDA (&C3),Y

.l5256
  STA (&C3),Y
  STA ISR,Y
  DEY
  BPL l524F

  RTS
}

{
  LDA #&00
  TAY

.l5282
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l5290

  CPY #&1A
  BCC l5293

.l5290
  STA v0300,Y

.l5293
  INY
  BNE l5282

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80
  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l52B7

  LDY #&A0

.l52B7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D
}

INCLUDE "objects.asm"

.v5800
.v58C8
.v5900
.v5990
.v5A58
.v5A6C
.v5B20
.v5FF8 ; hw sprite "pointers"

ORG &6000
INCBIN "SCRMEM"

ORG &7F40
.l7F40
{
  LDA #&78:STA GFX_MEM_PTR

  LDA GFX_VICII_REG1
  ORA #&20
  STA GFX_VICII_REG1

  LDA CIA2_PRA
  AND #&FC
  ORA #&02
  STA CIA2_PRA

  LDA #&00:STA GFX_BORDER_COLOUR

  RTS
}

  LDA #&00
  TAY

.l7F82
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC l7F90

  CPY #&1A
  BCC l7F93

.l7F90
  STA v0300,Y

.l7F93
  INY
  BNE l7F82

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80
  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE l7FB7

  LDY #&A0

.l7FB7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS

  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
  STX vDC02

  LDA #&07:STA CIA2_PRA

ORG &8000
.roomtable
INCBIN "RMTABLE"
.roomdata
INCBIN "RMDATA"

ORG &AB00
; Frame table
.frametable
INCBIN "frametable.bin"
ORG &AD00
; Frame defs
.framedefs
INCBIN "framedefs.bin"

.vAA00
.vCA00

ORG &CB00
.lCB00
{
  LDX #&00

.lCB02
  LDA v0947,X
  CMP roomno
  BEQ lCB10

  INX
  CPX #&19
  BCC lCB02

  RTS
}

.lCB10
{
  CMP #&33
  BNE lCB1C

  LDA dizzyx
  CMP #&32
  BCC lCB1C

  INX

.^lCB1C
  STX v034E

  LDA v08FC,X:STA vCFFF
  LDA v0915,X:STA vCFFE
  LDA #&00:STA vCFFD
  LDA #&02:STA vCFF9
  LDA #&FF:STA v03DB
  JSR lCC9A

  LDX v034E
  LDA stringptr_lo,X:STA v00B2
  LDA stringptr_hi,X:STA v00B3

  LDA #&00
  STA vCFFD
  STA vCFFC
  STA vCFFB
  STA vCFFA

.^lCB58
  LDX v034E

  LDA v092E,X:STA v00FF

  LDX #&00
  LDY vCFFC

.^lCB65
  LDA (&B2),Y
  CMP #&5F
  BEQ lCB7E

  CPX v00FF
  BCS lCB82

  CMP #&3A
  BEQ lCB78

.^lCB73
  INY
  INX

  JMP lCB65
}

.lCB78
{
  STY vCFFB

  JMP lCB73
}

.lCB7E
{
  DEY
  STY vCFFB

.^lCB82
  LDA #&00:STA vCFFD
  INC vCFF9

  LDA vCFFE
  CLC:ADC #&08
  STA vCFFE

.lCB93
  INC vCFFD

  LDX v034E
  LDA v08FC,X:STA vCFFF
  LDA #&FF:STA v03DB
  JSR lCC9A
  JSR lCBFE

  LDA vCFFD
  CMP #&08
  BCC lCB93

  LDY vCFFB
  INY
  LDA (&B2),Y
  CMP #&5F
  BEQ lCBC1

  STY vCFFC
  JMP lCB58
}

.lCBC1
{
  LDX v034E
  CPX #&14
  BEQ lCBFD

.lCBC8
  JSR getplayerinput
  AND #&10
  BEQ lCBC8

  LDX v034E
  LDA v0915,X:STA vCFFE

.lCBD8
  LDX v034E
  LDA v08FC,X:STA vCFFF

  LDA #&00
  STA vCFFD
  STA v03DB

  JSR lCC9A

  DEC vCFF9
  BEQ lCBFD

  LDA vCFFE
  CLC:ADC #&08
  STA vCFFE

  JMP lCBD8
}

.lCBFD
{
  RTS
}

.lCBFE
{
  LDX v034E
  LDA v08FC,X:STA vCFFF
  INC vCFFF
  LDY vCFFC:STY vCFFA
  LDA vCFFF:STA frmx
  LDA vCFFE:STA frmy
  CLC:ADC vCFFD
  ADC #&01
  STA v03E1

  LDA #&07:STA frmattr

  LDA vCFF9
  AND #&01
  CLC:ADC #&6D

  JSR l3132

  INC vCFFF

.lCC38
  INC vCFFF

  LDA vCFFF:STA frmx
  LDA vCFFE:STA frmy

  CLC:ADC vCFFD
  ADC #&01
  STA v03E1

  LDA #&17:STA frmattr

  LDY vCFFA
  LDA (&B2),Y
  JSR l3132

  INC vCFFA

  LDA vCFFA
  CMP vCFFB
  BCC lCC38
  BEQ lCC38

  LDX v034E
  LDA v08FC,X
  CLC:ADC v092E,X
  CLC:ADC #&02
  STA frmx

  LDA vCFFE:STA frmy

  CLC:ADC vCFFD
  ADC #&01
  STA v03E1

  LDA #&07:STA frmattr

  LDA vCFF9
  AND #&01
  CLC:ADC #&6F
  JSR l3132

  RTS
}

.lCC9A
{
  LDA vCFFF:STA frmx

  LDA vCFFE
  CLC:ADC vCFFD
  STA frmy

  LDA #&07
  AND v03DB
  STA frmattr

  LDA #&00:STA v033F

  LDA #&6A
  JSR l3132

  LDA #&00:STA vCFFA

.lCCC1
  INC vCFFF
  INC vCFFF

  LDA vCFFF:STA frmx

  LDA vCFFE
  CLC:ADC vCFFD
  STA frmy

  LDA #&07
  AND v03DB
  STA frmattr

  LDA #&6C
  JSR l3132

  INC vCFFA
  INC vCFFA

  LDX v034E

  LDA vCFFA
  CMP v092E,X
  BCC lCCC1

  INC vCFFF
  INC vCFFF

  LDA vCFFF:STA frmx

  LDA vCFFE
  CLC:ADC vCFFD
  STA frmy

  LDA #&87
  AND v03DB
  STA frmattr

  LDA #&6B
  JSR l3132

  RTS
}

.lCD19
{
  LDA #&AB:STA v00FC

  LDA v00FB
  CLC:ADC v00FB
  BCC lCD26

  INC v00FC

.lCD26
  STA v00FB

  LDY #&00
  LDA (&FB),Y
  STA v00B4

  INY
  LDA (&FB),Y
  CLC:ADC #&AD
  STA v00B5

  RTS
}

.lCD37
{
  LDX v03E0
  BNE lCD53

  LDA #&00
  LDX roomno
  CPX #&2E
  BCC done

  CPX #&4C
  BCS done

  CPX #&33
  BCC lCD51

  CPX #&49
  BCC done

.lCD51
  LDX #&06

.lCD53
  LDA v200E,X:STA v00FB

  LDA v2028,X
  SEC:SBC #&04
  STA v00FC

  LDY #&05

.lCD62
  LDA (&FB),Y
  ORA #&20
  STA (&FB),Y

  INY
  CPY #&23
  BCC lCD62

  INX
  CPX #&17
  BCC lCD53

.done
  RTS
}

.lCD73
{
  LDX v03E0
  BEQ done

  LDA v03C4
  AND #&01
  BNE lCD80

.done
  RTS
}

.lCD80
{
  LDA v2028,X
  SEC:SBC #&04
  STA v00B3

  LDA v200E,X
  CLC:ADC #&04
  BCC lCD92

  INC v00B3

.lCD92
  STA v00B2

  LDY #&00:STY v03DB

.lCD99
  LDA (&B2),Y
  AND #&10
  BEQ lCDCF

  TYA
  ASL  A
  CLC:ADC #&20
  STA frmx

  LDA v03E0
  ASL  A
  ASL  A
  ASL  A
  STA frmy

  LDA #&0F:STA frmattr
  LDA #&00:STA v033F

  LDA v03C4
  LSR  A
  AND #&03
  CLC:ADC #&65

  JSR l3132

  INC v03DB
  INC v03DB
  INC v03DB

.lCDCF
  INC v03DB

  LDY v03DB
  CPY #&1F
  BCC lCD99

  RTS
}

.lCDDA
{
  CPX #&3F
  BCC lCDE0

  LDX #&3F

.lCDE0
  LDA v1140,X:STA v00B6
  LDA v1180,X:STA v00B7

  LDY #&04

.lCDEC
  TYA
  STA frmx

  INC frmx

  LDA v0342:STA frmy
  LDA #&07:STA frmattr

  STY v0343

  LDA (&B6),Y:STA v00FB

  JSR lCD19
  JSR l35D2

  LDY v0343
  INY
  CPY #&1A
  BCC lCDEC

  RTS
}

.lCE14
{
  LDA #&00:STA v033D
  LDA #&07:STA v033E

  LDX #&00
  LDA #&02:STA v0342

.lCE25
  LDA v20D9,X

  STX v0344
  TAX
  JSR lCDDA

  LDX v0344
  INC v0342
  INX
  CPX #&03
  BCC lCE25

  LDA #&07:STA v03DB

.lCE3F
  LDX #&02:STX frmy
  LDA #&FF:STA v03D5

.lCE49
  LDA v20B8,X:STA v00FC

  LDA v209F,X
  CLC:ADC #&28
  BCC lCE58

  INC v00FC

.lCE58
  STA v00FB

  LDA v00FC
  STA v0036
  STA v00FE

  INC v00FE

  LDA v00FB
  CLC:ADC #&40
  BCC lCE6B

  INC v00FE

.lCE6B
  STA v00FD

  LDA v00FB
  SEC:SBC #&01
  BCS lCE76

  DEC v0036

.lCE76
  STA v0035

  LDX #&04
  LDY #&21

.lCE7C
  LDA (&FB),Y:STA (&35),Y

  INY
  TYA
  AND #&07
  BNE lCE7C

  STY v0347

  LDA v2077,X
  TAY

  LDA (&FD),Y
  AND v03D5

  LDY v0347
  STA (&35),Y

  INY
  INX

  CPX #&1A
  BCC lCE7C

  INC frmy
  LDX frmy
  CPX #&04
  BCC lCE49

  LDA #&00:STA v03D5

  CPX #&05
  BCC lCE49

  LDA v03DB:STA v033D

  LDA #&08
  SEC:SBC v03DB
  CMP #&08
  BCC lCEC2

  LDA #&07

.lCEC2
  STA v033E

  LDA #&04:STA v0342

  LDX v20DC
  JSR lCDDA

  DEC v03DB

  LDA v03DB
  CMP #&FA
  BCS lCEDD

  JMP lCE3F
}

.lCEDD
{
  LDA #&FF:STA v03D5

  RTS
}

ORG &CEE5
{
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX

  STX vDC02

  LDA #&07:STA CIA2_PRA

  LDA #&38 ; ??
  LDA v00AC ; ??

  SBC v00AE

  LDA v00AD
  SBC v00AF

  RTS
}

{
  INC v00AC
  BNE done

  INC v00AD

.done
  RTS
}

{
  LDX #&FF

  SEI

  TXS
  CLD
  JSR lFD02

  BNE lCF1E

  JMP (&8000)
}

.lCF1E
{
  STX GFX_VICII_REG2
  JSR lFDA3
  JSR lFD50
  JSR lFD15
  JSR lFF5B

  CLI

  JMP (&A000)
}

{
  LDX #&05
.lCF33
  LDA vFD0F,X
  CMP roomtable+3,X
  BNE done

  DEX
  BNE lCF33

.done
  RTS
}

ORG &CF44
{
  LDX #&30
  LDY #&FD
  CLC
  STX v00C3
  STY v00C4

  LDY #&1F

.lCF4F
  LDA ISR,Y
  BCS lCF56

  LDA (&C3),Y

.lCF56
  STA (&C3),Y
  STA ISR,Y

  DEY
  BPL lCF4F

  RTS
}

ORG &CF7F
{
  LDA #&00
  TAY

.lCF82
  STA v0002,Y
  STA v0200,Y

  CPY #&18
  BCC lCF90

  CPY #&1A
  BCC lCF93

.lCF90
  STA v0300,Y

.lCF93
  INY
  BNE lCF82

  LDX #&3C
  LDY #&03
  STX v00B2
  STY v00B3

  LDA #&08:STA v00BE

  LDY #&80

  LDA roomtable
  TAX
  EOR #&FF
  STA roomtable

  CMP roomtable
  STX roomtable
  BNE lCFB7

  LDY #&A0

.lCFB7
  LDX #&00
  STY v00C2
  CLC
  JSR lFE2D

  LDA #&08:STA v0282
  LDA #&04:STA v0288

  RTS
}

ORG &CFD2
{
  LDA #&7F
  STA vDC0D
  STA vDD0D
  STA CIA1_PRA

  LDA #&08
  STA vDC0E
  STA vDD0E
  STA vDC0F
  STA vDD0F

  LDX #&00
  STX vDC03
  STX vDD03
  STX vD418

  DEX
}

vCFF8 = * + 1
vCFF9 = * + 2
  STX v0600
.vCFFA
vCFFB = * + 1
vCFFC = * + 2
  ADC v5A6C
.vCFFD
  PHP
.vCFFE
vCFFF = * + 1
  ROR v0045

.vD000
.vD001
.vD010
.vD011
.vD012
.vD015
.vD016
.vD017
.vD018
.vD019
.vD01A
.vD01B
.vD01C
.vD01D
.vD01E
.vD01F
.vD020
.vD027
.vD400
.vD401
.vD402
.vD403
.vD404
.vD405
.vD406
.vD416
.vD417
.vD418
.vDC00
.vDC02
.vDC03
.vDC0D
.vDC0E
.vDC0F
.vDD00
.vDD03
.vDD0D
.vDD0E
.vDD0F
.vDE00
.vE000
.vE001

ORG &E002
.lE002
{
  LDX #&00
  JSR lE012

  LDX #&07
  JSR lE012

  LDX #&0E
  JSR lE012

  RTS
}

.lE012
{
  LDA vE000
  BNE lE01B

  STA vD418

  RTS
}

.lE01B
{
  CMP #&AB
  BEQ lE05E

  JMP lE0FA
}

.lE022
{
  LDA #&00
  LDY #&17

.lE026
  STA vD400,Y

  DEY
  BPL lE026

  LDA #&1F
  STA vD418
  STA vE755

  LDY #&00
  STY vE580
  STY vE587
  STY vE58E
  STY vE582
  STY vE589
  STY vE590
  STY vE557
  STY vE55E
  STY vE565
  STY vE001

  INY

  STY vE59A
  STY vE759

  JMP lE12A
}

.lE05E
{
  LDA vE001
  BEQ lE084

  DEC vE756
  BPL lE084

  LDA vE001:STA vE756

  DEC vE755

  LDA vE755
  AND #&0F
  BNE lE07E

  LDA #&00:STA vE000

  RTS
}

.lE07E
{
  LDA vE755:STA vD418

.^lE084
  LDY vE56A,X
  LDA vE79C,Y
  AND #&04
  BEQ lE0A4

  LDA vE5C6,X
  BEQ lE09E

  DEC vE5C6,X

  LDA vE7DF,Y:STA vD404,X

  BNE lE0A4

.lE09E
  LDA vE796,Y:STA vD404,X

.lE0A4
  LDA vE79C,Y
  AND #&10
  BEQ lE0CB

  LDA vE5C7,X
  BEQ lE0BF

  DEC vE5C7,X

  LDA #&FF:STA vD401,X
  LDA #&81:STA vD404,X

  BNE lE0CB

.lE0BF
  LDA vE5A0,X:STA vD401,X
  LDA vE796,Y:STA vD404,X

.lE0CB
  LDA vE5DB,X
  BEQ lE0ED

  DEC vE5DD,X

  BNE lE0ED

  LDA vE5DC,X:STA vE5DD,X

  CLC

  LDA vE593
  ADC vE5DB,X
  BCC lE0E7

  LDA vE79A,Y

.lE0E7
  STA vE593
  STA vD416

.lE0ED
  LDA vE59A
  BNE lE0F7

  DEC vE582,X

  BMI lE13F

.lE0F7
  JMP lE3AA
}

.lE0FA
{
  LDY vE000

  LDA vE883,Y:STA vE57E
  LDA vE889,Y:STA vE57F
  LDA vE88F,Y:STA vE585
  LDA vE895,Y:STA vE586
  LDA vE89B,Y:STA vE58C
  LDA vE8A1,Y:STA vE58D
  LDA vE901,Y:STA vE598

  JMP lE022
}

.lE12A
{
  CPX #&0E
  BNE lE139

  DEC vE59A
  BPL lE139

  LDA vE598:STA vE59A

.lE139
  LDA #&AB:STA vE000

  RTS
}

.lE13F
{
  LDA vE57E,X:STA v00FC
  LDA vE57F,X:STA v00FD

  LDY vE580,X
  LDA (&FC),Y
  TAY
  LDA vE825,Y:STA v00FE
  LDA vE854,Y:STA v00FF

  LDA #&FF:STA vE59B
  LDA #&00:STA vE554,X

.^lE163
  LDY vE557,X
  LDA (&FE),Y
  BNE lE16D

  JMP lE2A6
}

.lE16D
{
  CMP #&FE
  BCC lE17F

  INC vE557,X
  INY
  LDA (&FE),Y
  STA vE598

  INC vE557,X
  BNE lE163

.lE17F
  CMP #&FD
  BCC lE191

  INY
  INC vE557,X

  LDA (&FE),Y
  JMP lE75A
}

.lE18C
{
  INC vE557,X
  BNE lE163

.^lE191
  CMP #&FB
  BCC lE1B5

  CMP #&FB
  BNE lE1B1

  LDA #&01

.lE19B
  STA vE554,X

  INY
  INC vE557,X
  LDA (&FE),Y:STA vE567,X

  LDA #&00
  STA vE553,X
  STA vE552,X

  BEQ lE18C

.lE1B1
  LDA #&02
  BNE lE19B

.lE1B5
  CMP #&FA
  BCC lE22A

  INY
  INC vE557,X
  LDA (&FE),Y
  ASL  A
  ASL  A
  ASL  A
  CMP vE56A,X
  BEQ lE1E8

  STA vE56A,X

  CPX #&0E
  BNE lE1D2

  LDA #&FB
  BNE lE1DC

.lE1D2
  CPX #&07
  BNE lE1DA

  LDA #&FD
  BNE lE1DC

.lE1DA
  LDA #&FE

.lE1DC
  AND vE596
  STA vD417
  STA vE596

  LDA vE56A,X

.lE1E8
  TAY
  LDA vE79B,Y
  AND #&FE
  STA vD404,X

  LDA vE795,Y
  PHA
  AND #&0F
  STA vE56D,X
  STA vE57C,X
  PLA

  AND #&F0
  STA vE56B,X
  STA vE56C,X

  LDA vE7E3,Y
  PHA
  AND #&0F
  STA vE555,X
  PLA

  AND #&F0
  ROL  A
  ROL  A
  ROL  A
  ROL  A
  STA vE556,X

  LDA #&00
  STA vE5C8,X
  STA vE552,X
  STA vE553,X
  STA vE5DB,X

  JMP lE18C
}

.lE22A
{
  CMP #&F9
  BCC lE23A

  INY
  INC vE557,X
  LDA (&FE),Y:STA vE5C8,X

  JMP lE18C
}

.lE23A
{
  CMP #&F8
  BCC lE250

  INY
  INC vE557,X
  LDA (&FE),Y
  STA vE593
  STA vE594
  STA vD416

  JMP lE18C
}

.lE250
{
  CMP #&F7
  BCC lE27E

  INY
  INC vE557,X
  LDA (&FE),Y
  ORA vE596
  STA vE596

  CPX #&0E
  BNE lE268

  LDA #&04
  BNE lE272

.lE268
  CPX #&07
  BNE lE270

  LDA #&02
  BNE lE272

.lE270
  LDA #&01

.lE272
  ORA vE596
  STA vD417
  STA vE596

  JMP lE18C
}

.lE27E
{
  CMP #&F6
  BCC lE29A

  INY
  INC vE557,X
  LDA (&FE),Y:STA vE5DB,X
  INY
  INC vE557,X

  LDA (&FE),Y
  STA vE5DC,X
  STA vE5DD,X

  JMP lE18C
}

.lE29A
{
  CMP #&70
  BCC lE2A6

  SBC #&70
  STA vE569,X

  JMP lE18C
}

.lE2A6
{
  BEQ lE2A8

.lE2A8
  STA vE59F,X

  LDA vE569,X:STA vE582,X
  LDA #&00:STA vE5CC,X

  LDA #&01
  STA vE5C6,X
  STA vE5C7,X

  LDA vE59F,X
  BEQ lE2EB

  LDY vE56A,X
  LDA vE79C,Y
  AND #&02
  BEQ lE2D9

  LDA vE56C,X:STA vE56B,X
  LDA vE57C,X:STA vE56D,X

.lE2D9
  LDA vE79C,Y
  AND #&40
  BEQ lE2E6

  LDA vE594:STA vE593

.lE2E6
  LDA vE59F,X
  BNE lE2FE

.lE2EB
  LDA vE5B7,X:STA vE59F,X
  LDA #&00:STA vE5B7,X

  LDY vE56A,X
  DEC vE59B

  BNE lE347

.lE2FE
  STA vE5B7,X

  TAY
  LDA vE650,Y
  STA vD401,X
  STA vE59E,X
  STA vE5A0,X

  LDA vE5F0,Y
  STA vD400,X
  STA vE59D,X
  STA vE59C,X

  LDY vE56A,X
  LDA vE79B,Y:STA vD404,X
  LDA vE797,Y:STA vD405,X
  LDA vE798,Y:STA vD406,X
  LDA vE56B,X:STA vD402,X
  LDA vE56D,X:STA vD403,X
  LDA vE593:STA vD416
  LDA vE5C8,X:STA vE5C9,X

.lE347
  LDA vE796,Y:AND vE59B:STA vD404,X

  INC vE557,X
  LDY vE557,X
  LDA (&FE),Y
  CMP #&FF
  BNE lE37E

  LDA #&00:STA vE557,X

  INC vE580,X
  LDY vE580,X
  LDA (&FC),Y
  CMP #&FF
  BNE lE374

  LDA #&00:STA vE580,X

  BEQ lE37E

.lE374
  CMP #&FE
  BNE lE37E

  LDA #&00:STA vE000

  RTS
}

.lE37E
{
  LDA vE5B7,X
  BEQ lE3AA

  LDY vE56A,X
  LDA vE554,X
  BNE lE399

  LDA vE7E1,Y
  BEQ lE39C

  STA vE554,X

  LDA vE7E0,Y:STA vE567,X

.lE399
  JMP lE4DE
}

.lE39C
{
  LDA vE7DD,Y
  BEQ lE3A4

  JMP lE77C
}

.lE3A4
{
  STA vE552,X

  JMP lE12A
}

.lE3AA
{
  LDA vE799,Y:STA vE599
  BEQ lE3FB

  LDA vE558,X
  BNE lE3DA

  CLC
  LDA vE56B,X
  ADC vE599
  STA vE56B,X
  STA vD402,X

  LDA vE56D,X
  ADC #&00
  STA vE56D,X
  STA vD403,X

  CLC
  CMP vE555,X
  BCC lE3FB

  INC vE558,X

  BNE lE3FB

.lE3DA
  LDA vE56B,X
  SEC:SBC vE599
  STA vE56B,X
  STA vD402,X

  LDA vE56D,X
  SBC #&00
  STA vE56D,X
  STA vD403,X

  CLC
  CMP vE556,X
  BCS lE3FB
  DEC vE558,X

.lE3FB
  LDA vE553,X
  BEQ lE439

  LDA vE57D,X
  ASL  A
  TAY
  LDA vE6B0,Y:STA vE424
  LDA vE6B1,Y:STA vE425
  LDA vE5A2,X
  CMP vE5A1,X
  BNE lE41E

  LDA #&00:STA vE5A2,X

.lE41E
  TAY

  LDA vE59F,X
  CLC
vE424 = * + 1
vE425 = * + 2
  ADC vE6BA,Y
  TAY
  LDA vE5F0,Y:STA vD400,X
  LDA vE650,Y:STA vD401,X

  INC vE5A2,X

  JMP lE12A
}

.lE439
{
  LDA vE552,X
  BNE lE441

  JMP lE4DE
}

.lE441
{
  LDA vE5C9,X
  BEQ lE44C

  DEC vE5C9,X

  JMP lE4DE
}

.lE44C
{
  LDA vE5B1,X
  BEQ lE48A

  CMP #&03
  BCC lE4B3

  SEC
  LDA vE59C,X
  SBC vE5B2,X
  STA vE59C,X
  STA vD400,X

  LDA vE5A0,X
  SBC #&00
  STA vE5A0,X
  STA vD401,X

  DEC vE5B4,X
  BNE lE487

  LDA vE5B3,X:STA vE5B4,X

  INC vE5B1,X

  LDA vE5B1,X
  CMP #&05
  BCC lE487

  LDA #&01:STA vE5B1,X

.lE487
  JMP lE12A
}

.lE48A
{
  SEC
  LDA vE59C,X
  SBC vE5B2,X
  STA vE59C,X
  STA vD400,X

  LDA vE5A0,X
  SBC #&00
  STA vE5A0,X
  STA vD401,X

  DEC vE5B4,X
  BNE lE4B0

  LDA vE5B3,X:STA vE5B4,X

  INC vE5B1,X

.lE4B0
  JMP lE12A
}

.lE4B3
{
  CLC
  LDA vE59C,X
  ADC vE5B2,X
  STA vE59C,X
  STA vD400,X

  LDA vE5A0,X
  ADC #&00
  STA vE5A0,X
  STA vD401,X
  DEC vE5B4,X
  BNE lE54F

  LDA vE5B3,X:STA vE5B4,X

  INC vE5B1,X
  BNE lE54F

  JMP lE12A
}

.lE4DE
{
  LDA vE554,X
  BEQ lE542

  CMP #&01
  BEQ lE4FF

  CMP #&02
  BEQ lE52A

  CMP #&03
  BEQ lE51A

  CLC
  LDA vE5A0,X
  ADC vE567,X
  STA vE5A0,X
  STA vD401,X

  JMP lE542
}

.lE4FF
{
  CLC
  LDA vE59C,X
  SBC vE567,X
  STA vE59C,X
  STA vD400,X

  LDA vE5A0,X
  SBC #&00
  STA vE5A0,X
  STA vD401,X

  JMP lE542
}

.lE51A
{
  SEC
  LDA vE5A0,X
  SBC vE567,X
  STA vE5A0,X
  STA vD401,X

  JMP lE542
}

.lE52A
{
  CLC

  LDA vE59C,X
  ADC vE567,X
  STA vE59C,X
  STA vD400,X

  LDA vE5A0,X
  ADC #&00
  STA vE5A0,X
  STA vD401,X

.^lE542
  LDY vE56A,X
  LDA vE79C,Y
  AND #&01
  BEQ lE54F

  JMP lE8A7
}

.lE54F
{
  JMP lE12A
}

.vE552
.vE553
.vE554
.vE555
.vE556
.vE557
.vE558
.vE55E
.vE565
.vE567
.vE569
.vE56A
.vE56B
.vE56C
.vE56D
.vE57C
.vE57D
.vE57E
.vE57F
.vE580
.vE582
.vE585
.vE586
.vE587
.vE589
.vE58C
.vE58D
.vE58E
.vE590
.vE593
.vE594
.vE596
.vE598
.vE599
.vE59A
.vE59B
.vE59C
.vE59D
.vE59E
.vE59F
.vE5A0
.vE5A1
.vE5A2
.vE5B1
.vE5B2
.vE5B3
.vE5B4
.vE5B7
.vE5C6
.vE5C7
.vE5C8
.vE5C9
.vE5CB
.vE5CC
.vE5DB
.vE5DC
.vE5DD
.vE5F0
.vE650
.vE6B0
.vE6B1
.vE6BA
.vE6D4
.vE6D7

ORG &E712
{
  LDA #&27:STA ISR
  LDA #&E7:STA ISR+1
  LDX #&00:STX vDC0E

  INX
  STX GFX_ICR

  CLI
  RTS

  LDA #&01:STA GFX_ISR
  LDA #&82:STA GFX_RASTER_LINE
  LDA #&1B:STA GFX_VICII_REG1
  LDA #&01:STA GFX_BORDER_COLOUR

  JSR lE002

  DEC GFX_BORDER_COLOUR

  JMP lEA31
}

.vE755
.vE756
.vE759

ORG &E75A
.lE75A
{
  PHA
  AND #&0F
  STA vE57D,X
  PLA

  AND #&F0
  LSR  A
  LSR  A
  LSR  A
  LSR  A
  STA vE5A1,X

  LDA #&00:STA vE5A2,X
  LDA #&01:STA vE553,X
  LDA #&00:STA vE552,X

  JMP lE18C
}

.lE77C
{
  STA vE5B2,X

  LDA vE7DE,Y
  STA vE5B3,X
  STA vE5B4,X

  LDA #&00:STA vE5B1,X
  LDA #&01:STA vE552,X

  JMP lE12A
}

.vE795
.vE796
.vE797
.vE798
.vE799
.vE79A
.vE79B
.vE79C
.vE7DD
.vE7DE
.vE7DF
.vE7E0
.vE7E1
.vE7E2
.vE7E3
.vE825
.vE854
.vE883
.vE889
.vE88F
.vE895
.vE89B
.vE8A1

ORG &E8A7
.lE8A7
{
  LDA v00FC
  PHA

  LDA v00FD
  PHA

  LDA vE7E2,Y
  TAY

  LDA vE6D4,Y:STA v00FC
  LDA vE6D7,Y:STA v00FD

  LDY vE5CC,X
  LDA (&FC),Y
  BPL lE8D8

  CMP #&FF
  BEQ lE8F8

  STA vD404,X

  INY
  INC vE5CC,X

  LDA (&FC),Y:STA vD401,X

  INY
  INC vE5CC,X

  BNE lE8F8

.lE8D8
  STA vE5CB,X

  INY
  INC vE5CC,X
  SEC

  LDA vE5A0,X
  SBC (&FC),Y
  STA vE5A0,X

  INY
  INC vE5CC,X

  LDA vE5CB,X:STA vD404,X
  LDA vE5A0,X:STA vD401,X

.lE8F8
  PLA
  STA v00FD
  PLA

  STA v00FC

  JMP lE12A
}

.vE901
.lEA31

ORG &EE00
.lEE00
{
  JSR lEF6D

  RTS
}

.lEE04
{
  LDA vF084
  TAY
  LDA vF085,Y:STA vEEF7
  LDA vF08F,Y:STA vEEFE
  LDA #&00:STA vF084

  LDX #&00
  JSR lEE29

  LDX #&07
  JSR lEE29

  LDX #&0E
  JSR lEE29

  RTS
}

.lEE29
{
  LDA vEEF7,X
  BEQ lEE31

  JMP lEE5F
}

.lEE31
{
  JMP lEE43
}

.lEE34
{
  JMP lF005
}

.lEE37
{
  RTS
}

.lEE38
{
  LDY #&17

.lEE3A
  LDA #&00:STA vD400,Y

  DEY
  BPL lEE3A

  RTS
}

.lEE43
{
  LDA vEF24,X
  BNE lEE59

  LDA vEEFA,X
  CMP vEEFC,X
  BEQ lEE56

  STA vD404,X
  STA vEEFC,X

.lEE56
  JMP lEE34
}

.lEE59
{
  DEC vEF24,X

  JMP lEE34
}

.lEE5F
{
  LDA vEEF7,X:STA vEF23,X
  TAY

  LDA vF111,Y
  STA vD400,X
  STA vEF0D,X

  LDA vF125,Y
  STA vD401,X
  STA vEF0C,X

  LDA vF0FD,Y
  STA vEF24,X

  JMP lEE8F
}

.lEE81
{
  LDA vEEFC,X:STA vD404,X
  LDA #&00:STA vEEF7,X

  JMP lEE31
}

.lEE8F
{
  LDA #&00
  STA vD404,X
  STA vD405,X
  STA vD406,X

  LDY vEF23,X
  LDA vF099,Y

  PHA

  AND #&F0
  STA vD402,X
  STA vEEF8,X
  STA vEF11,X

  PLA

  AND #&0F
  STA vD403,X
  STA vEEF9,X
  STA vEF10,X

  LDA vF0AD,Y:STA vD405,X
  LDA vF0C1,Y:STA vD406,X
  LDA vF0D5,Y:STA vEEFC,X
  LDA vF0E9,Y:STA vEEFA,X
  LDA vF139,Y:STA vEEFB,X
  LDA vF14D,Y:STA vEEFD,X
  LDA vF161,Y:STA vEF25,X
  LDA vF175,Y:STA vEF26,X
  LDA vF189,Y:STA vEF0E,X
  LDA vF19D,Y:STA vEF22,X

  JMP lEE81
}

.vEEF7
.vEEF8
.vEEF9
.vEEFA
.vEEFB
.vEEFC
.vEEFD
.vEEFE
.vEF05
.vEF0C
.vEF0D
.vEF0E
.vEF0F
.vEF10
.vEF11
.vEF22
.vEF23
.vEF24
.vEF25
.vEF26
.vEF2A
.vEF2B
.vEF31
.vEF32

ORG &EF36
.lEF36
{
  LDA vEF0D,X
  LDY vEF0C,X
  STA vD400,X
  STA vEF0C,X

  TYA
  STA vD401,X
  STA vEF0D,X

  JMP lF01D
}

.lEF4C
{
  LDA vEF0D,X
  EOR vEF22,X
  STA vEF0D,X
  STA vD401,X

  JMP lF01D
}

.lEF5B
{
  LDA vEF0C,X
  SBC vEEFD,X
  EOR vEF22,X
  STA vEF0C,X
  STA vD401,X

  JMP lF01D
}

.lEF6D
{
  LDA #&00
  STA vEF23
  STA vEF2A
  STA vEF31
  STA vEEF7
  STA vEEFE
  STA vEF05
  STA vEF24
  STA vEF2B
  STA vEF32

  JSR lEE38

  LDA #&0F:STA vD418

  RTS
}

.lEF93
{
  CMP #&01
  BEQ lEFAA

  CMP #&02
  BEQ lEFCB

  CMP #&03
  BEQ lEFBC

  CMP #&04
  BEQ lEFE7

  CMP #&05
  BEQ lEFF6

  JMP lF01A
}

.lEFAA
{
  LDA vEF0D,X
  CLC:ADC vEEFB,X
  STA vEF0D,X
  STA vD400,X

  BCS lEFBC

  JMP lF01A
}

.lEFBC
{
  LDA vEF0C,X
  ADC vEEFD,X
  STA vEF0C,X
  STA vD401,X

  JMP lF01A
}

.lEFCB
{
  SEC
  LDA vEF0D,X
  SBC vEEFB,X
  STA vEF0D,X
  STA vD400,X

  LDA vEF0C,X
  SBC vEEFD,X
  STA vEF0C,X
  STA vD401,X

  JMP lF01A
}

.lEFE7
{
  LDA vEF0C,X
  SBC vEEFD,X
  STA vEF0C,X
  STA vD401,X

  JMP lF01A
}

.lEFF6
{
  LDA vEF0D,X
  SBC vEEFB,X
  STA vEF0D,X
  STA vD400,X

  JMP lF01A
}

.lF005
{
  LDA vEF23,X
  BEQ lF01D

  LDA vEF26,X
  BEQ lF012

  JMP lF03A
}

.lF012
{
  LDA vEF25,X
  BEQ lF01A

  JMP lEF93
}

.lF01A
{
  JMP lF020
}

.lF01D
{
  JMP lEE37
}

.lF020
{
  LDA vEF0E,X
  BEQ lF01D

  CMP #&01
  BNE lF02C

  JMP lEF36
}

.lF02C
{
  CMP #&04
  BNE lF033

  JMP lEF4C
}

.lF033
{
  CMP #&06
  BNE lF01D

  JMP lEF5B
}

.lF03A
{
  LDA vEF0F,X
  BNE lF060

  LDA vEEF8,X
  CLC:ADC vEF26,X
  STA vEEF8,X
  STA vD402,X

  LDA vEEF9,X
  ADC #&00
  STA vEEF9,X
  STA vD403,X

  CMP #&0E
  BCC lF081

  LDA #&01:STA vEF0F,X

.lF060
  LDA vEEF8,X
  SEC:SBC vEF26,X
  STA vEEF8,X
  STA vD402,X

  LDA vEEF9,X
  SBC #&00
  STA vEEF9,X
  STA vD403,X

  CMP #&08
  BCS lF081

  LDA #&00:STA vEF0F,X

.lF081
  JMP lF012
}

.vF084
.vF085
.vF08F
.vF099
.vF0AD
.vF0C1
.vF0D5
.vF0E9
.vF0FD
.vF111
.vF125
.vF139
.vF14D
.vF161
.vF175
.vF189
.vF19D
.vF3FB
.vF3FC
.vF3FD
.vF3FE
.vF3FF
.lFD02 ; j
.vFD0F
.lFD15 ; j
.lFD50 ; j
.lFDA3 ; j
.lFE2D ; j
.lFF5B ; j

ORG &FFFF
.c64end

SAVE "c64_built", c64start, c64end
