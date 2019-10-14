;*********************************************************************************************
;* Stephanie Connell							    		 *
;* November 30th, 2017						      		 *
;* This program is a game loosely inspired by a game called Animal Crossing.	 *
;* The point of the game is to grow, harvest, and sell as much fruit as possible 	 *
;* in 14 days, measured by number of user-controlled moves.			 *
;*********************************************************************************************

include Irvine32.inc

;**************************************************************************************
;* This macro outputs a number of stars determined by the contents of ecx. *
;**************************************************************************************

drawstars macro ecx
local draws						;; create new label each time
	push eax
	mov al, '*'
	draws:
		call writechar				;; output an asterisk
	loop draws
	pop eax
endm

;**************************************************************************
;* This macro checks the cursor position to prevent the character *
;*		from moving beyond the border.		          *
;***************************************************************************

checkcursorposition macro
local quit						;; create a new label each time 
	.if (dl < 1)
		mov dl, 97				;; move dl to an appropriate location
		call gotoxy
		jmp quit
	.endif

	.if (dl > 97)
		mov dl, 2				;; move dl to an appropriate location
		call gotoxy
		jmp quit
	.endif

	.if (dh < 5)
		mov dh, 24				;; move dh to an appropriate location
		call gotoxy
		jmp quit
	.endif

	.if (dh > 24)
		mov dh, 5				;; move dh to an appropriate location
		call gotoxy
		jmp quit
	.endif

	quit:
endm

.data
row byte ?
col byte ?
row2 byte ?
col2 byte ?
curr byte 0
daycount dword 1
movecount byte 0
movenum byte 25
money dword 0
fruitcounter byte 0
treecount byte 0
tree1 byte 4 dup(10)
tree2 byte 4 dup(10)
tree3 byte 4 dup(10)
tree4 byte 4 dup(10)
tree5 byte 4 dup(10)
tree6 byte 4 dup(10)
tree7 byte 4 dup(10)
tree8 byte 4 dup(10)
tree9 byte 4 dup(10)
tree10 byte 4 dup(10)
ch1 byte " O ", 0ah, 0dh, 0
ch2 byte "/|\", 0ah, 0dh, 0
ch3 byte "/ \", 0ah, 0dh, 0
trunk1 byte "||", 0
trunk2 byte "| |", 0
playstr byte "Press F to start.", 0
daystr byte "Day ", 0
movestr byte "WASD - move", 0ah, 0dh, 0
fruitstr byte "Fruit: ", 0
plant byte "P - plant", 0ah, 0dh, 0
harvest byte "H - harvest", 0ah, 0dh, 0
endgame byte "Q - quit game", 0ah, 0dh, 0
enddaystr byte "End of day ", 0
checksellstr byte "Would you like to sell fruit? ", 0
sellfruitstr byte "How much fruit would you like to sell? ", 0
toomanystr byte "You don't have that much fruit! Try again.", 0
thanksstr byte "Thanks for playing!", 0

.code

;*********************
;* Main procedure *
;*********************

main proc
	call titlescreen					; begin the game
exit
main endp

titlescreen proc
	call createborder				; draw border
	
	mov eax, red + (16 * red)			;set text color to red and background color 
	call settextcolor				; to red

	mov al, '*'					; output the word 'fruits'
	mov dh, 5					; output the letter F
	mov dl, 17
	call gotoxy					; set cursor position
	
	mov ecx, 5	
	drawstars					; output 5 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 4
	drawstars					; output 4 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov dh, 5					; output the letter R
	mov dl, 25
	call gotoxy					; set cursor position
	mov ecx, 7
	drawstars					; output 7 asterisks

	inc dh
	call gotoxy					; set cursor position
	call writechar					; output asterisk
	mov dl, 31
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	inc dh
	mov dl, 25
	call gotoxy					; set cursor position
	mov ecx, 7
	drawstars					; output 7 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 3
	call gotoxy					; set cursor position
	call writechar					; output asterisks

	inc dh
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 4
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	inc dh
	sub dl, 4
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisk

	add dl, 5
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	mov dh, 5					; output the letter U
	mov dl, 36
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 5
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 4
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 4
	drawstars					; output 4 asterisks

	mov dh, 5					; output the letter I
	mov dl, 48
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	inc dh
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	mov dh, 5					; output the letter T
	mov dl, 60
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	inc dh
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov dh, 5					; output the letter S
	mov dl, 73
	call gotoxy					; set cursor position
	mov ecx, 6
	drawstars					; output 2 asterisks

	inc dh
	dec dl
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 2
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh
	sub dl, 4
	call gotoxy					; set cursor position
	mov ecx, 5
	drawstars					; output 5 asterisks

	mov eax, black + (16 * brown)		; set the text color to black and the
	call settextcolor				; background color to brown
	mov dh, 14
	mov dl, 38
	call gotoxy					; set cursor position
	lea edx, playstr				; prompt user to begin the game
	call writestring

	mov ebx, 1					; set counter

	mov dh, 18
	mov dl, 10
	call gotoxy					; set cursor position

	drawhgtree:					; draw a huge tree
		sub ebx, 1				; decrement counter
		mov eax, green + (16 * brown)	; set the text color to green and the 
		call settextcolor			;background color to brown

		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 6
		drawstars				; output 6 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 8
		drawstars				; output 8 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 10
		drawstars				; output 10 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 12
		drawstars				; output 12 asterisks

		inc dh
		inc dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 3
		drawstars				; output 3 asterisks

		mov eax, black + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		inc dh
		add dl, 4
		call gotoxy				; set cursor position
		mov al, '|'
		call writechar				; output left side of trunk

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

	mov dh, 18
	add dl, 20
	call gotoxy					; set cursor position

	drawhfrtree:					; draw huge fruit tree
		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown

		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 1
		drawstars				; output 1 asterisk

		mov eax, lightred + (16 * brown)	; set text color to light red and background 
		call settextcolor			; color to brown
		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 6
		drawstars				; output 6 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 8
		drawstars				; output 8 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 2
		drawstars				; output 2 asterisks

		mov eax, lightred + (16 * brown)	; set text color to light red and background 
		call settextcolor			; color to brown
		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, lightred + (16 * brown)	; set text color to light red and background 
		call settextcolor			; color to brown
		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 12
		drawstars				; output 12 asterisks

		inc dh
		inc dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 3
		drawstars				; output 3 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		inc dh
		add dl, 4
		call gotoxy				; set cursor position
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

		mov dh, 18
		mov dl, 50
		call gotoxy				; set cursor position
		cmp ebx, 0				; check value of ebx
		je drawhgtree				; if it is 0, draw two more trees

	call readchar					; read user input
	cmp al, 'f'					; if user typed f
	je playfruits					; jump to playfruits

	playfruits:
		call playgame				; begin playable portion of game
