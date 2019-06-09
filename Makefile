
vpath %.asm src
vpath %.inc include

RM       = rm -f

OBJS     = main.o
LSTS     = $(patsubst %.o,%.lst,$(OBJS))

AS       = nasm
ASFLAGS  = -felf64 -gdwarf -O0

LD       = ld
LDFLAGS  = -b elf64-x86-64

TARGET   = gcd

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $^

listings: $(LSTS)

%.lst: %.asm
	$(AS) $(ASFLAGS) -l $@ $^

.PHONY: clean
clean:
	$(RM) $(LSTS) $(OBJS) $(TARGET)

