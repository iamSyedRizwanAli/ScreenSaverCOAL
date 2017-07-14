.MODEL SMALL
.STACK 100H
.DATA
		LOADINGMSG DB 'l    ll  lll ll   l l   l lllll'
				   DB 'l   l  l l l l l  l ll  l l    '
				   DB 'l   l  l l l l  l l l l l l lll'
				   DB 'l   l  l lll l  l l l  ll l   l'
				   DB 'lll llll l l lll  l l   l lllll'
		LOADTIME   DB 'LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL'

		PACMAN	DB '      llllllllllllllll      '
				DB '   llllllllllllllllllllll   '
				DB '  llllllllllllllllllllllll  '
				DB ' lllllllDDllllllllAAlllllll '
				DB 'llllllllDDllllllllAAllllllll'
				DB 'llllllllllllllllllllllllllll'
				DB 'llAAAAAAAAAAAAAAAAAAAAAAAAll'
				DB 'lllAAAAAAAAAAAAAAAAAAAAAAlll'
				DB 'llllAAABBBBBBBBBBBBBBAAAllll'
				DB ' llllABBBBBBBBBBBBBBBBAllll '
				DB '  llllllllllllllllllllllll  '
				DB '   llllllllllllllllllllll   '
				DB '      llllllllllllllll      '

		PACMANHELLO DB 'l l lll l   l   lll    l l ll   ll llll  l  llll ll   ll  l  ll  l'
					DB 'lll ll  l   l   l l    l   l l l l l  l l l l    l l l l lll l l l'
					DB 'l l lll lll lll lll l  l   l  l  l l    l l llll l  l  l l l l  ll'
					    
					   
		WELCOMEMSG DB 'lll ll    l lll    lllll l  l l lllll   l lllll'
				   DB 'l l l l   l l  l     l   l  l l ll      l ll   '	
				   DB 'l l l  l  l l   l    l   llll l  lll    l  lll '
				   DB 'lll l   l l l    l   l   l  l l    ll   l    ll'
				   DB 'l l l    ll lllll    l   l  l l lllll   l lllll'
				    
		PUCIT DB 'AAAA    AA    AA   AAAAAA  AA  AAAAAAAA'
		      DB 'AAAAA   AA    AA  AAAAAAA  AA  AAAAAAAA'
			  DB 'AA AAA  AA    AA  AA       AA     AA   '
			  DB 'AA  AA  AA    AA  AA       AA     AA   '
			  DB 'AA AAA  AA    AA  AA       AA     AA   '
			  DB 'AAAAA   AA    AA  AA       AA     AA   '
			  DB 'AAAA    AA    AA  AA       AA     AA   '
			  DB 'AA      AA    AA  AA       AA     AA   '
			  DB 'AA      AA    AA  AA       AA     AA   '
			  DB 'AA      AA    AA  AA       AA     AA   '
			  DB 'AA      AAAAAAAA  AAAAAAA  AA     AA   '
			  DB 'AA      AAAAAAAA  AAAAAAA  AA     AA   '
				 
	   HEART DB '   llllll    llllll   '
			 DB	'  llllllll  llllllll  '
			 DB	' llllllllllllllllllll '
			 DB	'llllllllllllllllllllll'
			 DB	'llllllllllllllllllllll'
			 DB	' llllllllllllllllllll '
			 DB	'   llllllllllllllll   '
			 DB	'    llllllllllllll    '
			 DB	'      lllllllllll     '
			 DB	'       lllllllll      '
			 DB	'         lllll        '
			 DB	'          lll         '
			       
		ALIVE DB  'l  l  l    lll l       l llll   ll  ll   l  lll llll '
			  DB  'l  l  l     l   l     l  l     l  l l l  l l    l    '
			  DB  'l  l  l     l    l   l   lll   l  l l  l l l    lll  '
			  DB  'l  l  l     l     l l    l     l  l l   ll l    l    '
              DB  ' ll   llll lll     l     llll  llll l    l llll llll '
					
		  DANKE DB 'llll     llll  ll    ll ll   ll llllll  lll '
				DB 'll ll   ll  ll lll   ll ll  ll  ll      lll '
				DB 'll  ll  ll  ll llll  ll ll ll   ll      lll '
				DB 'll   ll ll  ll ll ll ll llll    llll    lll '
				DB 'll   ll llllll ll  llll ll ll   ll      lll '
				DB 'll  ll  ll  ll ll   lll ll  ll  ll          '       
				DB 'lllll   ll  ll ll    ll ll   ll llllll  lll '     '

			  	   	
