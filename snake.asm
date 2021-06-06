[org 0x0100]

jmp start

;defining the variables required

fruitpos: dw 0
dangerousFruit: dw 0
fruitArray: dw 0x0dea, 0x0704, 0x0905, 0x0a06, 0x0b0D, 0x0d0F, 0x02e5
fruit: dw 0x002A
score: dw 0
oldTimerIsr: dd 0
oldKbisr: dd 0
ticks: dw 0
size: dw 20
game_over_flag: db 0
lives: dw 3
direction: db 'r'			;moves in the right direction by default
snake: times 240 dw -1
speed: dw 6
finish: db 'GAME OVER! YOU LOSE!'
won: db 'CONGRATULATIONS! YOU WIN!'
scorestr: db 'Score:'
tlivesstr: db '   Total Lives : '
rlivesstr: db 'Remaining Lives: '
levelstr: db 'Level: '
sizestr: db 'Size: '
tickcount: dw 0
min: dw 	4
sec: dw 	0
level:	dw  0
lvl2:	dw 0
lvl3:	dw 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;display

a0: db 0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a1: db 0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a2: db 0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20
a3: db 0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20
a4: db 0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a5: db 0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a6: db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20
a7: db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20
a8: db 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a9: db 0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0xb2,0xb2,0xb2,0x20,0x20,0x20,0x20,0xb2,0xb2,0x20,0x20,0x20,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2,0xb2
a10: db 'Press any key to continue. . .'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
level2:
pusha
mov ax, 0xb800
mov es, ax 		

mov di,1440
mov cx,10
mov dx,3

hurdles: 				;creating hurdles for the second level
	mov si,di
j:	add si,32

	mov ax,[cs:fruitpos]
	cmp si,ax
	je newfruit

cont:mov word[es:si],0x0fdb
	dec dx
	cmp dx,0
	jge j
	mov dx,3
	add di,160
	loop hurdles
	
	popa
	ret	

newfruit: mov word[es:si],0x0020
		call fruitGeneration
		jmp cont

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

level3:
pusha 
mov ax, 0xb800
mov es, ax 		

mov di,1600
mov si,1758
mov cx,20

k1:	sub si,2
	add di,2
	
	mov ax,[cs:fruitpos]
	cmp si,ax
	je newfruit
	cmp di,ax
	je newfruit
		
	mov word[es:di],0x0fdc
	mov word[es:si],0x0fdc
	loop k1
	
mov di,2560
mov si,2718
mov cx,20

k2:	sub si,2
	add di,2
	
	mov ax,[cs:fruitpos]
	cmp si,ax
	je newfruit
	cmp di,ax
	je newfruit
	
	mov word[es:di],0x0fdc
	mov word[es:si],0x0fdc
	loop k2
	
mov di,380
mov si,420
mov cx,6

k3:	add si,160
	add di,160
	
	mov ax,[cs:fruitpos]
	cmp si,ax
	je newfruit
	cmp di,ax
	je newfruit
	
	mov word[es:di],0x0fdB
	mov word[es:si],0x0fdB
	loop k3
	
mov di,3740
mov si,3780
mov cx,6

k4:	mov ax,[cs:fruitpos]
	cmp si,ax
	je newfruit
	cmp di,ax
	je newfruit
	
	mov word[es:di],0x0fdB
	mov word[es:si],0x0fdB
	sub si,160
	sub di,160
	loop k4

popa	
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;initializing the required level based on snake size
;and time remaining

_level:	
	cmp word[level], 1
	je checkLevel1
	cmp word[lvl2], 1
	je checkLevel2
	cmp word[lvl3], 1
	je checkLevel3


checkLevel1:				;if the size is greater than 240 in the first level, we need to initialize the second level
	cmp word[cs:size], 240
	jge cmp1
	jmp checkTime
	
checkLevel2:
	cmp word[cs:size], 140		;if the size is greater than 140 in the second level, we start the third one
	jge cmp2
	jmp checkTime
	
checkLevel3:
	cmp word[cs:size], 100		;the game is won if the size surpasses 100 in the third level
	jge intermediate

checkTime:
	cmp word[cs:min], 0		;if the time ends and the size is lesser than required, a life is decreased
	jne samelevel
	cmp word[cs:sec], 0
	je cmp1
	
		
samelevel: ret

