## Build
```bash
make
```

## Run

### x16:
```bash
qemu-system-i386 -fda /build/<assembler>/x16/<program>.bin
```

### x86:
```bash
./build/<assembler>/x86/<program>
```

## Debug

### x16:
```bash
qemu-system-i386 -fda /build/<assembler>/x16/<program>.bin -s
gdb
    target remote :1234
    # continue
    # info register ax
```

### x86:
```bash
gdb ./build/<assembler>/x86/<program>
    layout asm
    break main
    run
    # stepi
    # info register eax
```
