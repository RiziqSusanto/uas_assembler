section .data
    num1 db '9'            ; Karakter angka pembagi (dividend)
    num2 db '3'            ; Karakter angka pembagi (divisor)
    pesan db 'Hasil pembagian: ', 0
    buffer db '0', 0       ; Buffer untuk menyimpan hasil (cukup untuk 1 digit)

section .bss
    hasil resb 1           ; Tempat untuk menyimpan hasil pembagian

section .text
    global _start

_start:
    ; Load nilai num1 dan num2 ke register
    mov al, [num1]         ; Memuat karakter '9' ke register AL
    sub al, '0'           ; Mengonversi karakter ke angka dengan mengurangi '0' (ASCII 48)
    
    mov bl, [num2]         ; Memuat karakter '3' ke register BL
    sub bl, '0'           ; Mengonversi karakter ke angka dengan mengurangi '0' (ASCII 48)

    ; Lakukan pembagian
    mov ah, 0             ; Clear AH (pembagi 16-bit untuk hasil pembagian)
    div bl                ; AL = AL / BL, hasil disimpan di AL (sisa di AH)

    ; Simpan hasil ke variabel hasil
    mov [hasil], al       ; Simpan hasil (AL) ke variabel hasil

    ; Cetak pesan
    mov eax, 4            ; Syscall: write
    mov ebx, 1            ; File descriptor: stdout
    mov ecx, pesan        ; Alamat pesan
    mov edx, 18           ; Panjang pesan
    int 0x80              ; Panggil kernel

    ; Konversi hasil ke string
    mov al, [hasil]       ; Muat hasil ke AL
    add al, '0'           ; Mengonversi hasil ke karakter ASCII
    mov [buffer], al      ; Simpan hasil ke buffer

    ; Cetak hasil
    mov eax, 4            ; Syscall: write
    mov ebx, 1            ; File descriptor: stdout
    mov ecx, buffer       ; Alamat buffer
    mov edx, 2            ; Panjang data yang ditulis (1 digit + 1 null terminator)
    int 0x80              ; Panggil kernel

    ; Exit program
    mov eax, 1            ; Syscall: exit
    xor ebx, ebx          ; Status keluar: 0
    int 0x80              ; Panggil kernel