cmp1:		cmp word[cs:size],240
		jl cmp2
		mov word[cs:speed], 9
		mov word[cs:size], 20
		add word[cs:score],50
		mov word[cs:min],4
		mov word[cs:sec],0
		mov word[cs:lvl2],1
		inc word[cs:level]
		push 2031
		call beep_long
		call clearScreen
		call createSnake
		ret

intermediate:	jmp cmp3
		
cmp2:		cmp word[cs:lvl2], 1
		jne decreaseLife
		
		cmp word[cs:size],140
		jl cmp3
		mov word[cs:speed],9
		mov word[cs:size], 20
		add word[cs:score],100
		mov word[cs:min],4
		mov word[cs:sec],0
		mov word[cs:lvl3],1
		mov word[cs:lvl2],0
		inc word[cs:level]
		push 2031
		call beep_long
		call clearScreen
		call createSnake
		ret

cmp3:		cmp word[cs:lvl3],1
		jne decreaseLife
		
		cmp word[cs:size],100
		jl samelevel
		call gameWon
		ret

decreaseLife:
push word 9121
call beep_long
mov byte[direction], 'r'
sub word[lives], 1
mov word[sec],0
mov word[min],4
mov word[speed], 18

call clearScreen
call createSnake
ret
		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
clearScreen:
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax 		
	xor di, di 		
	mov ax, 0x0020 		;black background		
	mov cx, 2000 		
	cld 			
	rep stosw 	

	call borders
	
	pop di
	pop cx
	pop ax
	pop es
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alarm: 
push bp
mov bp,sp

mov     dx,2000         	 ; Number of times to repeat whole routine.
mov     bx,1             		; Frequency value.
mov     al, 10110110b    	; The Magic Number (use this binary number only)
out     43h, al         		 ; Send it to the initializing port 43h Timer 2.

next:          		 ; This is were we will jump back to 2000 times.
mov     ax, bx          		 ; Move our Frequency value into ax.
out     42h, al         		 ; Send LSb to port 42h.
mov     al, ah           		; Move MSb into al 
out     42h, al          		; Send MSb to port 42h.

in      al, 61h          		; Get current value of port 61h.
OR      al, 00000011b    	; OR al to this value, forcing first two bits high.
out     61h, al          		; copy it to port 61h of the PPI chip

                         		; to turn ON the speaker.
mov     cx, 2000           	; Repeat loop 20 times
delay:             		 ; here is where we loop back too.
loop    delay      		 ; Jump repeatedly to delay until cx = 0
inc     bx               		; Incrementing the value of bx lowers
                         		; the frequency each time we repeat the
                        		 ; whole routine
dec     dx              		 ; decrement repeat routine count
cmp     dx, 0           		 ; Is dx (repeat count) = to 0

jnz     next  		 ; If not jump to next
                         		; and do whole routine again.
                        		 ; else dx = 0 time to turn speaker OFF
in      al,61h          		 ; Get current value of port 61h.
and     al,11111100b    	 ; and al to this value, forcing first two bits low.
out     61h,al          		 ; copy it to port 61h of the PPI chip
pop bp
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
beep: 
push bp
mov bp,sp
push ax
push bx
push cx

mov     al, 182        			 ; Prepare the speaker for the
        out     43h, al         		 ;  note.
        mov     ax, [bp+4]        		 ; Frequency number (in decimal)
                                		;  for middle C.
        out     42h, al         		; Output low byte.
        mov     al, ah          		; Output high byte.
        out     42h, al 
        in      al, 61h         		; Turn on note (get value from
                                		;  port 61h).
        or      al, 00000011b   		; Set bits 1 and 0.
        out     61h, al         		; Send new value.
        mov     bx, 15          		; Pause for duration of note.
pause1:
        mov     cx, 0xfff
pause2:
        dec     cx
        jne     pause2
        dec     bx
        jne     pause1
        in      al, 61h         		; Turn off note (get value from
                                		;  port 61h).
        and     al, 11111100b  		; Reset bits 1 and 0.
        out     61h, al         		; Send new value.


pop cx
pop bx
pop ax
pop bp
ret 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

beep_long: 
push bp
mov bp,sp
push ax
push bx
push cx

mov     al, 182        			 ; Prepare the speaker for the
        out     43h, al         		 ;  note.
        mov     ax, [bp+4]        		 ; Frequency number (in decimal)
                                		;  for middle C.
        out     42h, al         		; Output low byte.
        mov     al, ah          		; Output high byte.
        out     42h, al 
        in      al, 61h         		; Turn on note (get value from
                                		;  port 61h).
        or      al, 00000011b   		; Set bits 1 and 0.
        out     61h, al         		; Send new value.
        mov     bx, 15          		; Pause for duration of note.