ret
titlescreen endp

;*********************************************************************
;* This procedure contains calls to the other procedures that *
;*	     contain various details about the game.		  *
;*********************************************************************

playgame proc
	call createborder				; draw the border
	call displayday					; display the current day
	call day					; begin the day increment counter
	
	mov dh, 12
	mov dl, 50
	call gotoxy					; set cursor position
	call drawch					; draw character

	call displaycontrols				; display information on how to play
	call displayfruit				; display fruit counter
	
	call movech					; call procedure to move the character
ret
playgame endp

;**************************************************************************************
;* This procedure creates a border around the outside of the playable area. *
;**************************************************************************************

createborder proc
	push edx					; push edx on the stack
	call clrscr					; clear the screen
	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	mov dh, 0					; set row position
	mov dl, 0					; set column position
	mov al, '*'
	mov ecx, 28					; set loop counter to the outer edge of 
	createleftborder:				; playable area
		call gotoxy				; set cursor position
		call writechar				; output asterisk
		inc dh					; move to next row
	loop createleftborder

	dec dh						; move to previous row
mov ecx, 100					; set loop counter to the outer edge of 
	createbottomborder:				; playable area
		call gotoxy				; set cursor position
		call writechar				; output asterisk
		inc dl					; move to next column
	loop createbottomborder

	mov dh, 0					; set row and column to upper left corner
	mov dl, 0
	mov ecx, 100					; set loop counter to the outer edge of 
	createtopborder:				; playable area
		call gotoxy				; set cursor position
		call writechar				; output asterisk
		inc dl					; move to next column
	loop createtopborder

	mov dh, 0					; set row to topmost position
	mov ecx, 28					; set loop counter to the outer edge of 
	createrightborder:				; playable area
		call gotoxy				; set cursor position
		call writechar				; output asterisk
		inc dh					; move to next column
	loop createrightborder 
	pop edx					; pop contents of the stack to edx
ret
createborder endp

;*******************************************************
;* This procedure draws the playable character. *
;*******************************************************

drawch proc
	call gotoxy					; set cursor position
	push edx					; push edx on the stack
	mov row, dh					; save the row position in row
	mov col, dl					; save the column position in col
	mov eax, magenta + (16 * brown)		; set text color to magenta and background 
	call settextcolor				; color to brown
	push edx					; push edx on the stack
	lea edx, ch1
	call writestring					; output the character's head
	pop edx					; pop to edx

	inc dh						; move to next row
	call gotoxy					; set cursor position
	push edx					; push edx on the stack
	lea edx, ch2
	call writestring					; output the character's arms and body
	pop edx					; pop to edx

	inc dh						; move to next row
	call gotoxy					; set cursor position
	lea edx, ch3
	call writestring					; output the character's legs
	pop edx					; pop contents of the stack to edx
ret
drawch endp

;****************************************************************************
;* This procedure checks each tree array and calls the appropriate *
;*	  procedure to draw as many trees as necessary.		 *
;****************************************************************************

drawtrees proc
	push edx					; push edx on the stack
	mov al, tree1[0]				; move type of trees1  to al
	cmp al, 0					; if it is 0
	je displayx1					; display an X
	cmp al, 1					; if it is 1
	je smdraw1					; draw small tree
	cmp al, 2					; if it is 2
	je bgdraw1					; draw big tree
	cmp al, 3					; if it is 3
	je frdraw1					; draw fruit tree
	jmp stop1					; otherwise jump to stop1

	checktree2:					; check the type of tree 2
		mov al, tree2[0]			; move type of tree2 to al
		cmp al, 0				; if it is 0
		je displayx2				; display an X
		cmp al, 1				; if it is 1
		je smdraw2				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw2				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw2				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree3:					; check the type of tree 3
		mov al, tree3[0]			; move type of trees3 to al
		cmp al, 0				; if it is 0
		je displayx3				; display an X
		cmp al, 1				; if it is 1
		je smdraw3				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw3				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw3				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree4:					; check the type of tree 4
		mov al, tree4[0]			; move type of trees4 to al
		cmp al, 0				; if it is 0
		je displayx4				; display an X
		cmp al, 1				; if it is 1
		je smdraw4				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw4				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw4				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree5:					; check the type of tree 5
		mov al, tree5[0]			; move type of trees5 to al
		cmp al, 0				; if it is 0
		je displayx5				; display an X
		cmp al, 1				; if it is 1
		je smdraw5				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw5				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw5				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree6:					; check the type of tree 6
		mov al, tree6[0]			; move type of trees6 to al
		cmp al, 0				; if it is 0
		je displayx6				; display an X
		cmp al, 1				; if it is 1
		je smdraw6				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw6				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw6				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree7:					; check the type of tree 7
		mov al, tree7[0]			; move type of trees7 to al
		cmp al, 0				; if it is 0
		je displayx7				; display an X
		cmp al, 1				; if it is 1
		je smdraw7				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw7				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw7				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree8:					; check the type of tree 8
		mov al, tree8[0]			; move type of trees8 to al
		cmp al, 0				; if it is 0
		je displayx8				; display an X
		cmp al, 1				; if it is 1
		je smdraw8				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw8				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw8				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree9:					; check the type of tree 9
		mov al, tree9[0]			; move type of trees9 to al
		cmp al, 0				; if it is 0
		je displayx9				; display an X
		cmp al, 1				; if it is 1
		je smdraw9				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw9				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw9				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	checktree10:					; check the type of tree 10
		mov al, tree10[0]			; move type of trees10 to al
		cmp al, 0				; if it is 0
		je displayx10				; display an X
		cmp al, 1				; if it is 1
		je smdraw10				; draw small tree
		cmp al, 2				; if it is 2
		je bgdraw10				; draw big tree
		cmp al, 3				; if it is 3
		je frdraw10				; draw fruit tree
		jmp stop1				; otherwise jump to stop1

	displayx1:					; display an X
		mov dh, tree1[2]			; move row of tree1 to dh
		mov dl, tree1[3]			; move column of tree1 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree2			; check the next tree

	smdraw1:					; draw a small tree
		mov dh, tree1[2]			; move row of tree1 to dh
		mov dl, tree1[3]			; move column of tree1 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree2			; check the next tree

	bgdraw1:					; draw a big tree
		mov dh, tree1[2]			; move row of tree1 to dh
		mov dl, tree1[3]			; move column of tree1 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree2			; check the next tree

	frdraw1:					; draw a fruit tree
		mov dh, tree1[2]			; move row of tree1 to dh
		mov dl, tree1[3]			; move column of tree1 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree2			; check the next tree
		
	displayx2:					; display an X
		mov dh, tree2[2]			; move row of tree2 to dh
		mov dl, tree2[3]			; move column of tree2 to dh
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree3			; check the next tree

	smdraw2:					; draw a small tree
		mov dh, tree2[2]			; move row of tree2 to dh
		mov dl, tree2[3]			; move column of tree2 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree3			; check the next tree

	bgdraw2:					; draw a big tree		
