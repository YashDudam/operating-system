ORG 0x7C00
bits 16

%define NEWLINE 0x0D, 0x0A

start:
    jmp main

main:

    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00

    mov si, message
    call puts

    hlt
    jmp halt   ; exit program


; Prints a string to the screen.
; Param:
;   - ds:si points to the string
;
puts:
    push si
    push ax

.loop:
    lodsb               ; load next character in al
    or al, al           ; verify if next character is null, sets zero flag if null
    jz .done            ; jumps if zero flag is null

    mov ah, 0x0e        ; write character in tty mode
    mov bh, 0           ; set page number to zero
    int 0x10            ; call bios interrupt

    jmp .loop
.done:
    pop ax
    pop si
    ret

halt:
    jmp halt

message: db "Hello, World!", NEWLINE, 0

times 510 - ($ - $$) db 0
db 0x55, 0xaa

