;MARIA TERESA HURTADO GALLARDO
;PROGRAMA QUE SUMA 2 NUMEROS EN HEXADECIMAL
;ING JOSE LUIS BARBOSA PACHECO. MICROPROCESADORES 1711
	 .org 0000h
;INICIALIZACION de b
	ld b,19h
;INSTRUCCIONES COMPLETAS PARA DEJAR EN BCD PARA EL PRIMER NUMERO
	call principal
	ld h,b
	ld e,c
;INICIALIZACION DEL NUMERO 2 EN C
	ld c, 16h
	ld b,c
	ld a,0
;INSTRUCCIONES PARA DEJAR EN BCD EN EL SEGUNDO NUMERO
	call principal
	ld b,h
	ld l,c
	ld c,e
	ld e, l

;SUMA DE LA PRIMERA COLUMNA
	ld a,0
	add a, c
	add a, e
	ld l, a

;SUMA DE LA SEGUNDA COLUMNA
	ld a, 0
	add a, b
	add a, d
	ld h, a

;VERIFICACION DEL CARRIER
	ld a,0
	ld b,0
	ld c,0
	ld d,0
	ld e, 0

	ld a, l
	ld b, 0Ah
	call mov101
	ld l, a
	ld e, 0
	ld a,0
	add a, d
	ld b, a
	ld a,h
	add a,b
	ld h,a

	ld a, h
	ld b, 0Ah
	call mov101
	ld h, a
	ld e,d
	ld a,e

	ld b,0
	ld c,0
	ld d,0
	ld e, 0

	halt


principal:
	ld a, b
	ld l, 0Ah
;INSTRUCCIONES PARA SEPARACION EN UNIDADES Y DECENAS
	call mod10
;CARGA DE UNIDADES EN EL REGISTRO C Y DE DECENAS EN EL RESISTRO B
	ld c,a
	ld b, d
;ASIGNACION DE LOS VAORES EN BCD
	call bcd
	ret
bcd:
	ld a, 0
	cp b
	jr z, cero
	cp c
	jr z, cero1

	ld a, 1
	cp b
	jr z, uno
	cp c
	jr z, uno1

	ld a, 2
	cp b
	jr z, dos
	cp c
	jr z, dos1

	ld a, 3
	cp b
	jr z, tres
	cp c
	jr z, tres1

	ld a, 4
	cp b
	jr z, cuatro
	cp c
	jr z, cuatro1

	ld a, 5
	cp b
	jr z, cinco
	cp c
	jr z, cinco1

	ld a, 6
	cp b
	jr z, seis
	cp c
	jr z, seis1

	ld a, 7
	cp b
	jr z, siete
	cp c
	jr z, siete1

	ld a, 8
	cp b
	jr z, ocho
	cp c
	jr z, ocho1

	ld a, 9
	cp b
	jr z, nueve
	cp c
	jr z, nueve1
	ret

cero:
	ld b, 00000000b
	ret
uno:
	ld b, 00000001b
	ret
dos:
	ld b, 00000010b
	ret
tres:
	ld b, 00000011b
	ret
cuatro:
	ld b, 00000100b
	ret
cinco:
	ld b, 00000101b
	ret
seis:
	ld b, 00000110b
	ret
siete:
	ld b, 00000111b
	ret
ocho:
	ld b, 00001000b
	ret
nueve:
	ld b, 00001001b
	ret
cero1:
	ld c, 00000000b
	ret
uno1:
	ld c, 00000001b
	ret
dos1:
	ld c, 00000010b
	ret
tres1:
	ld c, 00000011b
	ret
cuatro1:
	ld c, 00000100b
	ret
cinco1:
	ld c, 00000101b
	ret
seis1:
	ld c, 00000110b
	ret
siete1:
	ld c, 00000111b
	ret
ocho1:
	ld c, 00001000b
	ret
nueve1:
	ld c, 00001001b
	ret
mod10:
	ld c, a
	ld d, 00h
div:
	cp l
	jr c, ciclo
	sub l
	inc d
	jr div
ciclo:
	ret
mov101:
	ld c, a
	ld d, 00h
div1:
	cp b
	jr c, fin ;a unidades
	sub b ;d decenas
	inc d
	jr div1
fin:
	ret