mov dh, tree2[2]			; move row of tree2 to dh
		mov dl, tree2[3]			; move column of tree2 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree3			; check the next tree

	frdraw2:					; draw a fruit tree
		mov dh, tree2[2]			; move row of tree2 to dh
		mov dl, tree2[3]			; move column of tree2 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree3			; check the next tree

	displayx3:					; display an X
		mov dh, tree3[2]			; move row of tree3 to dh
		mov dl, tree3[3]			; move column of tree3 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree4			; check the next tree

	smdraw3:					; draw a small tree
		mov dh, tree3[2]			; move row of tree3 to dh
		mov dl, tree3[3]			; move column of tree3 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree4			; check the next tree

	bgdraw3:					; draw a big tree
		mov dh, tree3[2]			; move row of tree3 to dh
		mov dl, tree3[3]			; move column of tree3 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree4			; check the next tree

	frdraw3:					; draw a fruit tree
		mov dh, tree3[2]			; move row of tree3 to dh
		mov dl, tree3[3]			; move column of tree3 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree4			; check the next tree

	displayx4:					; display an X
		mov dh, tree4[2]			; move row of tree4 to dh
		mov dl, tree4[3]			; move column of tree4 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree5			; check the next tree

	smdraw4:					; draw a small tree
		mov dh, tree4[2]			; move row of tree4 to dh
		mov dl, tree4[3]			; move column of tree4 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree5			; check the next tree

	bgdraw4:					; draw a big tree
		mov dh, tree4[2]			; move row of tree4 to dh
		mov dl, tree4[3]			; move column of tree4 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree5			; check the next tree

	frdraw4:					; draw a fruit tree
		mov dh, tree4[2]			; move row of tree5 to dh
		mov dl, tree4[3]			; move column of tree5 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree5			; check the next tree

	displayx5:					; display an X
		mov dh, tree5[2]			; move row of tree5 to dh
		mov dl, tree5[3]			; move column of tree5 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree6			; check the next tree

	smdraw5:					; draw a small tree
		mov dh, tree5[2]			; move row of tree5 to dh
		mov dl, tree5[3]			; move column of tree5 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree6			; check the next tree

	bgdraw5:					; draw a big tree
		mov dh, tree5[2]			; move row of tree5 to dh
		mov dl, tree5[3]			; move column of tree5 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree6			; check the next tree

	frdraw5:					; draw a fruit tree
		mov dh, tree5[2]			; move row of tree5 to dh
		mov dl, tree5[3]			; move column of tree5 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree6			; check the next tree

	displayx6:					; display an X 
		mov dh, tree6[2]			; move row of tree6 to dh
		mov dl, tree6[3]			; move column of tree6 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree7			; check the next tree
		
	smdraw6:					; draw a small tree
		mov dh, tree6[2]			; move row of tree6 to dh
		mov dl, tree6[3]			; move column of tree6 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree7			; check the next tree

	bgdraw6:					; draw a big tree 
		mov dh, tree6[2]			; move row of tree6 to dh
		mov dl, tree6[3]			; move column of tree6 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a big tree
		jmp checktree7			; check the next tree

	frdraw6:					; draw a fruit tree 
		mov dh, tree6[2]			; move row of tree6 to dh
		mov dl, tree6[3]			; move column of tree6 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree7			; check the next tree

	displayx7:					; display an X 
		mov dh, tree7[2]			; move row of tree7 to dh
		mov dl, tree7[3]			; move column of tree7 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree8			; check the next tree

	smdraw7:					; draw a small tree 
		mov dh, tree7[2]			; move row of tree7 to dh
		mov dl, tree7[3]			; move column of tree7 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree8			; check the next tree

	bgdraw7:					; draw a big tree 
		mov dh, tree7[2]			; move row of tree7 to dh
		mov dl, tree7[3]			; move column of tree7 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree8			; check the next tree

	frdraw7:					; draw a fruit tree
		mov dh, tree7[2]			; move row of tree7 to dh
		mov dl, tree7[3]			; move column of tree7 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree8			; check the next tree

	displayx8:					; display an X
		mov dh, tree8[2]			; move row of tree8 to dh
		mov dl, tree8[3]			; move column of tree8 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree9			; check the next tree

	smdraw8:					; draw a small tree 
		mov dh, tree8[2]			; move row of tree8 to dh
		mov dl, tree8[3]			; move column of tree8 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree9			; check the next tree

	bgdraw8:					; draw a big tree 
		mov dh, tree8[2]			; move row of tree8 to dh
		mov dl, tree8[3]			; move column of tree8 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree9			; check the next tree

	frdraw8:					; draw a fruit tree 
		mov dh, tree8[2]			; move row of tree8 to dh
		mov dl, tree8[3]			; move column of tree8 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree9			; check the next tree

	displayx9:					; display an X 
		mov dh, tree9[2]			; move row of tree9 to dh
		mov dl, tree9[3]			; move column of tree9 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp checktree10			; check the next tree

	smdraw9:					; draw a small tree 
		mov dh, tree9[2]			; move row of tree9 to dh
		mov dl, tree9[3]			; move column of tree9 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp checktree10			; check the next tree

	bgdraw9:					; draw a big tree
		mov dh, tree9[2]			; move row of tree9 to dh
		mov dl, tree9[3]			; move column of tree9 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp checktree10			; check the next tree

	frdraw9:					; draw a fruit tree 
		mov dh, tree9[2]			; move row of tree9 to dh
		mov dl, tree9[3]			; move column of tree9 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp checktree10			; check the next tree

	displayx10:					; display an X 
		mov dh, tree10[2]			; move row of tree10 to dh
		mov dl, tree10[3]			; move column of tree10 to dl
		call gotoxy				; set cursor position
		call displayhole			; call procedure that displays an X
		jmp stop1				; jump to stop1

	smdraw10:					; draw a small tree
		mov dh, tree10[2]			; move row of tree10 to dh
		mov dl, tree10[3]			; move column of tree10 to dl
		call gotoxy				; set cursor position
		call drawsmtree			; call procedure that draws a small tree
		jmp stop1				; jump to stop1

	bgdraw10:					; draw a big tree 
		mov dh, tree10[2]			; move row of tree10 to dh
		mov dl, tree10[3]			; move column of tree10 to dl
		call gotoxy				; set cursor position
		call drawbgtree			; call procedure that draws a big tree
		jmp stop1				; jump to stop1

	frdraw10:					; draw a fruit tree 
		mov dh, tree10[2]			; move row of tree10 to dh
		mov dl, tree10[3]			; move column of tree10 to dl
		call gotoxy				; set cursor position
		call drawfrtree				; call procedure that draws a fruit tree
		jmp stop1				; jump to stop1

	stop1:
		pop edx				; pop contents of the stack to edx
