
INCLUDE Irvine32.inc
INCLUDE macros.inc 
BUFFER_SIZE = 5000
;----------------------------------------------------------
.data

buffer BYTE BUFFER_SIZE DUP(?)		;Array That Will have Soduku Elements From File
solvedarr byte BUFFER_SIZE dup(?)	;Array That Will Have Solved Soduku Elements From File 
row byte  ?							;Row It is  Row Cell From Soduku
col byte ?							;Column It is  Column Cell From Soduku
val byte ?							;Will Save The User InPut To It
diff byte ?							;Save In IT The DiffiCulty
rand byte ?							;Save The Random File Number 
cell byte ?							;Do An Equation With Row And Col And Catch The Cell  
rd byte 4							;But The Color Red
blu byte 1							;But The Color Blue
whit byte 15						;But The Color White
gren byte 10						;But The Color Green
clr byte 0
zer byte 0
righttrials byte 0					; Number OF Correctly Played In Soduku
wrongtrials byte 0					; Number OF InCorrectly Played In Soduku

file11 BYTE "diff_1_1.txt",0				;----------------------------
file11s BYTE "diff_1_1_solved.txt",0		;|
file12 BYTE "diff_1_2.txt",0				;|
file12s BYTE "diff_1_2_solved.txt",0		;|
file13 BYTE "diff_1_3.txt",0				;|
file13s BYTE "diff_1_3_solved.txt",0		;|
file21 BYTE "diff_2_1.txt",0				;|
file21s BYTE "diff_2_1_solved.txt",0		;|
file22 BYTE "diff_2_2.txt",0				;|=>Files Solved And UnSolved Soduku To Read It In Console 
file22s BYTE "diff_2_2_solved.txt",0		;|
file23 BYTE "diff_2_3.txt",0				;|
file23s BYTE "diff_2_3_solved.txt",0		;|
file31 BYTE "diff_3_1.txt",0				;|
file31s BYTE "diff_3_1_solved.txt",0		;|
file32 BYTE "diff_3_2.txt",0				;|
file32s BYTE "diff_3_2_solved.txt",0		;|
file33 BYTE "diff_3_3.txt",0				;|
file33s BYTE "diff_3_3_solved.txt",0		;------------------------------
fileOut BYTE "lastgame.txt",0
fileOutsolved BYTE "lastgamesolved.txt",0


filename    BYTE 80 DUP(0) 
fileHandle  HANDLE ?
;-----------------------------------------------------
.code	
main proc
;----------------------------------------------
;Here iam Using Mwrite by USing macros.inc Lib
;And iam Telling The user To Pree [1] If He Want To start New Game
;To Pree [2] If He Want To Continue Previous Game 
;----------------------------------------------
mWrite " [1] to start new game "
	call crlf
mWrite " [2] to continue previous game "
	call crlf									;New Line
	call readdec								;Take From User Input To Know What He Want,Save In Eax 
cmp eax, 1										;Compare eax And 1  
	je choose									;IF Eax Equal 1 So Go To The Choose Label
cmp eax , 2										;Compare eax And 1  
;-----------------------------------------------
;In Choose Label We want Form User The Choose The Diffculty That HE Wnat
;-----------------------------------------------

choose:
mWrite "choose difficulty from 1 , 2 or 3 or 0 to exit : "
	call readdec				;Read From The User The Diffculty That He Enterd
	call clrscr
	push eax					;Use Stack Ane Push The Eax Value In Stack To Catch The diffculty File
	mov diff,al					;----------------------------------
cmp eax ,1						;Compare The Diffculty  and 1 value
	je easy						; IF It Equal Go To Easy Level
								;----------------------------------
cmp eax , 2						;Compare The Diffculty  and 2 value
	je medium					; IF It Equal Go To medium Level
								;----------------------------------
cmp eax , 3						;Compare The Diffculty  and 2 value
	je hard						; IF It Equal Go To medium Level
								;----------------------------------
cmp eax ,0						;Compare With Zero
	je quit						; IF It Equal Go To Quit To Exit
	jmp quit					;Jump To Label Quit
;---------------------------------------------------------------------------------------------------
;Now We Will See If Th User Choose Easy , medium Or Hard
;And Print The UnSolved Soduku In Consloe
;---------------------------------------------------------------------------------------------------
;------------------------------<Note>---------------------------------
;In LvlXY
;X [1,3],Y [1,3]
;ex: In lvl11 Mean That The User Choose Level 1 Easy Level  And Rondom Function Choose 1 
;---------------------------------------------------------------------
easy : 
mov eax , 3
	call randomize
	call randomrange	;It is call Function To Read A Rondom Number With Rang That Moved It In Eax