_pause1:
        mov     cx, 0xffff
_pause2:
        dec     cx
        jne     _pause2
        dec     bx
        jne     _pause1
        in      al, 61h         		; Turn off note (get value from
                                		;  port 61h).
        and     al, 11111100b  		; Reset bits 1 and 0.
        out     61h, al         		; Send new value.


pop cx
pop bx
pop ax
pop bp
ret 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

printnum:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx


mov ax, 0xb800
mov es, ax
mov ax, [bp+4]
mov bx, 10
mov cx, [bp+6]

nextdigit:		mov dx, 0
		div bx
		add dl, 0x30
		push dx
		loop nextdigit


mov cx, [bp+6]				;count of digits passed as parameter
nextpos:		pop dx
		mov dh, 0x0f
		mov [es:di], dx
		add di, 2
		loop nextpos



pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 4


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

borders:
	push bx
	push cx
	push dx
	push es
	push ax
	push si
	push di
	push bp
	mov ax, 0xb800
	mov es, ax
	mov si, 320
	mov di, 478

drawVerticalSides:
		mov ah, 0x0f
		mov al, 176
		mov word[es:si], ax
		mov word[es:di], ax
		add si, 160
		add di, 160
		cmp di, 3998
		jle drawVerticalSides


mov si, 320
mov di, 3840

drawHorizontal:
		mov ah, 0x0f
		mov al, 176
		mov word[es:si], ax		
		mov word[es:di], ax		
		add si, 2
		add di, 2
		cmp si, 480
		jne drawHorizontal



;printing the score, size, lives etc
		
mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0023
mov cx, 6
push cs
pop es
mov bp, sizestr
int 0x10
push 3
push word[size]
mov di, 82
call printnum

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0000
mov cx, 7
push cs
pop es
mov bp, scorestr
int 0x10
push 4
push word[score]
mov di, 12
call printnum

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0100
mov cx, 7
push cs
pop es
mov bp, levelstr
int 0x10
push 1
mov di, 176
push word[level]
call printnum

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0039
mov cx, 17
push cs
pop es
mov bp, tlivesstr
int 0x10

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0139
mov cx, 17
push cs
pop es
mov bp, rlivesstr
int 0x10

mov ax, 0xb800
mov es, ax

mov cx,3
mov si, 148
l0:	mov word[es:si], 0x0f03
	add si, 2
	mov word[es:si], 0x0f20
	add si, 2
	loop l0

cmp word[lives], 0
mov cx, [lives]
je return
cmp word[lives], -1
je return
mov si, 308
l2:	mov word[es:si], 0x0f03
	add si, 2
	mov word[es:si], 0x0f20
	add si, 2
	loop l2

	return:
	pop bp
	pop di
	pop si
	pop ax
	pop es
	pop dx
	pop cx
	pop bx
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
displaySnake:			;for printing the snake 
push ax
push si
push di
push cx
push es

mov cx, [size]
sub cx, 1

mov ax, 0xb800
mov es, ax
mov di, 0
mov si, [snake+di]	
mov ah, 0x0c
mov al, 176					;printing head out of the loop since it has a different character
mov word[es:si], ax
add di, 2
mov ah, 0x0c
display:					;printing the rest of the snake in a loop
	mov si, [snake+di]
	mov al, 219
	mov word[es:si], ax
	add di, 2
	loop display

mov di, [fruitpos]			;printing the fruit
mov cx, [fruit]
mov word[es:di], cx

pop es
pop cx
pop di
pop si
pop ax
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
randomNumberGenerator:
	
;to calculate the position of fruits

push bp
mov bp, sp
push ax
push dx
push bx
push es
push di

mov ax, 0xb800
mov es, ax

mov al, 00
out 0x70, al
in al, 0x71		;get current seconds

mov ah, 0
shl ax, 9

mov bx, 3680		;multiply current seconds with 3680
div bx

mov di, dx
add di, 320		;add 320 to skip the first two lines

mov ax, 0x01		;checking whether the number is even, since we can only display on even coordinates, due to the attribute byte
test di, ax
jz isEven
add di, 1

isEven:
	mov [bp+4], di

pop di
pop es
pop bx
pop dx
pop ax
pop bp
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fruitGeneration:
push di
push es
push ax
push si
push cx


push 0
call randomNumberGenerator
pop di				;the position is now in di

mov si, 0
mov cx, [size]

