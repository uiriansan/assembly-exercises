BUILD_SRC=build

.PHONY: all clean

# find all .asm files in nasm/ and fasm/ directories
NASM_X16_SOURCES=$(shell find nasm/x16 -name "*.asm" 2>/dev/null)
NASM_X86_SOURCES=$(shell find nasm/x86 -name "*.asm" 2>/dev/null)
FASM_X16_SOURCES=$(shell find fasm/x16 -name "*.asm" 2>/dev/null)
FASM_X86_SOURCES=$(shell find fasm/x86 -name "*.asm" 2>/dev/null)

# generate output file paths in build/ directory
NASM_X16_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(NASM_X16_SOURCES))
NASM_X86_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%,$(NASM_X86_SOURCES))
FASM_X16_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(FASM_X16_SOURCES))
FASM_X86_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%,$(FASM_X86_SOURCES))

all: $(NASM_X16_OBJECTS) $(NASM_X86_OBJECTS) $(FASM_X16_OBJECTS) $(FASM_X86_OBJECTS)

$(BUILD_SRC)/nasm/x16/%.bin: nasm/x16/%.asm
	@mkdir -p $(dir $@)
	nasm -f bin $< -o $@

$(BUILD_SRC)/nasm/x86/%: nasm/x86/%.asm
	@mkdir -p $(dir $@)
	nasm -f elf $< -o $@.o
	gcc -no-pie -m32 $@.o -o $@
	rm $@.o

$(BUILD_SRC)/fasm/x16/%.bin: fasm/x16/%.asm
	@mkdir -p $(dir $@)
	fasm $< $@

$(BUILD_SRC)/fasm/x86/%: fasm/x86/%.asm
	@mkdir -p $(dir $@)
	fasm $< $@.o
	gcc -no-pie -m32 $@.o -o $@
	rm $@.o

clean:
	rm -rf $(BUILD_SRC)

$(shell mkdir -p $(BUILD_SRC))
