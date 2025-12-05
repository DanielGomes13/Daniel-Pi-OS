/* entry.S - inicialização básica x86_64 */
.global start
.section .text
start:
    /* Stack (usamos stack do GRUB, mas configuramos uma simples) */
    mov $0x90000, %rsp   /* stack pointer */

    /* chama kernel_main(argc, argv) - nenhum argumento */
    call kernel_main

1:  hlt
    jmp 1b
