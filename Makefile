BUILD_SRC=build/

.PHONY: all clean

# find all .asm files in nasm/ and fasm/ directories
NASM_SOURCES=$(shell find nasm -name "*.asm" 2>/dev/null)
FASM_SOURCES=$(shell find fasm -name "*.asm" 2>/dev/null)

# generate output file paths in build/ directory
NASM_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(NASM_SOURCES))
FASM_OBJECTS=$(patsubst %.asm,$(BUILD_SRC)/%.bin,$(FASM_SOURCES))

all: $(NASM_OBJECTS) $(FASM_OBJECTS)

$(BUILD_SRC)/nasm/%.bin: nasm/%.asm
	@mkdir -p $(dir $@)
	nasm -f bin $< -o $@

$(BUILD_SRC)/fasm/%.bin: fasm/%.asm
	@mkdir -p $(dir $@)
	fasm $< $@

clean:
	rm -rf $(BUILD_SRC)

$(shell mkdir -p $(BUILD_SRC))
