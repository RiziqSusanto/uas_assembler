section .text
   global _start    ; Harus dideklarasikan untuk menggunakan gcc atau linker
     
_start:             ; Menunjukkan titik masuk linker
   mov  al, '3'     ; Memuat karakter '3' ke register AL
   sub  al, '0'     ; Mengonversi karakter ke angka dengan mengurangi '0' (ASCII 48)
   
   mov  bl, '2'     ; Memuat karakter '2' ke register BL
   sub  bl, '0'     ; Mengonversi karakter ke angka dengan mengurangi '0' (ASCII 48)
   
   mul  bl           ; Mengalikan AL dengan BL, hasilnya disimpan di AL
   add  al, '0'     ; Mengonversi hasil kembali ke karakter ASCII dengan menambahkan '0'
   
   mov  [res], al   ; Menyimpan hasil ke variabel res
   
   ; Mencetak pesan "The result is:"
   mov  ecx, msg    ; Alamat pesan
   mov  edx, len    ; Panjang pesan
   mov  ebx, 1      ; Deskriptor file (stdout)
   mov  eax, 4      ; Nomor syscall (sys_write)
   int  0x80        ; Panggil kernel

   ; Mencetak hasil
   mov  ecx, res    ; Alamat hasil
   mov  edx, 1      ; Panjang data yang ditulis (1 byte)
   mov  ebx, 1      ; Deskriptor file (stdout)
   mov  eax, 4      ; Nomor syscall (sys_write)
   int  0x80        ; Panggil kernel

   ; Keluar dari program
   mov  eax, 1      ; Nomor syscall (sys_exit)
   xor  ebx, ebx    ; Status keluar (0)
   int  0x80        ; Panggil kernel

section .data
msg db "The result is:", 0xA, 0xD  ; Pesan untuk dicetak (termasuk newline dan carriage return)
len equ $ - msg    ; Panjang pesan

section .bss
res resb 1         ; Tempat untuk menyimpan hasil
