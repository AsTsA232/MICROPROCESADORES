;María Teresa Hurtado Gallardo
;programa que valide una contraseña
;microprocesadores 1709


	.org 0000h
	ld a,69
	                      ;  CONSTANTES
	                      ;  PROGRAMA PRINCIPAL
	ld a,89h
	out (CW),a
	                      ;  INICIALIZAR EL STACK
	ld SP,27ffh
	ld hl,text1
	ld e,0
	call desp_txt
	call lee_cl

	halt

	                      ;  SUBRUTINAS
	                      ;  Rutina que despliega un texto
desp_txt:
ciclo:
	ld a,(hl)
	                      ;  cuando se escribe con parentesis toma el contenido y cuando no toma la direccion
	cp ":"
	                      ;  la comparacion siempre se hace sobre a
	jp z,fin
	out (ldc),a
	inc hl
	jp ciclo
fin:
	ret

lee_cl:
	ld hl,clave
	ld b,4
leer_otro:
	in a,(KEYB)
	ld (hl),a
;  SALTA SI NO ES CERO Y DECREMENTA EL B
	call val2
	djnz leer_otro
	ret

;  VERIFICAR SI SON DIGITOS VALIDOS

val2:
	ld c,a
	ld a,39h
clk:
	cp c
	jp z,correcto
	dec a
	cp 29h
	jp nz,clk
	ld a,c
error:
	ld d,a
	ld a,e
	inc a
	cp 3
	jp z, fallos
	ld e,a
	ld a,d
	ld b,5
	ld hl,text1
	call desp_txt
	ld hl,clave    ; si el digito no es valido
	ret		     ; despliega una cadena
correcto:
	ld d,a
	ld hl,aste
	ld a,(hl)
	out (ldc),a
	ld a,d
	ld c,b
	ld b,0
	ld hl, clave
	ld (hl),a
	ld b,c
	ret

fallos:
	ld hl,cadena
	ld a,(hl)
	out (ldc),a
	call desp_txt

bloqueo:
	ld a,0
	cp 0
	jp z, bloqueo

	                      ;  SEGMENTO DE DATOS

	.org 2000h
LDC:	.equ 00h
KEYB:	.equ 01h
text1:	.db "INTRODUCE TU NIP:"
patron:	.dw "1234"
clave:	.db 00h,00h,00h,00h
CW:	.equ 03h
ASTE:	.db "*"
cadena: .db "BLOQUEO DEL SISTEMA:"
cadf: .db "CONTRASENIA CORRECTA:"
	end