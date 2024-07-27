section .text
    global _start        ; Harus dideklarasikan agar bisa digunakan oleh gcc
    
_start:                 ; Titik masuk linker

    mov rcx,10           ; Inisialisasi rcx sebagai counter loop, mulai dari 10
    mov rax, '1'         ; Inisialisasi rax dengan karakter '1' yang akan dicetak

l1:                     ; Label untuk loop
    mov [num], rax       ; Simpan nilai dari rax ke variabel num
    mov rax, 4           ; 4 adalah nomor sistem call untuk write
    mov rbx, 1           ; 1 adalah file descriptor untuk stdout
    push rcx             ; Simpan nilai rcx ke stack sementara

    ; argumen untuk sistem call write
    mov rcx, num         ; Alamat dari num disimpan di rcx
    mov rdx, 1           ; Panjang data yang akan dicetak (1 byte)
    int 0x80             ; Panggil kernel untuk menulis karakter ke stdout

    mov rax, [num]       ; Muat nilai num ke rax
    sub rax, '0'         ; Konversi karakter di rax menjadi angka desimal
    inc rax              ; Tambahkan 1 ke nilai desimal di rax
    add rax, '0'         ; Konversi angka kembali menjadi karakter
    pop rcx              ; Ambil kembali nilai rcx dari stack
    loop l1              ; Ulangi loop hingga rcx menjadi 0

    mov eax,1            ; Nomor sistem call untuk exit
    int 0x80             ; Panggil kernel untuk keluar dari program

section .bss
    num resb 1           ; Cadangkan satu byte untuk buffer
