cc        = riscv64-unknown-elf-gcc
gdb       = riscv64-unknown-elf-gdb
cc_flags  = -nostdlib -fno-builtin -mcmodel=medany -march=rv32ima -mabi=ilp32
objdump   = riscv64-unknown-elf-objdump

qemu       = qemu-system-riscv32
qemu_flags = -nographic -smp 4 -machine virt -bios default
qemu_pid   = os.pid

default: image

image = FleaOS.elf
objs  = kernel/start.s kernel/*.c
ld    = kernel/kernel.ld

image: $(objs)
	$(cc) $(cc_flags) -T $(ld) -g -o $(image) $^

start:
	$(qemu) $(qemu_flags) -s -S -kernel $(image) -pidfile $(qemu_pid)

stop:
	kill `cat $(qemu_pid)`

debug: $(objs)
	$(cc) $(cc_flags) -T $(ld) -g -o $(image) $^ && \
	$(qemu) $(qemu_flags) -s -S -kernel $(image) -pidfile $(qemu_pid) &>std.log &

gdb:
	$(gdb) --se=$(image) --ex "target remote localhost:1234"