.386
.CODE
MAIN PROC

	MOV AX, @DATA
	MOV DS, AX

	MOV AX, 0B800H
	MOV ES, AX
	CLD
	CALL SCREEN_ONE

	CALL COMMA
	MOV AH, 09H
        MOV AL, 0
	PUSH AX
	CALL SCROLLUP_SCREEN

	CALL SCREEN_TWO

	CALL COMMA
	CALL COMMA
	
	MOV AX, 0E00H
	PUSH AX
	CALL SCROLLDOWN_SCREEN

	CALL SCREEN_THREE
	CALL COMMA
	CALL COMMA

	MOV AX, 0F00H
	PUSH AX
	CALL SCROLLUP_SCREEN

	CALL SCREEN_FOUR
	CALL COMMA
	CALL COMMA

	MOV AX, 0C00H
	PUSH AX	
	CALL SCROLLDOWN_SCREEN

	CALL SCREEN_FIVE

	CALL COMMA
	CALL COMMA

	MOV AX, 0
	PUSH AX
	CALL SCROLLUP_SCREEN

	CALL SCREEN_SIX

	MOV AH, 1
	INT 21H

MOV AH, 4CH
INT 21H
MAIN ENDP

SCREEN_SIX PROC
	
	PUSH AX
	PUSH SI
	PUSH DI
	PUSH CX
	PUSH DX

	XOR CX, CX
	LEA SI, DANKE
	XOR DX, DX
	MOV DI, 36
	ADD DI, 1440

	WHILE1:
		CMP CX, 308
		JE END_WHILE1

		CMP DX, 44
		JB CONTINUE
		ADD DI, 72
		XOR DX, DX
		CONTINUE:

		LODSB

		CMP AL, 20H
		JE SPACE
		
		MOV AX, 0BDBH
		STOSW
		JMP SPACE_END

		SPACE:

		ADD DI, 2

		SPACE_END:
		
		INC DX
		INC CX

		JMP WHILE1
		END_WHILE1:

	POP DX
	POP CX
	POP DI
	POP SI
	POP AX

	RET
SCREEN_SIX ENDP

SCREEN_FIVE PROC
	
	PUSH AX
	PUSH SI
	PUSH DI
	PUSH CX
	PUSH DX

	CLD

	XOR CX, CX
	LEA SI, HEART
	XOR DX, DX
	MOV DI, 58
	ADD DI, 480

	WHILE1:
		CMP CX, 264
		JE END_WHILE1

		CMP DX, 22
		JB CONTINUE
		ADD DI, 116
		XOR DX, DX
		CONTINUE:

		LODSB

		CMP AL, 20H
		JE SPACE
		
		MOV AX, 0CCDBH
		STOSW
		JMP SPACE_END

		SPACE:

		ADD DI, 2

		SPACE_END:
		
		INC DX
		INC CX

		JMP WHILE1
		END_WHILE1:

	MOV DI, 26
	ADD DI, 2720
	LEA SI, ALIVE
	XOR CX, CX
	XOR DX, DX

	WHILE2:
		CMP CX, 265
		JE END_WHILE2

		CMP DX, 53
		JB CONTINUE2
		ADD DI, 54
		XOR DX, DX
		CONTINUE2:

		LODSB

		CMP AL, 20H
		JE SPACE2
		
		MOV AX, 0EDBH
		STOSW
		JMP SPACE_END2

		SPACE2:

		ADD DI, 2

		SPACE_END2:
		
		INC DX
		INC CX
		JMP WHILE2
		END_WHILE2:

	POP DX
	POP CX
	POP DI
	POP SI
	POP AX

	RET
SCREEN_FIVE ENDP

SCREEN_FOUR PROC

	PUSH SI
	PUSH DI
	PUSH AX
	PUSH CX
	PUSH DX
	PUSH AX

	XOR DX, DX
	XOR CX, CX
	LEA SI, PUCIT

	MOV DI, 3880

	WHILE1:
		CMP CX, 468
		JE END_WHILE1

		CMP DX, 39
		JB CONTINUE
		MOV AX, 0F00H
		PUSH AX
		CALL SCROLLUP
		MOV DI, 3880
		XOR DX, DX
		
		CALL DELAYTIME
		CALL DELAYTIME
		CALL DELAYTIME
		CALL DELAYTIME

		CONTINUE:

		LODSB
		CMP AL, 20H
		JE SPACE
		
		MOV AX, 01DBH

		JMP END_SPACE
		SPACE:
		MOV AX, 0FDBH

		END_SPACE:

		STOSW

		INC CX
		INC DX
		JMP WHILE1
		END_WHILE1:

		MOV CX, 6
		MOV AX, 0F00H

		FOR1:
			PUSH AX
			CALL SCROLLUP
			
			CALL DELAYTIME
			CALL DELAYTIME
			CALL DELAYTIME
			CALL DELAYTIME	
			
			LOOP FOR1
			

	POP AX
	POP DX
	POP CX
	POP AX
	POP DI
	POP SI
	RET