ret
drawtrees endp

;*******************************************
;* This procedure draws a small tree. *
;*******************************************

drawsmtree proc
	push edx					; push edx on the stack
	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown
	mov al, '*'

	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov ecx, 4
	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	drawstars					; output 4 asterisks

	mov ecx, 2
	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	drawstars					; output 2 asterisks
	
	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	lea edx, trunk1				; output trunk
	call writestring

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'
	mov ecx, 2
	drawstars					; output 2 asterisks
	call crlf

	pop edx					; pop the contents of the stack to edx
ret
drawsmtree endp

;****************************************
;* This procedure draws a big tree. *
;****************************************

drawbgtree proc
	push edx					; push edx on the stack

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'

	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov ecx, 4
	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	drawstars					; output 4 asterisks

	mov ecx, 6
	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	drawstars					; output 6 asterisks

	mov ecx, 2
	inc dh						; move to next row
	call gotoxy					; set cursor position
	drawstars					; output 2 asterisks

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown

	push edx					; push edx on the stack
	lea edx, trunk2				; output trunk
	call writestring
	pop edx					; pop contents of the stack to edx

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'
	call writechar					; output asterisk

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown

	inc dh						; move to next row
	add dl, 2
	call gotoxy					; set cursor position
	lea edx, trunk2				; output trunk
	call writestring
	pop edx					; pop the contents of the stack to edx
ret
drawbgtree endp

;*****************************************
;* This procedure draws a fruit tree. *
;*****************************************

drawfrtree proc
	push edx					; push edx on the stack

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'

	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	mov eax, lightred + (16 * brown)		; set text color to light red and background 
	call settextcolor				; color to brown

	mov al, 'O'
	call writechar					; output fruit

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov ecx, 2
	inc dh						; move to next row
	sub dl, 1
	call gotoxy					; set cursor position
	drawstars					; output 2 asterisks

	mov eax, lightred + (16 * brown)		; set text color to light red and background 
	call settextcolor				; color to brown

	mov al, 'O'
	call writechar					; output fruit

	mov eax, green + (16 * brown)		; set text color to green and background 	
call settextcolor				; color to brown


	mov al, '*'
	call writechar					; output asterisk

	mov eax, lightred + (16 * brown)		; set text color to light red and background 
	call settextcolor				; color to brown

	mov al, 'O'
	call writechar					; output fruit

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'
	call writechar					; output asterisk

	mov ecx, 2
	inc dh						; move to next row
	call gotoxy					; set cursor position
	drawstars					; output 2 asterisks

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown

	push edx					; push edx on the stack
	lea edx, trunk2													; output trunk
	call writestring
	pop edx					; pop the contents of the stack to edx

	mov eax, green + (16 * brown)		; set text color to green and background 
	call settextcolor				; color to brown

	mov al, '*'
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown

	inc dh						; move to next row
	add dl, 2
	call gotoxy					; set cursor position
	lea edx, trunk2				; output trunk
	call writestring

	pop edx					; pop the contents of the stack to edx
ret
drawfrtree endp

;*****************************************************
;* This procedure displays the current day and *
;*	the amount of money accumulated.	    *
;*****************************************************

displayday proc
	push edx					; push edx on the stack

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	mov dh, 1
	mov dl, 2
	call gotoxy					; set cursor position
	push edx					; push edx on the stack
	lea edx, daystr					; output the word day
	call writestring
	pop edx					; pop the contents of the stack to edx
	mov eax, daycount
	call writedec					; output current day number

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov al, '$'
	call writechar					; output dollar sign
	mov eax, money
	call writedec					; output current amount of money

	pop edx					; pop the contents of the stack to edx
ret
displayday endp

;*********************************************************************
;* This procedure displays various strings between days and *
;*		   prompts the player to sell fruit.		   *
;*********************************************************************

displaybetweenday proc
	push edx					; push edx on the stack

	call createborder				; draw the border
	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown

	mov dh, 11
	mov dl, 40
	call gotoxy					; set cursor position
	lea edx, enddaystr				; output string indicating that the day has 
	call writestring					; ended
	mov eax, daycount
	call writedec					; output the current day number

	mov dh, 12
	mov dl, 42
	call gotoxy					; set cursor position
	lea edx, fruitstr				; output string indicating has much fruit the 
	call writestring					; player has
	mov al, fruitcounter
	call writedec					; output the current number of fruit

	mov dh, 13
	mov dl, 32
	call gotoxy					; set cursor position
	lea edx, checksellstr				; ask player if they would like to sell fruit
	call writestring
	call readchar					; read player input
	cmp al, 'y'					; if it is y
	je sellfr						; jump to sellfr
	jmp stop7					; otherwise jump to stop7

	sellfr:						; allows the player to sell fruit
		mov dh, 14
		mov dl, 28
		call gotoxy				; set cursor position
		lea edx, sellfruitstr			; prompt player to enter the number of fruit 
		call writestring				; to sell
		call readdec				; read player input

		cmp al, fruitcounter			; compare number to the number of fruit
		jbe sellfruit				; if below or equal, jump to sell fruit
		mov dh, 15
		mov dl, 27
		call gotoxy				; set cursor position
		lea edx, toomanystr			; output string prompting the player to enter 
		call writestring				; a different number
		call crlf													; move to next line
		jmp sellfr				; jump back to sellfr

	sellfruit:					; decrements fruit and increments money
		sub fruitcounter, al			; subtract number entered from fruit counter
		mov ebx, 100
		mul ebx				; multiply number entered by 100 to get 
		mov dh, 14				; amount of money
		call gotoxy				; set cursor position
		call writedec				; output amount of money gained

		add money, eax			; add amount of money gained to current 
							; amount of money
	stop7:
	pop edx					; pop contents of the stack to edx