mov ax, 0xb800
mov es, ax

check:
cmp word[es:di], 0x0020		;if there is anything other than space on video memory, we need 
				;another location
				;since we do not want to print the fruit on the hurdles etc
je printFruit

getAnotherNumber:
push 0
call randomNumberGenerator
pop di

jmp check			;if another number was generated, check all the conditions again

printFruit:
mov al, 00
out 0x70, al
in al, 0x71
mov ah, 0
mov bl, 7
div bl			;now ah contains seconds%7
shr ax, 8
mov si, ax		;choosing one of the fruits from the fruits array
shl si, 1
mov cx, [fruitArray+si]
mov [fruit], cx
		
mov [fruitpos], di
mov word[es:di], cx

pop cx
pop si
pop ax
pop es
pop di
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
generateDangerousFruit:
pusha

push 0
call randomNumberGenerator
pop di

mov ax, 0xb800
mov es, ax

check2:
cmp word[es:di], 0x0020		;if there is anything other than space on video memory, we need 
				;another location
				;since we do not want to print the fruit on the hurdles etc
je printFruit2

getAnotherNumber2:
push 0
call randomNumberGenerator
pop di
jmp check2

printFruit2:
mov [dangerousFruit], di
mov si, di

mov word[es:si], 0xC099


popa 
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

increaseSize: 
push ax
push bx
push si
push di
push cx

call fruitGeneration
mov di, [size]
shl di, 1
sub di, 2			;last index
mov si, di
sub si, 2			;second last index

mov ax, [snake+di]		;last element
mov bx, [snake+si]
sub bx, ax		;difference 

add word[size], 4
cmp word[size], 240
jge maxSize

add di, 2
mov [snake+di], ax
add [snake+di], bx

mov cx, 3

l3: mov ax, [snake+di]
add di, 2
mov [snake+di], ax
add [snake+di], bx
loop l3

jmp continue

maxSize:	call _level

continue:
pop cx
pop di
pop si
pop bx
pop ax

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gameWon:
push ax
push bx
push cx
push dx
push bp

call alarm

xor ax, ax				;unhooking our interrupts
mov es, ax
mov ax, [oldKbisr]
mov [es:9*4], ax
mov ax, [oldKbisr+2]
mov [es:9*4+2], ax
mov ax, [oldTimerIsr]
mov [es:8*4], ax
mov ax, [oldTimerIsr+2]
mov [es:8*4+2], ax

call clearScreen

mov ah, 0x13			;printing winning message using bios service
mov al, 0
mov bh, 0
mov bl, 0x4f
mov dx, 0x0F28
mov cx, 25
push cs
pop es
mov bp, won
int 0x10



pop bp
pop dx
pop cx
pop bx
pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


move:			;for moving the snake
push ax
push di
push si
push es
push cx
push bx

cmp word[lvl2],1
jne nxtcmp
call level2
nxtcmp:
cmp word[lvl3],1
jne ignore
call level3

ignore:
mov ax, 0xb800
mov es,ax

mov ax, [fruitpos]
;conditions to check whether the head of the snake hits some wall or itself
		;conditions for when the snake is moving right

mov si, [snake]

cmp byte[direction], 'r'
jne _left
add si, 2
jmp checkFruit
_left:
	cmp byte[direction], 'l'
	jne _up
	sub si, 2
	jmp checkFruit

_up:
	cmp byte[direction], 'u'
	jne _down
	sub si, 160
	jmp checkFruit

_down:
	cmp byte[direction], 'd'
	add si, 160

checkFruit:

cmp si, [dangerousFruit]
jne checkHit
push word 9121
call beep_long
mov word[dangerousFruit], -1
cmp word[score], 0
je checkHit
sub word[score], 5


checkHit:
cmp word[es:si], 0x0fcd
je intermediateHit
cmp word[es:si], 0x0fdc
je intermediateHit
cmp word[es:si], 0x0fdb
je intermediateHit
cmp word[es:si], 0x0fb0
je intermediateHit
cmp word[es:si], 0x0fba
je intermediateHit
cmp si, ax
je fruitFound
jmp skip

fruitFound:
add word[score], 10
call displaySnake
push word 1207
call beep
call increaseSize 

skip:
mov di, [size]
shl di, 1
sub di, 2			;last index of snake

shift:	
	mov ax, [snake+di-2]	;shifting the snake, except the head, to the place of the character before it, i.e the last is moved to the place of the second last and so on
	mov [snake+di], ax
	sub di, 2
	cmp di, 0
	jne shift

	;now changing the position of the head
	cmp byte[direction], 'r'
	jne left
