CC = gcc
CFLAGS = -Wall -Wextra -Werror -O2 -g -Iinclude -pthread
BIN_DIR = bin

all: $(BIN_DIR)/thread_checksum_lab

check: all
	bash ./scripts/check.sh

grade: all
	bash ./scripts/grade.sh

$(BIN_DIR)/thread_checksum_lab: src/thread_checksum_lab.c include/thread_checksum_lab.h
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(BIN_DIR)/thread_checksum_lab

.PHONY: all check grade clean