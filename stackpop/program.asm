section .bss
    stack resb 1024       ; Cadangkan 1024 byte untuk stack
    stack_ptr resd 1      ; Cadangkan 4 byte untuk menyimpan pointer stack
    num resd 1            ; Cadangkan 4 byte untuk menyimpan angka yang akan dicetak
    buffer resb 12        ; Buffer untuk mengonversi angka menjadi string

section .text
    global _start

_start:
    ; Inisialisasi pointer stack
    mov eax, stack
    mov [stack_ptr], eax

    ; Push angka 10 ke stack
    mov eax, 10
    call push

    ; Push angka 20 ke stack
    mov eax, 20
    call push

    ; Pop dari stack
    call pop
    ; Nilai yang dipop dari stack (20) sekarang ada di eax

    ; Simpan angka di num
    mov [num], eax

    ; Konversi angka menjadi string
    mov eax, [num]
    call itoa

    ; Cetak hasil
    mov eax, 4          ; nomor syscall untuk sys_write
    mov ebx, 1          ; file descriptor 1 adalah stdout
    mov ecx, buffer     ; pointer ke buffer
    mov edx, 12         ; jumlah byte yang akan ditulis
    int 0x80            ; panggil kernel

    ; Keluar dari program
    mov eax, 1          ; nomor syscall untuk sys_exit
    xor ebx, ebx        ; kode status 0
    int 0x80            ; panggil kernel

push:
    ; Simpan nilai dari eax ke stack
    mov ebx, [stack_ptr] ; Ambil pointer stack saat ini
    mov [ebx], eax      ; Push nilai (eax) ke stack
    add ebx, 4          ; Pindahkan pointer stack ke atas 4 byte
    mov [stack_ptr], ebx ; Perbarui pointer stack
    ret

pop:
    ; Ambil nilai dari stack ke eax
    mov ebx, [stack_ptr] ; Ambil pointer stack saat ini
    sub ebx, 4          ; Pindahkan pointer stack ke bawah 4 byte
    mov eax, [ebx]      ; Pop nilai ke dalam eax
    mov [stack_ptr], ebx ; Perbarui pointer stack
    ret

itoa:
    ; Konversi integer di eax ke string ASCII di buffer
    mov ebx, 10         ; Basis 10
    mov ecx, buffer + 11 ; Set pointer ke akhir buffer
    mov byte [ecx], 0   ; Terminator null

itoa_loop:
    xor edx, edx        ; Kosongkan edx sebelum pembagian
    div ebx             ; Bagi eax dengan 10
    add dl, '0'         ; Konversi sisa menjadi karakter ASCII
    dec ecx             ; Pindahkan pointer buffer
    mov [ecx], dl       ; Simpan digit di buffer
    test eax, eax       ; Periksa jika hasil bagi adalah nol
    jnz itoa_loop       ; Jika tidak nol, lanjutkan

    ret