ret
displaybetweenday endp

;*****************************************************************
;* This procedure contains code relating to daily updates. *
;*****************************************************************

day proc
	mov al, movecount
	mov bl, movenum				; compare moves needed to advance day
	cmp al, bl					; with the number of moves already made
	jne stop2					; if not equal, jump to stop2

	call displaybetweenday			; otherwise, indicate that the day is over
	call clrscr					; clear the screen
	call createborder				; draw the border
	call drawch					; draw the character

	inc daycount					; increment day counter
	mov eax, daycount
	cmp eax, 14					; compare the number of days to 14
	je finishgame					; if equal, end the game
	add movenum, 25				; otherwise, increment the number of moves 
							; needed to advance the day
	cmp tree1[1], 3				; compare the age of tree1 to 3
	jne agetree1					; if not equal, age tree1
	je checktrees2					; otherwise, check age of tree2

	checktrees2:					; check the age of tree2
		cmp tree2[1], 3			; compare the age of tree2 to 3
		jne agetree2				; if not equal, age tree2
		je checktrees3				; otherwise, check age of tree3

	checktrees3:					; check the age of tree3
		cmp tree3[1], 3			; compare the age of tree3 to 3
		jne agetree3				; if not equal, age tree3
		je checktrees4				; otherwise, check age of tree4

	checktrees4:					; check the age of tree4
		cmp tree4[1], 3			; compare the age of tree4 to 3
		jne agetree4				; if not equal, age tree4
		je checktrees5				; otherwise, check age of tree5

	checktrees5:					; check the age of tree5
		cmp tree5[1], 3			; compare the age of tree5 to 3
		jne agetree5				; if not equal, age tree5
		je checktrees6				; otherwise, check age of tree6

	checktrees6:					; check the age of tree6
		cmp tree6[1], 3			; compare the age of tree6 to 3
		jne agetree6				; if not equal, age tree6
		je checktrees7				; otherwise, check age of tree7

	checktrees7:					; check the age of tree7
		cmp tree7[1], 3			; compare the age of tree7 to 3
		jne agetree7				; if not equal, age tree7
		je checktrees8				; otherwise, check age of tree8

	checktrees8:					; check the age of tree8
		cmp tree8[1], 3			; compare the age of tree8 to 3
		jne agetree8				; if not equal, age tree8
		je checktrees9				; otherwise, check age of tree9

	checktrees9:					; check the age of tree9
		cmp tree9[1], 3			; compare the age of tree9 to 3
		jne agetree9				; if not equal, age tree9
		je checktrees10			; otherwise, check age of tree10

	checktrees10:					; check the age of tree10
		cmp tree10[1], 3			; compare the age of tree10 to 3
		jne agetree10				; if not equal, age tree10
		je stop2				; otherwise, jump to stop2

	agetree1:					; age tree1
		inc tree1[0]				; increment type of tree1
		inc tree1[1]				; increment age of tree1
		jmp checktrees2			; check age of tree2

	agetree2:					; age tree2
		inc tree2[0]				; increment type of tree2
		inc tree2[1]				; increment age of tree2
		jmp checktrees3			; check age of tree3

	agetree3:					; age tree3
		inc tree3[0]				; increment type of tree3
		inc tree3[1]				; increment age of tree3
		jmp checktrees4			; check age of tree4

	agetree4:					; age tree4
		inc tree4[0]				; increment type of tree4
		inc tree4[1]				; increment age of tree4
		jmp checktrees5			; check age of tree5

	agetree5:					; age tree5
		inc tree5[0]				; increment type of tree5
		inc tree5[1]				; increment age of tree5
		jmp checktrees6			; check age of tree6

	agetree6:					; age tree6
		inc tree6[0]				; increment type of tree6
		inc tree6[1]				; increment age of tree6
		jmp checktrees7			; check age of tree7

	agetree7:					; age tree7
		inc tree7[0]				; increment type of tree7
		inc tree7[1]				; increment age of tree7
		jmp checktrees8			; check age of tree8

	agetree8:					; age tree8
		inc tree8[0]				; increment type of tree8
		inc tree8[1]				; increment age of tree8
		jmp checktrees9			; check age of tree9

	agetree9:					; age tree9
		inc tree9[0]				; increment type of tree9
		inc tree9[1]				; increment age of tree9
		jmp checktrees10			; check age of tree10

	agetree10:					; age tree10
		inc tree10[0]				; increment type of tree10
		inc tree10[1]				; increment age of tree10
		jmp stop2				; jump to stop2

	finishgame:
		call endthegame			; end the game

	stop2:
		call displayday				; output the current day number
		call drawtrees				; draw the aged trees
ret
day endp

;***********************************************************************
;* This procedure displays the controls used to play the game. *
;***********************************************************************

displaycontrols proc
	push edx					; push edx on the stack

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	mov dh, 1
	mov dl, 85
	call gotoxy					; set cursor position
	push edx					; push edx on the stack
	lea edx, movestr				; output controls used to move the character
	call writestring
	pop edx					; pop the contents of the stack to edx
	inc dh
	call gotoxy					; set cursor position
	push edx					; push edx on the stack
	lea edx, plant					; output control used to plant a tree
	call writestring
	pop edx					; pop the contents of the stack to edx
	inc dh						; move to the next row
	call gotoxy					; set the cursor position
	push edx					; push edx on the stack
	lea edx, harvest				; output control used to harvest fruit
	call writestring
	pop edx					; pop the contents of the stack to edx
	inc dh						; move to the next row
	call gotoxy					; set cursor position
	lea edx, endgame				; output control used to end the game
	call writestring

	pop edx					; pop the contents of the stack to edx
ret
displaycontrols endp

;******************************************************************
;* This procedure displays an X, which represents a hole. *
;******************************************************************

displayhole proc
	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	call gotoxy					; set cursor position
	mov al, 'X'
	call writechar					; output an X
ret
displayhole endp

