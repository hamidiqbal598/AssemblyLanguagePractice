.model medium
.stack 100h
.data

row dw ?
col dw ?

pixel struc
x dw ?
y dw ?
z db ?
pixel ends

point pixel<>

.code
start:

display macro p1

mov cx,p1.x
mov dx,p1.y
mov al,point.z
mov ah,0ch
int 10h

 endm

main proc
mov ax,@data
mov ds,ax
mov ax,0

mov ah,0
mov al,13h
int 10h

mov point.x,25
mov point.y,35
mov point.z,12

l1:
display point
inc point.y
cmp point.y,65
jbe l1
jmp l2

l2:
mov dl,10
mov ah,02h
int 21h

main endp
jmp exit


exit:
mov ah,4ch
int 21h
end