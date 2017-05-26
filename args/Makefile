ASM = yasm
ASM_FLAGS = -f elf64 -a x86 -m amd64 -g dwarf2
LD = ld

args: args.o
	$(LD) -o $@ $<

args.o: args.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

args.lst: args.asm
	$(ASM) $(ASM_FLAGS) -l $@ $<

clean:
	rm -f args.lst args.o args

.PHONY: clean