;*************************************************************
;* This procedure displays the current amount of fruit. *
;*************************************************************

displayfruit proc
	push edx					; push edx on the stack

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	mov dh, 3
	mov dl, 2
	call gotoxy					; set cursor position
	lea edx, fruitstr				; output the word fruit
	call writestring
	mov al, fruitcounter
	call writedec					; output current number of fruit

	pop edx					; pop the contents of the stack to edx
ret
displayfruit endp

;************************************
;* This procedure plants a tree. *
;************************************

planttree proc
	push edx					; push edx on the stack

	inc treecount					; increment the number of trees
	mov al, treecount
	cmp al, 1					; compare the number of trees to 1
	je planttr1					; if equal, jump to planttr1
	cmp al, 2					; compare the number of trees to 2
	je planttr2					; if equal, jump to planttr2
	cmp al, 3					; compare the number of trees to 3
	je planttr3					; if equal, jump to planttr3
	cmp al, 4					; compare the number of trees to 4
	je planttr4					; if equal, jump to planttr4
	cmp al, 5					; compare the number of trees to 5
	je planttr5					; if equal, jump to planttr5
	cmp al, 6					; compare the number of trees to 6
	je planttr6					; if equal, jump to planttr6
	cmp al, 7					; compare the number of trees to 7
	je planttr7					; if equal, jump to planttrr7
	cmp al, 8					; compare the number of trees to 8
	je planttr8					; if equal, jump to planttr8
	cmp al, 9					; compare the number of trees to 9
	je planttr9					; if equal, jump to planttr9
	cmp al, 10					; compare the number of trees to 10
	je planttr10					; if equal, jump to planttr10
	jmp stop3					; otherwise, jump to stop3

	planttr1:					; plant tree1
		mov tree1[0], 0			; set type of tree1 to 0
		mov tree1[1], 0			; set age of tree1 to 0
		mov tree1[2], dh			; set row of tree1 to current value of dh
		mov tree1[3], dl			; set column of tree1 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr2:					; plant tree2
		mov tree2[0], 0			; set type of tree2 to 0
		mov tree2[1], 0			; set age of tree2 to 0
		mov tree2[2], dh			; set row of tree2 to current value of dh
		mov tree2[3], dl			; set column of tree2 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr3:					; plant tree3
		mov tree3[0], 0			; set type of tree3 to 0
		mov tree3[1], 0			; set age of tree3 to 0
		mov tree3[2], dh			; set row of tree3 to current value of dh
		mov tree3[3], dl			; set column of tree3 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr4:					; plant tree4
		mov tree4[0], 0			; set type of tree4 to 0
		mov tree4[1], 0			; set age of tree4 to 0
		mov tree4[2], dh			; set row of tree4 to current value of dh
		mov tree4[3], dl			; set column of tree4 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr5:					; plant tree5
		mov tree5[0], 0			; set type of tree5 to 0
		mov tree5[1], 0			; set age of tree5 to 0
		mov tree5[2], dh			; set row of tree5 to current value of dh
		mov tree5[3], dl			; set column of tree5 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr6:					; plant tree6
		mov tree6[0], 0			; set type of tree6 to 0
		mov tree6[1], 0			; set age of tree6 to 0
		mov tree6[2], dh			; set row of tree6 to current value of dh
		mov tree6[3], dl			; set column of tree6 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr7:					; plant tree7
		mov tree7[0], 0			; set type of tree7 to 0
		mov tree7[1], 0			; set age of tree7 to 0
		mov tree7[2], dh			; set row of tree7 to current value of dh
		mov tree7[3], dl			; set column of tree7 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr8:					; plant tree8
		mov tree8[0], 0			; set type of tree8 to 0
		mov tree8[1], 0			; set age of tree8 to 0
		mov tree8[2], dh			; set row of tree8 to current value of dh
		mov tree8[3], dl			; set column of tree8 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr9:					; plant tree9
		mov tree9[0], 0			; set type of tree9 to 0
		mov tree9[1], 0			; set age of tree9 to 0
		mov tree9[2], dh			; set row of tree9 to current value of dh
		mov tree9[3], dl			; set column of tree9 to current value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	planttr10:					; plant tree10
		mov tree10[0], 0			; set type of tree10 to 0
		mov tree10[1], 0											; set age of tree10 to 0
		mov tree10[2], dh			; set row of tree10 to current value of dh
		mov tree10[3], dl			; set column of tree10 to currrent value of dl
		call displayhole			; display an X
		jmp stop3				; jump to stop3

	stop3:
		pop edx				; pop the contents of the stack to edx
ret
planttree endp

;**********************************************************
;* This procedure allows the player to harvest fruit. *
;**********************************************************

