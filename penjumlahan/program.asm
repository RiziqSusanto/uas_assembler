section .data
    num1 db 5
    num2 db 3
    hasil db 0
    pesan db 'Hasil penjumlahan: ', 0
    buffer db '  ', 0

section .text
    global _start

_start:
    ; load nilai num1 dan num2 ke register
    mov al, [num1]
    mov bl, [num2]

    ; lakukan penjumlahan
    add al, bl

    ; simpan hasil ke variabel hasil
    mov [hasil], al

    ; cetak pesan
    mov eax, 4
    mov ebx, 1
    mov ecx, pesan
    mov edx, 18
    int 0x80

    ; konversi hasil ke string
    mov al, [hasil]
    add al, '0'
    mov [buffer], al

    ; cetak hasil
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 2
    int 0x80

    ; exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80