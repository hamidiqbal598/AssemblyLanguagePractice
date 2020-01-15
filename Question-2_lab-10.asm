.model medium
.stack 100h
.data

row dw ?
col dw ?
r1 dw ?
r2 dw ?

pixel struc
x dw ?
y dw ?
z db ?
pixel ends

point pixel<>

.code
start:


main proc
mov ax,@data
mov ds,ax
mov ax,0

mov ah,0
mov al,13h
int 10h

mov point.x,50
mov point.y,50
mov point.z,1

call display

mov point.x,120
mov point.y,50
mov point.z,3

call display


mov point.x,50
mov point.y,120
mov point.z,12

call display


mov point.x,120
mov point.y,120
mov point.z,2

call display

mov dl,10
mov ah,02h
int 21h

main endp
jmp exit

display proc

mov cx,point.x
mov dx,point.y
mov r1,cx
mov r2,dx
add r1,50
add r2,50
mov col,dx
mov row,cx
inner:
    mov cx,row
    mov dx,col
    mov al,point.z
    mov ah,0ch
    int 10h
    inc row
    mov bx,r1
    cmp row,bx
    jbe inner
    jmp outer
outer:
    mov cx,row
    mov dx,col
    mov al,point.z
    mov ah,0ch
    int 10h
    inc col
    mov bx,r2
    cmp col,bx
    jbe outer
    jmp o1
  o1:
    mov cx,row
    mov dx,col
    mov al,point.z
    mov ah,0ch
    int 10h
    dec row
    mov bx,point.x
    cmp row,bx
    jae o1
    jmp o2
  o2:
    mov cx,row
    mov dx,col
    mov al,point.z
    mov ah,0ch
    int 10h
    dec col
    mov bx,point.y
    cmp col,bx
    jae o2
    ret
 display endp

exit:
mov ah,4ch
int 21h
end