cmp eax, 0				;Compare Eax And 0 
	je lvl11			;See If Cmp Equal Zero So Go In level 11
cmp eax , 1				;Compare Eax And 1 
	je lvl12			;See If Cmp Equal Zero So Go In level 12
cmp eax ,2				;Compare Eax And 2 and Eax Equal 2 BeCouse Rondom Function Zero Based 
	je lvl13			;See If Cmp Equal Zero So Go In level 13
	jmp quit			;Jump To Quit 
;---------------------------------------------------------------------------------------------------
lvl11:					;At This Label We Will Read A File And And Dispaly it In Console
mov eax , 1				;mov In Eax 1
push  eax				;We Push in Eax To Get The Rondom.. It Will Help As Leter
mov rand,al				;mov The Eax Value In Rand
mov edx,offset file11	;Edx Is A Pointer to Represnted Unsolved File
mov ecx,sizeof file11	;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxt			;It Is A Proc We Call It To Read From File And Diplay It In Console
;--------------------------------------------------------------------------------------------------
mov edx ,offset file11s	;Edx Is A Pointer to Represnted solved File
mov ecx ,sizeof file11s ;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxtsolved		;It Is A Proc We Call It To Read From File And Diplay It In Console
call savegamesolved
call startgame			;It Is A Proc We Call It To Start Soduku With It Is Function
jmp quit
;---------------------------------------------------------------------------------------------------
lvl12:					;At This Label We Will Read A File And And Dispaly it In Console
mov eax , 2				;mov In Eax 2
push  eax				;We Push in Eax To Get The Rondom.. It Will Help As Leter
mov rand,al				;mov The Eax Value In Rand
mov edx,offset file12	;Edx Is A Pointer to Represnted Unsolved File
mov ecx,sizeof file12	;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxt			;It Is A Proc We Call It To Read From File And Diplay It In Console
;-----------------------------------------------------------------------------------------------
mov edx ,offset file12s	;Edx Is A Pointer to Represnted solved File
mov ecx ,sizeof file12s ;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxtsolved		;It Is A Proc We Call It To Read From File And Diplay It In Console
call savegamesolved
call startgame			;It Is A Proc We Call It To Start Soduku With It Is Function
jmp quit
;---------------------------------------------------------------------------------------------------
lvl13:					;At This Label We Will Read A File And And Dispaly it In Console
mov eax , 3				;mov In Eax 3
push  eax				;We Push in Eax To Get The Rondom.. It Will Help As Leter
mov rand,al				;mov The Eax Value In Rand
mov edx,offset file13	;Edx Is A Pointer to Represnted Unsolved File
mov ecx,sizeof file13	;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxt			;It Is A Proc We Call It To Read From File And Diplay It In Console
;----------------------------------------------------------------------------------------------------
mov edx ,offset file13s	;Edx Is A Pointer to Represnted solved File
mov ecx ,sizeof file13s ;Ecx Have A Length Of Size Of The Represnted Unsolved File
call readtxtsolved		;It Is A Proc We Call It To Read From File And Diplay It In Console
call savegamesolved
call startgame			;It Is A Proc We Call It To Start Soduku With It Is Function
jmp quit
;---------------------------------------------------------------------------------------------------
medium :
mov eax , 3				;mov in Eax 3
	call randomize
	call randomrange	; Call Function To Get Rondom In Range 
cmp eax ,0
	je lvl21
cmp eax , 1
	je lvl22
cmp eax ,2
	je lvl23
	jmp quit
;---------------------------------------------------------------------------------------------------
;In This Label we Call ReadTxt Proc To Read Drom File And Dipaly it In  Console
;Call Readtxtsolved To Read The Solved Soduku To An Array 
;Call Start game Proc To Start The Game And Use It is Functions
;---------------------------------------------------------------------------------------------------
lvl21:
mov eax ,1
push eax
mov rand,al
mov edx,offset file21
mov ecx,sizeof file21
call readtxt

mov edx ,offset file21s
mov ecx ,sizeof file21s
call readtxtsolved
call startgame
jmp quit
;---------------------------------------------------------------------------------------------------
lvl22:
mov eax , 2
push  eax
mov rand,al
mov edx,offset file22
mov ecx,sizeof file22
call readtxt

