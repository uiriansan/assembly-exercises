BUILD_SRC=build

.PHONY: all clean

# find all .asm files in nasm/ and fasm/ directories
NASM_X16_SOURCES=$(shell find nasm/x16 -name "*.asm" 2>/dev/null)
NASM_X86_SOURCES=$(shell find nasm/x86 -name "*.asm" 2>/dev/null)
FASM_SOURCES=$(shell find fasm -name "*.asm" 2>/dev/null)

# generate output file paths in build/ directory
NASM_X16_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(NASM_X16_SOURCES))
NASM_X86_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%,$(NASM_X86_SOURCES))
FASM_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(FASM_SOURCES))

all: $(NASM_X16_OBJECTS) $(NASM_X86_OBJECTS) $(FASM_OBJECTS)

$(BUILD_SRC)/nasm/x16/%.bin: nasm/x16/%.asm
	@mkdir -p $(dir $@)
	nasm -f bin $< -o $@

$(BUILD_SRC)/nasm/x86/%: nasm/x86/%.asm
	@mkdir -p $(dir $@)
	nasm -f elf $< -o $@.o
	gcc -no-pie -m32 $@.o -o $@
	rm $@.o

$(BUILD_SRC)/fasm/%.bin: fasm/%.asm
	@mkdir -p $(dir $@)
	fasm $< $@

clean:
	rm -rf $(BUILD_SRC)

$(shell mkdir -p $(BUILD_SRC))