right:	add word[snake+di], 2
	jmp moved

intermediateHit: jmp hit

left: 	cmp byte[direction], 'l'
	jne up
	sub word[snake+di], 2
	jmp moved

up:	cmp byte[direction], 'u'
	jne down
	sub word[snake+di], 160
	jmp moved

down:	add word[snake+di], 160
	jmp moved

hit:
push word 9121
call beep_long
mov byte[direction], 'r'
sub word[lives], 1
mov word[sec],0
mov word[min],4
mov word[speed], 18
call clearScreen
call createSnake
cmp word[lives], -1
je callGameOver
jmp endMove

callGameOver:	call gameOver
		jmp endMove

moved:
mov ax, [snake]
mov di, 2
mov cx, [size]
sub cx, 1

compare: 	cmp ax, [snake+di]
		je hit
		add di, 2
		loop compare


endMove:
	pop bx
	pop cx
	pop es
	pop si
	pop di
	pop ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


gameOver:
push ax
push bx
push cx
push dx
push bp
push es
push ds

push cs
pop ds

call alarm
mov byte[game_over_flag], 1

xor ax, ax
mov es, ax
mov ax, [oldKbisr]
mov [es:9*4], ax
mov ax, [oldKbisr+2]
mov [es:9*4+2], ax
mov ax, [oldTimerIsr]
mov [es:8*4], ax
mov ax, [oldTimerIsr+2]
mov [es:8*4+2], ax

call clearScreen

mov ah, 0x13		;printing game over on screen using bios service of printing string
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0C1e
mov cx, 20
push cs
pop es
mov bp, finish
int 0x10


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0D23
mov cx, 6
push cs
pop es
mov bp, scorestr
int 0x10
push 4
mov di, 2164
push word[score]
call printnum


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x0E23
mov cx, 7
push cs
pop es
mov bp, levelstr
int 0x10
mov di, 2324
push 1
push word[level]
call printnum


pop ds
pop es
pop bp
pop dx
pop cx
pop bx
pop ax
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

timer:
push ax
push bx
push cx
push dx
push si
push di
push es

push cs
pop ds

call _level

mov ax, 0xb800
mov es, ax

cmp word[sec], 50
jg zero
cmp word[sec], 10
jl zero

cmp word[dangerousFruit], 0
jne noFruit

call generateDangerousFruit

noFruit:
mov si, [dangerousFruit]

mov word[es:si], 0xC099
jmp sem

zero:
	mov si, [dangerousFruit]
	cmp si, 0
	jz sem
	mov word[es:si], 0x0020
	mov word[dangerousFruit], 0

sem:
add word[ticks], 1
mov ax, [ticks]
mov dx, 0
mov bx, [speed]
div bx
cmp dx, 0
jne end

mov dx, 0
mov ax, [ticks]
mov bx, 360
div bx
cmp dx, 0
jne noIncrease

mov word[ticks], 0
mov ax, [speed]
mov bl, 2
div bl
cmp al, 0
je noIncrease
mov ah, 0
mov [speed], al


noIncrease:

;call clearScreen
mov ax, 0xb800
mov es, ax
mov si, snake
mov cx, [size]
shl cx, 1
sub cx, 2
add si, cx
mov di, [si]
mov word[es:di], 0x0020
call borders
call move

cmp byte[game_over_flag], 1
je end
call displaySnake


end:
call _timer
pop es
pop di
pop si
pop dx
pop cx
pop bx
pop ax

mov al, 0x20
out 0x20, al
iret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

kbisr:
push ax

in al, 0x60

cmp al, 0x4b
jne r
mov byte[cs:direction], 'l'
jmp terminate
r:	cmp al, 0x4D
	jne u
	mov byte[cs:direction], 'r'
	jmp terminate

u:	cmp al, 0x48
	jne d
	mov byte[cs:direction], 'u'
	jmp terminate

d:	cmp al, 0x50
	jne terminate
	mov byte[cs:direction], 'd'


terminate:
pop ax
mov al, 0x20
out 0x20, al
iret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

createSnake:					;this is called when the snake is being created at the start of the game, and also every time it loses a life
	push ax
	push bx
	push cx
	push si
	push di
	push es

	call clearScreen
	mov si, 2000				;start from the centre of the screen
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	mov byte[direction], 'r'
	mov word[snake+di], 2000
	mov cx, [size]
	sub cx, 1			;because head displayd separately

	
	cmp cx, 35  			;if the size is greater than 40, we display the first 40 characters in one line and the rest on the next line
	jle l1
	jg larger
	
