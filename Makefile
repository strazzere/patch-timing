TEST_BLOB = randomblock

C_SRC = c/patch.c
GO_SRC = go/patch.go
RUST_SRC = rust/patch.rs

C_BIN = patch-c
GO_BIN = patch-go
RUST_BIN = patch-rust

all: clean $(GO_BIN) $(RUST_BIN) $(C_BIN) $(TEST_BLOB) test

$(C_BIN): $(C_SRC)
	gcc -O3 -march=native -funroll-loops -flto $(C_SRC) -o $(C_BIN)

$(GO_BIN): $(GO_SRC)
	go build -o $(GO_BIN) $(GO_SRC)

$(RUST_BIN): $(RUST_SRC)
	rustc $(RUST_SRC) -o $(RUST_BIN)

$(TEST_BLOB):
	dd if=/dev/urandom of=$(TEST_BLOB) bs=1M count=512

test:
	./patch-rust && ./patch-go && ./patch-c && ./shell/patch.sh

clean:
	rm -f $(C_BIN) $(GO_BIN) $(RUST_BIN) $(TEST_BLOB)