harvestfruit proc
	push edx					; push edx on the stack
										
	mov dh, row2					; move the contents of row2 to dh
	mov dl, col2					; move the contents of col2 to dl
	checkltr1:
		cmp tree1[2], dh			; compare row of character to tree location
		je eloc11				; if equal, compare columns
		jne checkltr2				; otherwise, check the location of tree2

		eloc11:
			cmp tree1[3], dl		; compare col of character to tree location
			je eloc12			; if equal, harvest fruit
			jne checkltr2			; otherwise, check the location of tree2

			eloc12:
				add fruitcounter, 3	; increment the number of fruit by 3
				call displayfruit	; display the new number of fruit
				call drawbgtree	; redraw tree1 as a big tree
				dec tree1[0]		; change type of tree1 to big tree
				dec tree1[1]		; decrement age of tree1
				jmp stop6		; jump to stop6

	checkltr2:
		cmp tree2[2], dh			; compare row of character to tree location
		je eloc21				; if equal, compare columns 
		jne checkltr3				; otherwise, check the location of tree3

		eloc21:
			cmp tree2[3], dl		; compare col of character to tree location
			je eloc22			; if equal, harvest fruit
			jne checkltr3			; otherwise, check the location of tree3

			eloc22:
				add fruitcounter, 3	; increment the number of fruit by 3
				call displayfruit	; display the new number of fruit
				call drawbgtree	; redraw tree2 as a big tree
				dec tree2[0]		; change type of tree2 to big tree
				dec tree2[1]		; decrement age of tree2
				jmp stop6		; jump to stop6

	checkltr3:
		cmp tree3[2], dh			; compare row of character to tree location
		je eloc31				; if equal, compare columns
		jne checkltr4				; otherwise, check the location of tree4

		eloc31:
			cmp tree3[3], dl		; compare col of character to tree location
			je eloc32												; if equal, harvest fruit
			jne checkltr4			; otherwise, check the location of tree4

			eloc32:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display the new number of fruit
				call drawbgtree	; redraw tree3 as a big tree
				dec tree3[0]		; change type of tree3 to big tree
				dec tree3[1]		; decrement age of tree3
				jmp stop6		; jump to stop6

	checkltr4:
		cmp tree4[2], dh			; compare row of character to tree location
		je eloc41				; if equal, compare columns
		jne checkltr5				; otherwise, check the location of tree5

		eloc41:
			cmp tree4[3], dl		; compare col of character to tree location
			je eloc42			; if equal, harvest fruit
			jne checkltr5			; otherwise, check the location of tree5

			eloc42:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree4 as a big tree
				dec tree4[0]		; change type of tree4 to big tree
				dec tree4[1]		; decrement age of tree4
				jmp stop6		; jump to stop6

	checkltr5:
		cmp tree5[2], dh			; compare row of character to tree location
		je eloc51				; if equal, compare columns
		jne checkltr6				; otherwise, check the location of tree6

		eloc51:
			cmp tree5[3], dl		; compare col of character to tree location
			je eloc52			; if equal, harvest fruit
			jne checkltr6			; otherwise, check the location of tree6

			eloc52:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree5 as a big tree
				dec tree5[0]		; change type of tree5 to big tree
				dec tree5[1]		; decrement age of tree5
				jmp stop6		; jump to stop6

	checkltr6:
		cmp tree6[2], dh			; compare row of character to tree location
		je eloc61				; if equal, compare columns
		jne checkltr7				; otherwise, check the location of tree7

		eloc61:
			cmp tree6[3], dl		; compare col of character to tree location
			je eloc62			; if equal, harvest fruit
			jne checkltr7			; otherwise, check the location of tree7

			eloc62:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree6 as a big tree
				dec tree6[0]		; change type of tree6 to big tree
				dec tree6[1]		; decrement age of tree6
				jmp stop6		; jump to stop6

	checkltr7:
		cmp tree7[2], dh			; compare row of character to tree location
		je eloc71				; if equal, compare columns
		jne checkltr8				; otherwise, check the location of tree8

		eloc71:
			cmp tree7[3], dl		; compare col of character to tree location
			je eloc72			; if equal, harvest fruit
			jne checkltr8			; otherwise, check the location of tree8

			eloc72:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree8 as a big tree
				dec tree7[0]		; change type of tree8 to big tree
				dec tree7[1]		; decrement age of tree8
				jmp stop6		; jump to stop6

	checkltr8:
		cmp tree8[2], dh			; compare row of character to tree location
		je eloc81				; if equal, compare columns
		jne checkltr9				; otherwise, check the location of tree9

		eloc81:
			cmp tree8[3], dl		; compare col of character to tree location
			je eloc82			; if equal, harvest fruit
			jne checkltr9			; otherwise, check the location of tree9

			eloc82:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree8 as a big tree
				dec tree8[0]		; change type of tree8 to big tree
				dec tree8[1]		; decrement age of tree8
				jmp stop6		; jump to stop6

	checkltr9:
		cmp tree9[2], dh			; compare row of character to tree location
		je eloc91				; if equal, compare columns
		jne checkltr10				; otherwise, check the location of tree10

		eloc91:
			cmp tree9[3], dl		; compare col of character to tree location
			je eloc92			; if equal, harvest fruit
			jne checkltr10			; otherwise, check the location of tree10

			eloc92:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree9 as a big tree
				dec tree9[0]		; change type of tree9 to big tree
				dec tree9[1]		; decrement age of tree9
				jmp stop6		; jump to stop6

	checkltr10:
		cmp tree10[2], dh			; compare row of character to tree location
		je eloc101				; if equal, compare columns
		jne stop6				; otherwise, jump to stop6

		eloc101:
			cmp tree1[3], dl		; compare col of character to tree location
			je eloc102			; if equal, harvest fruit
			jne stop6			; otherwise, jump to stop6

			eloc102:
				add fruitcounter, 3	; increment number of fruit by 3
				call displayfruit	; display new number of fruit
				call drawbgtree	; redraw tree10 as a big tree
				dec tree10[0]		; change type of tree10 to big tree
				dec tree10[1]		; decrement age of tree10
				jmp stop6		; jump to stop6
	stop6:
		pop edx				; pop the contents of the stack to edx
ret
harvestfruit endp

;*********************************************
;* This procedure moves the character. *
;*********************************************

movech proc
	mov dh, row					; move the contents of row to dh
	mov dl, col					; move the contents of col to dl
	get_key:
		call readchar				; read player input
		cmp al, 'w'				; if it is w
		je move_up				; jump to move_up
		cmp al, 's'				; if it is s
		je move_down				; jump to move_down
		cmp al, 'a'				; if it is a
		je move_left				; jump to move_left
		cmp al, 'd'				; if it is d
		je move_right				; jump to move_right
		cmp al, 'p'				; if it is p
		je plantx				; jump to plantx
		cmp al, 'h'				; if it is h
		je harvestfr				; jump to harvestfr
		cmp al, 'q'				; if it is q
		je endtgame				; jump to endtgame
		jmp stop5				; otherwise, jump to stop5

		move_up:				; move the character up
			inc movecount			; increment move counter
			call clrscr			; clear the screen
			call createborder		; draw the border
			call drawtrees			; draw the current trees
			call displayday			; display the current day number
			call displaycontrols		; display the controls
			call displayfruit		; display the current number of fruit
			sub dh, 2			; subtract 2 from dh
			checkcursorposition		; ensure char isn't moving beyond area
			mov row2, dh			; save dh in row2
			mov col2, dl			; save dl in col2
			call gotoxy			; set cursor position
			call drawch			; draw the character
			call day			; check if the day should be incremented
			jmp get_key			; jump back to get_key

		move_down:				; move the character down
			inc movecount			; increment move counter
			call clrscr			; clear the screen
			call createborder		; draw the border
			call drawtrees			; draw the current trees
			call displayday			; display the current day number
			call displaycontrols		; display the controls
			call displayfruit		; display the current number of fruit
			add dh, 2			; add 2 to dh
			checkcursorposition		; ensure char isn't moving beyond the area
			mov row2, dh			; save dh in row2
			mov col2, dl			; save dl in col2
			call gotoxy			; set cursor position
			call drawch			; draw the character
			call day			; check if the day should be incremented
			jmp get_key			; jump back to get_key

		move_left:				; move the character to the left
			inc movecount			; increment move counter
			call clrscr												; clear the screen
			call createborder		; draw the border
			call drawtrees			; draw the current trees
			call displayday			; display the current day number
			call displaycontrols		; display the controls
			call displayfruit		; display the current number of fruit
			sub dl, 2			; subtract 2 from dl
			checkcursorposition		; ensure the char isn't moving beyond area
			mov row2, dh			; save dh in row2
			mov col2, dl			; save dl in col2
			call gotoxy			; set the cursor position
			call drawch			; draw the character
			call day			; check if the day should be incremented
			jmp get_key			; jump back to get_key

		move_right:				; move the character to the right
			inc movecount			; increment the move counter
			call clrscr			; clear the screen
			call createborder		; draw the border
			call drawtrees			; draw the current trees
			call displayday			; display the current day number
			call displaycontrols		; display the controls
			call displayfruit		; display the current number of fruit
			add dl, 2			; add 2 to dl
			checkcursorposition		; ensure the char isn't moving beyond area
			mov row2, dh			; save dh in row2
			mov col2, dl			; save dl in col2
			call gotoxy			; set cursor position
			call drawch			; draw the character
			call day			; check if the day should be incremented
			jmp get_key			; jump back to get_key

		plantx:
			call planttree			; plant a tree
			jmp get_key			; jump back to get_key

		harvestfr:
			call harvestfruit		; harvest fruit
			jmp get_key			; jump back to get_key

		endtgame:
			call endthegame		; end the game

	stop5:
