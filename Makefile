cc        = riscv64-unknown-elf-gcc
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
	$(cc) $(cc_flags) -T $(ld) -o $(image) $^

start:
	$(qemu) $(qemu_flags) -kernel $(image) -pidfile $(qemu_pid)

stop:
	kill `cat $(qemu_pid)`

clean:
	rm -f *.elf