mov edx ,offset file22s
mov ecx ,sizeof file22s
call readtxtsolved
call savegamesolved
call startgame
jmp quit
;---------------------------------------------------------------------------------------------------
lvl23:
mov eax , 3
push  eax
mov rand,al
mov edx,offset file23
mov ecx,sizeof file23
call readtxt

mov edx ,offset file23s
mov ecx ,sizeof file23s
call readtxtsolved
call savegamesolved
call startgame
jmp quit
;---------------------------------------------------------------------------------------------------
hard :
mov eax ,3
call randomize
	call randomrange 
cmp eax ,0
	je lvl31
cmp eax,1
	je lvl32
cmp eax,2
	je lvl33
;---------------------------------------------------------------------------------------------------
;In This Label we Call ReadTxt Proc To Read Drom File And Dipaly it In  Console
;Call Readtxtsolved To Read The Solved Soduku To An Array 
;Call Start game Proc To Start The Game And Use It is Functions
;---------------------------------------------------------------------------------------------------
lvl31:
mov eax , 1
push eax
mov rand,al
mov edx,offset file31
mov ecx,sizeof file31
call readtxt

mov edx ,offset file31s
mov ecx ,sizeof file31s
call readtxtsolved
call savegamesolved
call startgame
jmp quit
;---------------------------------------------------------------------------------------------------

lvl32:
mov eax ,2
push eax
mov rand,al
mov edx,offset file32
mov ecx,sizeof file32
call readtxt

mov edx ,offset file32s
mov ecx ,sizeof file32s
call readtxtsolved
call savegamesolved
call startgame
jmp quit
;---------------------------------------------------------------------------------------------------

lvl33:
mov eax ,3
push eax
mov rand,al
mov edx,offset file33
mov ecx,sizeof file33
call readtxt

mov edx ,offset file33s
mov ecx ,sizeof file33s
call readtxtsolved
call savegamesolved
call startgame
jmp quit

quit : 
	 exit

MAIN ENDP											  
;---------------------------------------------------------------------------------------------------
;ReadTxt Proc it is To Read From File In Array And Diplay Tgis Array in Console 
;---------------------------------------------------------------------------------------------------
readtxt proc
	call OpenInputFile 
mov fileHandle,eax					;Check for errors.
cmp eax,INVALID_HANDLE_VALUE		; error opening file?	
	jne file_ok ; no: skip 
mWrite <"Cannot open file",0dh,0ah> 
								; and quit 
;---------------------------------------------------------------------------------------------------
;File_OK => With Buffer Array And The Size in Ecx 
;Use Call ReadFrom File Function (Builted In Program)
;---------------------------------------------------------------------------------------------------
file_ok:
mov edx,OFFSET buffer 
mov ecx,BUFFER_SIZE 
	call ReadFromFile 
	jmp buf_size_ok
;---------------------------------------------------------------------------------------------------
; buf_size_ok=> UseIt To Write The Array In console 
;---------------------------------------------------------------------------------------------------
buf_size_ok: 
	mov edx,offset buffer	; display the buffer 
	 call printarr
	call Crlf 
close_file: 
mov eax,fileHandle 
	call CloseFile 
ret
readtxt endp
;---------------------------------------------------------------------------------------------------
;readtxtsolved proc Use It To Read The Solved Soduku File And But It In Array Named: solvedarr
;---------------------------------------------------------------------------------------------------
readtxtsolved proc
	call OpenInputFile 
mov fileHandle,eax					;Check for errors.
cmp eax,INVALID_HANDLE_VALUE		; error opening file?	
	jne file_ok ; no: skip 
mWrite <"Cannot open file",0dh,0ah> 
								; and quit 
file_ok:
mov edx,OFFSET solvedarr 
mov ecx,BUFFER_SIZE
	call ReadFromFile 

	
	call Crlf 
close_file: 
mov eax,fileHandle 
	call CloseFile 
ret
readtxtsolved endp
;---------------------------------------------------------------------------------------------------
;In This Proc We Write All Function The user Will Need
;The Functions(Print The Solved Soduku,Edit In A Cell in Soduku Board,Clear The Board And Save,Exist)
;---------------------------------------------------------------------------------------------------
startgame proc
	mWrite " [1] print solved board "
	call crlf
	mWrite " [2] edit cell in board (put value) "
	call crlf
	mWrite " [3] clear the board "
	call crlf
	mWrite " [4] Save and exit "
	call crlf
	call readdec
	cmp eax , 1
	je quitgame
	cmp eax,2
	je editcell
	cmp eax ,3
	je clearboard
	cmp eax,4
	je savv