ret
movech endp

;*****************************************************************
;* This procedure displays a screen after the game ends. *
;*****************************************************************

endthegame proc
	call createborder				; draw the border
	
	mov eax, red + (16 * red)			; set text color to red and background color 
	call settextcolor				; to red

	mov al, '*'
	mov dh, 5					; output the letter F
	mov dl, 17
	call gotoxy					; set cursor position
	
	mov ecx, 5
	drawstars					; output 5 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 4
	drawstars					; output 4 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov dh, 5					; output the letter R
	mov dl, 25
	call gotoxy					; set cursor position
	mov ecx, 7
	drawstars					; output 7 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	call writechar					; output asterisk
	mov dl, 31
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	inc dh						; move to next row
	mov dl, 25
	call gotoxy					; set cursor position
	mov ecx, 7
	drawstars					; output 7 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 3
	call gotoxy					; set cursor position
	call writechar					; output asterisks

	inc dh						; move to next row
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 4
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	inc dh						; move to next row
	sub dl, 4
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 5
	call gotoxy					; set cursor position
	call writechar					; output asterisk

	mov dh, 5					; output the letter U
	mov dl, 36
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 6
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 5
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	add dl, 4
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 4
	drawstars					; output 4 asterisks

	mov dh, 5					; output the letter I
	mov dl, 48
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	inc dh						; move to next row
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 3
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	mov dh, 5					; output the letter T
	mov dl, 60
	call gotoxy					; set cursor position
	mov ecx, 8
	drawstars					; output 8 asterisks

	inc dh						; move to next row
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	mov dh, 5					; output the letter S
	mov dl, 73
	call gotoxy					; set cursor position
	mov ecx, 6
	drawstars					; output 6 asterisks

	inc dh						; move to next row
	dec dl
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	add dl, 3
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 2
	call gotoxy					; set cursor position
	mov ecx, 2
	drawstars					; output 2 asterisks

	inc dh						; move to next row
	sub dl, 4
	call gotoxy					; set cursor position
	mov ecx, 5
	drawstars					; output 5 asterisks

	mov eax, black + (16 * brown)		; set text color to black and background 
	call settextcolor				; color to brown
	mov dh, 14
	mov dl, 38
	call gotoxy					; set cursor position
	lea edx, thanksstr				; output a message to thank the player for
 	call writestring					; playing


	mov ebx, 1					; use ebx as a counter

	mov dh, 18
	mov dl, 10
	call gotoxy					; set cursor position

	drawhgtree2:					; draw a huge tree
		sub ebx, 1				; decrement counter
		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown

		mov ecx, 2
		drawstars				; output two asterisks

		inc dh
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 6
		drawstars				; output 6 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 8
		drawstars				; output 8 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 10
		drawstars				; output 10 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 12
		drawstars				; output 12 asterisks

		inc dh					; move to next row
		inc dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 3
		drawstars				; output 3 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		inc dh					; move to next row
		add dl, 4
		call gotoxy				; set cursor position
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

	mov dh, 18
	add dl, 20
	call gotoxy					; set cursor position

	drawhfrtree2:					; draw huge fruit tree
		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown

		mov ecx, 2
		drawstars				; output two asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 1
		drawstars				; output asterisk

		mov eax, lightred + (16 * brown)	; set text color to light red and background 	
	call settextcolor			; color to brown

		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 6
		drawstars				; output 6 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 8
		drawstars				; output 8 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 2
		drawstars				; output 2 asterisks

		mov eax, lightred + (16 * brown)	; set text color to light red and background 
		call settextcolor			; color to brown
		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, lightred + (16 * brown)	; set text color to light red and background 
		call settextcolor			; color to brown
		mov al, 'O'				; output fruit
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 2
		drawstars				; output 2 asterisks

		inc dh					; move to next row
		dec dl
		call gotoxy				; set cursor position
		mov ecx, 12
		drawstars				; output 12 asterisks

		inc dh					; move to next row
		inc dl
		call gotoxy				; set cursor position
		mov ecx, 4
		drawstars				; output 4 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar

		mov al, '|'				; output right side of trunk
		call writechar

		mov eax, green + (16 * brown)	; set text color to green and background 
		call settextcolor			; color to brown
		mov ecx, 3
		drawstars				; output 3 asterisks

		mov eax, black + (16 * brown)	; set text color to black and background 
		call settextcolor			; color to brown
		inc dh					; move to next row
		add dl, 4
		call gotoxy				; set cursor position
		mov al, '|'				; output left side of trunk
		call writechar

		mov al, ' '				; output space
		call writechar
		
		mov al, '|'				; output right side of trunk
		call writechar

		mov dh, 18
		mov dl, 50
		call gotoxy				; set cursor position
		cmp ebx, 0				; if ebx is 0
		je drawhgtree2			; jump to drawhgtree2

	mov eax, 2000
	call delay					; call delay so screen displays for a while
	call clrscr					; clear the screen
ret
endthegame endp
end main


