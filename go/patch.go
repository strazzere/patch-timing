package main

import (
	"fmt"
	"os"
	"time"
)

func patchFile(filename string, bytes []byte, offset int64) error {
	file, err := os.OpenFile(filename, os.O_RDWR, 0644)
	if err != nil {
		return err
	}
	defer file.Close()

	_, err = file.Seek(offset, 0)
	if err != nil {
		return err
	}

	_, err = file.Write(bytes)
	return err
}

func main() {
	start := time.Now()

	filename := "randomblock"
	bytes := []byte("d1ffd1ff")
	offset := int64(100)

	err := patchFile(filename, bytes, offset)
	if err != nil {
		panic(err)
	}

	duration := time.Since(start)
	fmt.Printf("Time taken: %v (go)\n", duration)
}