;---------------------------------------------------------------------------------------------------
;EditCell Proc Use To Get The Cell Number
;Get The Row And Column And With A Simble Statments We Get The Cell That He Want
;---------------------------------------------------------------------------------------------------
editcell:
	mWrite " Enter The Row Of The Cell ^_^ "
	call crlf
	call readdec
	mov row,al

	mWrite " Enter The Column Of The Cell ^_^ "
	call crlf
	call readdec
	mov col,al

	mWrite " Enter The Value Of The Cell ^_^ "
	call crlf
	call readdec
	mov val,al
	;--------------------------
	;The Statments With It I Cacth The Cell
	;---------------------------
	sub row,1
	mov al,9
	mul row
	add al,col

	call crlf
	mov cell ,al
	;---------------------------
	
	call checkval
	jmp con

;---------------------------------------------------------------------------------------------------
;In QuitGame Proc We Played With the File
;At Rand And Diff
;At Rand=> We Push The Value Of Random Function To Read The Solved Soduku For The UnSolved Soduku
;At Diff => We Enter The Soduku Level in Diff And Pushed it in Al 
;---------------------------------------------------------------------------------------------------
quitgame:
	
	mov ebx,0
	mov eax,0
	mov bl,rand		
	mov al,diff
cmp eax ,1 
	je lvl1
	
cmp eax, 2
	je lvl2
	
cmp eax,3
	je lvl3
	jmp con
;----------------------------------------------------------------------------------
lvl1 :
cmp ebx ,1
	je lvl11s	
cmp ebx,2
	je lvl12s
cmp ebx,3
	je lvl13s
	jmp con
;-------------------------------------------------------------------------------
lvl11s:
mov edx ,offset file11s
mov ecx ,sizeof file11s
call printsolved

jmp con

lvl12s:
mov edx ,offset file12s
mov ecx ,sizeof file12s
call printsolved

jmp con

lvl13s:
mov edx ,offset file13s
mov ecx ,sizeof file13s
call printsolved
 
jmp con
;---------------------------------------------------------------------------------------------------
lvl2 :
cmp ebx ,1
	je lvl21s
	
cmp ebx,2
	je lvl22s
	
cmp ebx,3
	je lvl23s
	jmp con
;--------------------------------------------------------------------------------------------------
lvl21s:
mov edx ,offset file21s
mov ecx ,sizeof file21s
call printsolved
jmp con

lvl22s:
mov edx ,offset file22s
mov ecx ,sizeof file22s
call printsolved
jmp con

lvl23s:
mov edx ,offset file23s
mov ecx ,sizeof file23s
call printsolved
jmp con
;-----------------------------------------------------------------------------------------------
lvl3 : 
cmp ebx ,1
	je lvl31s
	
cmp ebx,2
	je lvl32s
	
cmp ebx,3
	je lvl33s
	jmp con
;------------------------------------------------------------------------------------------------
lvl31s:
mov edx ,offset file31s
mov ecx ,sizeof file31s
call printsolved
jmp con

lvl32s:
mov edx ,offset file32s
mov ecx ,sizeof file32s
call printsolved
jmp con

lvl33s:
mov edx ,offset file33s
mov ecx ,sizeof file33s
call printsolved
jmp con
;---------------------------------------------------------------------------------------------------
;in  clearboard Proc We Clear The Soduku Borad That The user played And Display The New One
;--------------------------------------------------------------------------------------------------
clearboard :
	call clrscr
	call crlf
	mov ebx,0
	mov eax,0
	mov bl,rand
	mov al,diff
cmp eax ,1 
	je lvl1c
cmp eax, 2
	je lvl2c
cmp eax,3
	je lvl3c
	jmp con
;--------------------------------------------------------------------------------------------------
lvl1c :
cmp ebx ,1
	je lvl11c
	
cmp ebx,2
	je lvl12c
	
cmp ebx,3
	je lvl13c
	jmp con
;------------------------------------------
lvl11c:
mov edx ,offset file11
mov ecx ,sizeof file11
call readtxt

jmp writ

lvl12c:
mov edx ,offset file12
mov ecx ,sizeof file12
call readtxt

jmp writ

lvl13c:
mov edx ,offset file13
mov ecx ,sizeof file13
call readtxt
jmp writ
;------------------------------------------------------------------------------------------------
lvl2c :
cmp ebx ,1
	je lvl21c
	
cmp ebx,2
	je lvl22c
	
cmp ebx,3
	je lvl23c
	jmp con
