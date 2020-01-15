.model medium
.stack 100h
.data

row dw ?
col dw ?
r1 dw ?
r2 dw ?
lop db 1
c1 dw ?

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

outb:
    mov point.x,10
    mov point.y,10
    mov point.z,2
    out1:
        mov ah,0
        mov al,13h
        int 10h

        call line
        call display
        inc point.x

        mov cx,1
        mov dx,1
        mov ah,86h
        int 15h

        cmp point.x,268
        jb out1
        jmp out2
    out2:
        mov point.z,3
        mov ah,0
        mov al,13h
        int 10h

        call line
        call display
        dec point.x

        mov cx,1
        mov dx,1
        mov ah,86h
        int 15h

        cmp point.x,1
        ja out2
        jmp out3
    out3:
        cmp lop,50
        jbe outb

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

line proc

mov c1,1
l1:
    mov cx,0
    mov dx,c1
    mov al,point.z
    mov ah,0ch
    int 10h
    inc c1
    cmp c1,199
    jbe l1

mov c1,0
l2:
    mov cx,319
    mov dx,c1
    mov al,point.z
    mov ah,0ch
    int 10h
    inc c1
    cmp c1,199
    jbe l2

mov c1,0
l3:
    mov cx,c1
    mov dx,0
    mov al,point.z
    mov ah,0ch
    int 10h
    inc c1
    cmp c1,319
    jbe l3

mov c1,0
l4:
    mov cx,c1
    mov dx,199
    mov al,point.z
    mov ah,0ch
    int 10h
    inc c1
    cmp c1,319
    jbe l4

    ret
line endp


exit:
mov ah,4ch
int 21h
end