SCREEN_FOUR ENDP

SCROLLUP PROC
; this function only recieves background and foreground colour of text
	PUSH BP
	MOV BP, SP

	PUSH DI
	PUSH SI
	PUSH CX
	PUSH AX
	PUSH DS

	CLD
	MOV AX, ES
	MOV DS, AX
	
	MOV AX, [BP + 4]
	MOV AL, 0DBH

	XOR DI, DI
	MOV SI, 160
	MOV CX, 1920
	REP MOVSW
	MOV CX, 80
	REP STOSW

	POP DS
	POP AX
	POP CX
	POP SI
	POP DI
	POP BP

	RET 2
SCROLLUP ENDP

SCREEN_THREE PROC

	PUSH SI
	PUSH DI
	PUSH AX
	PUSH CX

	CLD

	XOR CX, CX
	LEA SI, WELCOMEMSG

	MOV DI, 32
	ADD DI, 1600

	WHILE1:
		CMP CL, 235
		JE END_WHILE1

		CMP CH, 47
		JB CONTINUE
		ADD DI, 66
		XOR CH, CH

		CONTINUE:
			LODSB

			CMP AL, 32
			JE SPACE
			MOV AH, 0CH
			JMP END_SPACE

			SPACE:
			MOV AH, 0EH

			END_SPACE:
			
			MOV AL, 0DBH

			STOSW

		INC CH
		INC CL
		JMP WHILE1
		END_WHILE1:

	POP CX
	POP AX
	POP DI
	POP SI

	RET
SCREEN_THREE ENDP

SCREEN_TWO PROC

	PUSH SI
	PUSH DI
	PUSH AX
	PUSH CX
	PUSH DX

	XOR DX, DX
	LEA SI, PACMAN

	XOR CX, CX
	
	MOV DI, 52
	ADD DI, 800

	WHILE1:

		CMP CX, 364
		JE END_WHILE1

		CMP DX, 28
		JB CONTINUE
		ADD DI, 104
		XOR DX, DX

		CALL DELAYTIME

		CONTINUE:
		LODSB
		CMP AL, 32
		JE SPACE
		CMP AL, 'A'
		JE BLACK
		CMP AL, 'B'
		JE RED
		CMP AL, 'D'
		JE BLINK
		MOV AH, 0EH
		JMP END_SPACE
		
		BLINK:
		MOV AH, 8EH
		JMP END_SPACE

		RED:
		MOV AH, 0CH
		JMP END_SPACE

		BLACK:
		MOV AX, 0720H
		JMP END_BLACK

		SPACE:
		MOV AH, 09H
		END_SPACE:

		MOV AL, 0DBH

		END_BLACK:

		STOSW

		INC DX
		INC CX

		JMP WHILE1
		END_WHILE1:

	XOR CX, CX
	
	ADD DI, 226

	WHILE2:
		CMP CH, 198
		JE END_WHILE2

		CMP CL, 66
		JB CONTINUE2
		ADD DI, 28
		XOR CL, CL

		CONTINUE2:

		LODSB
		CMP AL, 32
		JE SPACE2
		MOV AH, 0EH
		JMP END_SPACE2
		
		SPACE2:
		MOV AH, 09H
		END_SPACE2:

		MOV AL, 0DBH

		STOSW

		INC CL
		INC CH

		JMP WHILE2
		END_WHILE2:

	POP DX
	POP CX
	POP AX
	POP DI
	POP SI

	RET
SCREEN_TWO ENDP

SCROLLDOWN_SCREEN PROC
	; this function recieves background color
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH DS
	PUSH DI
	PUSH SI
	PUSH CX
	PUSH BX
	
	MOV BX, 25
	STD
	MOV AX, ES
	MOV DS, AX
	
	MOV AX, [BP + 4]
	MOV AL, 0DBH
	WHILE1:
		CMP BX, 0
		JE END_WHILE1
		
		MOV DI, 3998
		MOV SI, 3838
		MOV CX, 1920
		REP MOVSW
		MOV CX, 80
		REP STOSW
		DEC BX
	
		CALL DELAYTIME

		JMP WHILE1
		END_WHILE1:

	POP BX
	POP CX
	POP SI
	POP DI
	POP DS
	POP AX
	POP BP
	RET 2
SCROLLDOWN_SCREEN ENDP


