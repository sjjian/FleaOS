.equ STACK_SIZE, 8192

.global _start

_start:
    la sp, stacks + STACK_SIZE
    j os_main

park:
    wfi
    j park

stacks:
    .skip STACK_SIZE * 4