l1:	sub si, 2
	add di, 2
	mov [snake+di], si
	loop l1
	jmp endCreate

larger:
mov cx, 35

l5:	sub si, 2
	add di, 2
	mov [snake+di], si
	loop l5

add si, 160
mov cx, [size]
sub cx, 36
cmp cx, 70
mov bx, cx
jg evenLarger

l6:	add di, 2
	mov [snake+di], si
	add si, 2
	loop l6
	jmp endCreate

evenLarger:
mov cx, 70

l7:	add di, 2
	mov [snake+di], si
	add si, 2
	loop l7

mov cx, bx
sub cx, 70
add si, 160

l8:
	add di, 2
	mov [snake+di], si
	sub si, 2
	loop l8


endCreate:
pop es
pop di
pop si
pop cx
pop bx
pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_timer:     push bp
	mov bp,sp
	push ax
	push bx
	
s:	inc word [cs:tickcount]; increment tick count
	
l:	mov ax,[cs:tickcount]
	mov bl,18
	div bl
	cmp ah,0
	jne p

	dec word [cs:sec]
	cmp word[cs:sec], 0	
	jl time
a:	cmp word[cs:min], 0	
	jl reset

p:	mov di, 242
	push 2
 	push word [cs:sec]
 	call printnum 
	mov di, 234
	push 2
	push word [cs:min]
 	call printnum 
	mov word[es:238], 0x0f3A
	

exit_: 		
		pop bx
		pop ax
		pop bp
		ret
	
time:   		dec word[cs:min]
		mov word [cs:tickcount],0
		mov word[cs:sec], 59
		jmp a

reset:	add word[cs:score],150
	
	mov word[cs:tickcount],0
	mov word[cs:min],4
	mov word[cs:sec], 0
	dec word [cs:lives]
	push word 9121
	call beep_long
	
	jmp exit_

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

startPage:
pusha

call clearScreen
mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0a
mov dx, 0x050A
mov cx, 60
push cs
pop es
mov bp, a0
int 0x10

push 8100
call beep_long



mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0b
mov dx, 0x060A
mov cx, 60
push cs
pop es
mov bp, a1
int 0x10

push 7500
call beep_long



mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0c
mov dx, 0x070A
mov cx, 60
push cs
pop es
mov bp, a2
int 0x10

push 6800
call beep_long


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0d
mov dx, 0x080A
mov cx, 60
push cs
pop es
mov bp, a3
int 0x10

push 6000
call beep_long



mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x090A
mov cx, 60
push cs
pop es
mov bp, a4
int 0x10

push 5400
call beep_long


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0e
mov dx, 0x0A0A
mov cx, 60
push cs
pop es
mov bp, a5
int 0x10

push 4500
call beep_long

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x05
mov dx, 0x0B0A
mov cx, 60
push cs
pop es
mov bp, a6
int 0x10

push 4100
call beep_long


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x01
mov dx, 0x0C0A
mov cx, 60
push cs
pop es
mov bp, a7
int 0x10

push 3200
call beep_long

mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x02
mov dx, 0x0D0A
mov cx, 60
push cs
pop es
mov bp, a8
int 0x10

push 2100
call beep_long


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x03
mov dx, 0x0E0A
mov cx, 60
push cs
pop es
mov bp, a9
int 0x10

push 1100
call beep_long


mov ah, 0x13
mov al, 0
mov bh, 0
mov bl, 0x0f
mov dx, 0x1219
mov cx, 30
push cs
pop es
mov bp, a10
int 0x10

popa
ret	

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:	
	call startPage
	
	xor ah, ah
	int 0x16

	call createSnake
	call fruitGeneration

	xor ax, ax
	mov es, ax
	mov ax, [es:8*4]
	mov [oldTimerIsr], ax
	mov ax, [es:8*4+2]
	mov [oldTimerIsr+2], ax

	mov ax, [es:9*4]
	mov [oldKbisr], ax
	mov ax, [es:9*4+2]
	mov [oldKbisr+2], ax
	
	cli
	mov word[es:8*4], timer
	mov [es:8*4+2], cs
	mov word[es:9*4], kbisr
	mov [es:9*4+2], cs
	sti

;creating TSR
mov dx, start
add dx, 15
mov cl, 4
shr dx, cl
mov ax, 0x3100
int 21h