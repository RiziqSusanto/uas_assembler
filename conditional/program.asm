section .bss
    buffer resb 256        ; Buffer untuk menyimpan pesan

section .data
    msg_greater db 'Nilai lebih besar dari 10', 0xA ; Pesan jika lebih besar dari 10
    msg_less_or_equal db 'Nilai kurang dari atau sama dengan 10', 0xA ; Pesan jika kurang dari atau sama dengan 10

section .text
    global _start

_start:
    ; Set nilai untuk diuji
    mov eax, 15           ; Ganti nilai ini untuk pengujian

    ; Periksa jika nilai lebih besar dari 10
    cmp eax, 10           ; Bandingkan eax dengan 10
    jg greater_than       ; Lompat ke label greater_than jika eax > 10

    ; Jika tidak lebih besar dari 10, eksekusi bagian ini
    mov eax, 4            ; Nomor syscall untuk sys_write
    mov ebx, 1            ; File descriptor 1 adalah stdout
    mov ecx, msg_less_or_equal ; Pointer ke pesan jika kurang dari atau sama dengan 10
    mov edx, 31           ; Panjang pesan
    int 0x80              ; Panggil kernel
    jmp exit              ; Lompat ke bagian exit

greater_than:
    ; Jika lebih besar dari 10, eksekusi bagian ini
    mov eax, 4            ; Nomor syscall untuk sys_write
    mov ebx, 1            ; File descriptor 1 adalah stdout
    mov ecx, msg_greater ; Pointer ke pesan jika lebih besar dari 10
    mov edx, 27           ; Panjang pesan
    int 0x80              ; Panggil kernel

exit:
    ; Keluar dari program
    mov eax, 1            ; Nomor syscall untuk sys_exit
    xor ebx, ebx          ; Kode status 0
    int 0x80              ; Panggil kernel