SCROLLUP_SCREEN PROC
	; this function recieves background color
	PUSH BP
	MOV BP, SP
	PUSH AX
	PUSH DS
	PUSH DI
	PUSH SI
	PUSH CX
	PUSH BX
	
	MOV BX, 25
	CLD
	MOV AX, ES
	MOV DS, AX
	
	MOV AX, [BP + 4]
	MOV AL, 0DBH
	WHILE1:
		CMP BX, 0
		JE END_WHILE1
		
		XOR DI, DI
		MOV SI, 160
		MOV CX, 1920
		REP MOVSW
		MOV CX, 80
		REP STOSW
		DEC BX
	
		CALL DELAYTIME

		JMP WHILE1
		END_WHILE1:

	POP BX
	POP CX
	POP SI
	POP DI
	POP DS
	POP AX
	POP BP
	RET 2
SCROLLUP_SCREEN ENDP

SCREEN_ONE PROC

	PUSH SI
	PUSH DI
	PUSH AX
	PUSH CX

	MOV AX, 09H
	PUSH AX
	CALL COLOR_SCREEN_CLS

	LEA SI, LOADINGMSG

	XOR CX, CX

	MOV DI, 50
	ADD DI, 1440

	WHILE1:
		
		CMP CL, 155
		JE END_WHILE1

		CMP CH, 31
		JB CONTINUE
		ADD DI, 98
		MOV CH, 0
		CONTINUE:
		LODSB
		CMP AL, 32
		JE SPACE
		MOV AH, 07H
		JMP END_SPACE


		SPACE:
		MOV AH, 09H
		END_SPACE:

		MOV AL, 0DBH
		STOSW

		INC CH
		INC CL

		JMP WHILE1
		END_WHILE1:

		MOV DI, 50
		ADD DI, 2400
		MOV AX, 07DBH
		MOV CX, 31

		REP STOSW

		CALL LOADING_TIME
		CALL CHANGE_LOAD_STATEMENT


	LEA SI, LOADINGMSG

	XOR CX, CX

	MOV DI, 50
	ADD DI, 1440

	POP CX
	POP AX
	POP DI
	POP SI

	RET
SCREEN_ONE ENDP

CHANGE_LOAD_STATEMENT PROC

	PUSH DI
	PUSH CX
	PUSH AX
	PUSH BX
	PUSH SI
	PUSH DS

	MOV AX, ES
	MOV DS, AX

	XOR CX, CX

	MOV DI, 50
	ADD DI, 1440
	MOV SI, DI
	MOV BX, 0FDBH
	
	WHILE1:
		
		CMP CL, 155
		JE END_WHILE1

		CMP CH, 31
		JB CONTINUE
		ADD DI, 98
		ADD SI, 98
		MOV CH, 0

		CALL LOADING_TIME

		CONTINUE:
		
		LODSW

		CMP AH, 07H
		JNE SPACE
		MOV AX, BX
		STOSW
		JMP END_SPACE

		SPACE:
		ADD DI, 2
		END_SPACE:

		INC CH
		INC CL


		JMP WHILE1
		END_WHILE1:
	
	POP DS
	POP SI
	POP BX
	POP AX
	POP CX
	POP DI

	RET
CHANGE_LOAD_STATEMENT ENDP

LOADING_TIME PROC

	PUSH DI
	PUSH CX
	PUSH AX
	PUSH SI

	MOV DI, 50
	ADD DI, 2400
	MOV AX, 07DBH
	MOV CX, 31
	
	CALL DELAYTIME
	
	LEA SI, LOADTIME
	
	FOR2:
		 CALL DELAYTIME
		 STOSW
		LOOP FOR2

	SUB DI, 62
	MOV CX, 31
	
	MOV AX, 0FDBH

	FOR1:
		CALL DELAYTIME
		STOSW
		
		LOOP FOR1

	POP SI
	POP AX
	POP CX
	POP DI

	RET
LOADING_TIME ENDP

COLOR_SCREEN_CLS PROC
; this function recieves the background color of screen
	PUSH BP
	MOV BP, SP

	PUSH AX
	PUSH CX
	PUSH DI

	XOR DI, DI
	MOV CX, 2000
	MOV AX, [BP + 4]
	SHL AX, 8

	MOV AL, 219

	REP STOSW

	POP DI
	POP CX
	POP AX
	POP BP
	RET 2
COLOR_SCREEN_CLS ENDP

DELAYTIME PROC
	PUSH CX
	PUSH BX

	MOV BX, 1

	MOV CX, 0FFFFH
		
	FOR1:
		LOOP FOR1

	POP BX
	POP CX
	RET
DELAYTIME ENDP

COMMA PROC

	PUSH CX

	MOV CX, 1FH

	FOR1:
		CALL DELAYTIME
		LOOP FOR1

	POP CX
	RET
COMMA ENDP

END MAIN