;-------------------------------------
lvl21c:
mov edx ,offset file21
mov ecx ,sizeof file21
call readtxt
jmp writ

lvl22c:
mov edx ,offset file22
mov ecx ,sizeof file22
call readtxt
jmp writ

lvl23c:
mov edx ,offset file23
mov ecx ,sizeof file23
call readtxt
jmp writ
;-------------------------------------------------------------------------------------------------
lvl3c : 
cmp ebx ,1
	je lvl31c
	
cmp ebx,2
	je lvl32c
	
cmp ebx,3
	je lvl33c
	jmp con
;-----------------------------------------
lvl31c:
mov edx ,offset file31
mov ecx ,sizeof file31
call readtxt
jmp writ

lvl32c:
mov edx ,offset file32
mov ecx ,sizeof file32
call readtxt
jmp writ

lvl33c:
mov edx ,offset file33
mov ecx ,sizeof file33
call readtxt
jmp writ


writ : call startgame			;Use This Call To Display And Use The game Functions


savv:


call crlf
	mWrite"Done !!"
call crlf


con:
	exit
	ret
startgame endp
;---------------------------------------------------------------------------------------------------
;in checkval PRoc We Compare With Value That The User Enterd And The Value In Solved Soduku 
; Print Right Aswer If The Compare Is Correct  Print It In Green 
; Print Wrong Answer if The Compare Is InCoreect Print It In Blue 
;--------------------------------------------------------------------------------------------------
checkval proc

call crlf
mov esi , offset solvedarr
mov ecx,0
mov cl,cell
mov ebx, 0
mov edx, 0
;Loop To To Skip The Enter Action The Happened To Make NewLine
loop1:
	inc edx
	inc ebx

	cmp ebx,81					;81 Is The Last Position In Soduku 9*9
	je breakk
	mov eax,0
	cmp bl,cell
	je breakk
	inc esi
	 
	cmp edx,9
	je edit 
	jne lnn
	edit :
	add esi ,2
	mov edx,0
	lnn:
loop loop1
	breakk:
mWrite " we made it  ^_^ "
   call crlf
	mov al,byte ptr [esi]
	
	sub al,48					;Sub 48 To Convert From Ascii
	cmp al,val
	je tru
	jne fals

	tru:
		mWrite "true ^_^"
		inc righttrials
	call writetrue

	jmp con
	fals :
		mWrite "False O_O "
		inc wrongtrials 
	call writefalse
	jmp con
	
	con:
		call crlf
		call startgame
	
ret
checkval endp
;----------------------------------------------------------------------------------------------------
;In WriteTrue Proc We Compare The Value That The User Enterd And If True We Go In ..
; Buffer And Write This Value 
; If The Value Is In The Main Numbers In soduku The User Connot Edit in It 
;----------------------------------------------------------------------------------------------------
writetrue proc
	mov esi , offset buffer
	mov ecx,0
	mov cl,cell
	mov ebx, 0
	mov edx, 0

loop1:
		inc edx
		inc ebx

		cmp ebx,81
		je breakk
		mov eax,0
		cmp bl,cell
		je breakk
		inc esi
	 
		cmp edx,9
		je edit 
		jne lnn
	edit :
		add esi ,2
		mov edx,0
	lnn:
loop loop1
	breakk: 

		mov eax,0
		mov al ,val
		add al,48
		mov byte ptr [esi],0
		mov byte ptr [esi],al
		mov edx ,offset buffer
		mov ecx ,sizeof buffer
	call clrscr
		mov eax,0
		mov al,gren
	call SetTextColor				;Built In Function 
		mWrite "Right Answer"
	call crlf
		mov eax ,0
		mov al ,whit
	call SetTextColor
		mov bl ,gren
		mov clr,bl
	call printarr
	call crlf
		mov cell,0
	call savegame
	call startgame
ret
writetrue endp
;-----------------------------------------------------------------------------------------------------
;in printarr Proc We Print The Shape Of Soduku With It is Lines In Console Window
;-----------------------------------------------------------------------------------------------------
printarr proc 
mov esi ,offset buffer
	mov ecx ,9
	mov ebx,0
	mov edx,0
	l2:
		push ecx
	
		mWrite" "
		mov ecx ,9
	l1: 
		mWrite "| "

		mov eax,0
		cmp ebx,9
		je editt 
		jne con
	editt:
		add esi,2
		mov ebx,0
	con:
		inc edx
		mov al,byte ptr[esi]
		sub al,48
		cmp cell,dl
		je colr
	jne conn
	colr: 
		call colorcell
	conn:	

		call writedec
		mov al , whit 
		call settextcolor
		inc ebx
		inc esi
		mWrite" "
	loop l1
	
	call crlf
	mWrite" ______________________________"
	call crlf
	pop  ecx
	loop l2
	

