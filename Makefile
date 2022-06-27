CC := gcc
DBGFLAGS := -g
CCFLAGS := -Wall
CCOBJFLAGS := $(CCFLAGS) -c
LDFLAGS :=

# PATHS
SRC_DIR := ./src
HDR_DIR := ./include

SRCS := $(wildcard $(SRC_DIR)/*.c*)
HDRS := $(wildcard $(HDR_DIR)/*.h*)
OBJS := $(patsubst %.c,%.o,$(wildcard *.c))

TARGET := hello
TARGET_DIR :=

$(BIN): $(OBJ)
	$(CC) $(CCFLAGS) $(LDFLAGS) -o $(TARGET) $(OBJS)

$(BUILD)/%.o: %.c
	$(CC) $(CFLAGS) $(LDFLAGS) -I$(HDR_DIR) -c $< -o $@

# release builds
.PHONY: win64 mkdir-release
win64: mkdir-release

.PHONY: win32 cleanall
win32: cleanall mkdir-release

.PHONY: arm64 cleanall
arm64: cleanall mkdir-release


# debug builds
.PHONY: win64-debug cleanall
win64-debug: cleanall mkdir-debug

.PHONY: win32-debug mkdir-debug
TARGET_DIR := ./build/win32
BIN_DIR := $(TARGET_DIR)/bin
OBJ_DIR := $(TARGET_DIR)/obj
win32-debug: cleanall mkdir-debug

.PHONY: arm64-debug cleanall mkdir-debug
arm64-debug: cleanall mkdir-debug


# make directories
.PHONY: mkdir-all mkdir-release mkdir-debug
mkdir-all: mkdir-base mkdir-release mkdir-debug

.PHONE: mkdir-base
mkdir-base:
	@$(shell mkdir -p $(TARGET_DIR)/$(BIN_DIR) $(TARGET_DIR)/$(OBJ_DIR))

.PHONE: mkdir-release mkdir-base
mkdir-release: mkdir-base
	@$(shell mkdir -p $(TARGET_DIR)/$(BIN_DIR))

.PHONE: mkdir-debug mkdir-base
mkdir-debug: mkdir-base
	@$(shell mkdir -p $(TARGET_DIR)/$(DBG_DIR))

# clean functions
.PHONY: cleanall cleanbin cleanobj cleanbuild cleandebug
cleanall: cleanbin cleanobj cleanbuild cleandebug

.PHONE: clean-bin
clean-bin:
	@rm -rf $(BIN_DIR)

.PHONE: clean-obj
clean-obj:
	@rm -rf $(OBJ_DIR)

.PHONE: clean-build
clean-build:
	@rm -rf $(BLD_DIR)

.PHONE: clean-debug
clean-debug:
	@rm -rf $(DBG_DIR)