ret
printarr endp
;----------------------------------------------------------------------------------------------------
; In colorcell Proc Before We Enter The Proc We Pushed In Clr Var the Value Of Desired Color
;rd byte 4			But The Color Red
;blu byte 1			But The Color Blue
;whit byte 15		But The Color White
;gren byte 10		But The Color Green
;----------------------------------------------------------------------------------------------------
colorcell proc
	push eax
	mov eax,0
	mov al,clr
	call  settextcolor
	pop eax
ret
colorcell endp

;----------------------------------------------------------------------------------------------------
;In WriteFalse Proc We Compare The Value That The User Enterd And If False We Go In ..
; Buffer And Print The Cell In Red Color  0 This Value 
; If The Value Is In The Main Numbers In soduku The User Connot Edit in It 
;----------------------------------------------------------------------------------------------------
writefalse proc

		mov edx ,offset buffer
		mov ecx ,sizeof buffer
	call clrscr
		mov eax,0
		mov al,rd
	call SetTextColor
		mWrite "Wrong Answer"
	call crlf
		mov eax ,0
		mov al ,whit
	call SetTextColor
		mov bl ,rd
		mov clr,bl

	call printarr
	call crlf
		mov cell,0
	call startgame


ret
writefalse endp
;----------------------------------------------------------------------------------------------------
;In printsolved Proc We Print The Solved Soduku That We Play In 
; In This Proc We Try To Get The Zero Value In Blue 
;----------------------------------------------------------------------------------------------------
printsolved proc

mov esi ,offset solvedarr
mov edi, offset buffer

	mov ecx ,9
	mov ebx,0
	mov edx,0
	l2:
	push ecx
	
	mov ecx ,9
	l1: 
	mWrite "| "

	
		cmp ebx,9
		je editts 
		jne cons
	editts:
		add esi,2
		add edi,2
		mov ebx,0
	cons:
		inc edx
		push ebx
	call checkzero 
		mov eax,0
		mov al,byte ptr[esi]
		sub al,48
		inc esi
		inc edi
		pop ebx
		je colrs
		jne conns
	colrs: 
		push ebx
	call colorcell
	pop ebx
	conns:	
		call writedec
		mov al , whit 
	call settextcolor
		inc ebx
		mWrite" "
	loop l1
	
	call crlf
		mWrite" ________________________________"
	call crlf
		pop  ecx
	loop l2
		mWrite"No. of right trials : "
		mov eax,0
		mov al,righttrials
	call writedec
	call crlf
		mWrite"No. of wrong trials : "
		mov eax,0
		mov al,wrongtrials
	call writedec
	call crlf
 
ret
printsolved endp
;-----------------------------------------------------------------------------------------------------
;In checkzero Proc We Compare The Value And If It Zero Color The Value Blue
;-----------------------------------------------------------------------------------------------------
checkzero proc
    mov ebx ,0
    mov bl ,byte ptr[edi]
	sub bl ,48
	cmp bl,zer
	je tt
	jne ff
	tt:
		mov ebx,0 
		mov bl,blu
		mov clr ,bl
	ff:
		ret
checkzero endp
;-----------------------------------------------------------------------------------------------------
;In savegame Proc We Catch Current Soduku File Name In FileOut
;And  Create The File With The UnSolved Soduku To Continue The Game Later
;-----------------------------------------------------------------------------------------------------
savegame proc

mov edx,OFFSET fileOut
call CreateOutputFile

mov eax,fileHandle
mov edx,OFFSET buffer
mov ecx,sizeof buffer

call WriteToFile
call CloseFile

ret
savegame endp
;-----------------------------------------------------------------------------------------------------
;In savegame Proc We Catch Current Solved Soduku File Name In FileOutSolved
;And  Create The File With The Solved Soduku To Continue The Game Later
;-----------------------------------------------------------------------------------------------------
savegamesolved proc
mov edx,OFFSET fileOutsolved
call CreateOutputFile

mov eax,fileHandle
mov edx,OFFSET solvedarr
mov ecx,sizeof solvedarr

call WriteToFile
call CloseFile
ret
savegamesolved endp						; --------------------
										;| Finally The End ^_^ |
END MAIN								; --------------------