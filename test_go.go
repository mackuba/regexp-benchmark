package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"strconv"
)

func main() {
	// Read text from file
	text, err := ioutil.ReadFile("posts.txt")
	if err != nil {
		log.Fatalf("Error reading text file: %v", err)
	}

	// Split text into lines
	lines := regexp.MustCompile(`\r?\n`).Split(string(text), -1)

	regexps := []*regexp.Regexp{
		regexp.MustCompile(`(?i)linux`),
		regexp.MustCompile(`(?i)debian`),
		regexp.MustCompile(`(?i)ubuntu`),
		regexp.MustCompile(`\bredhat\b`),
		regexp.MustCompile(`\bRHEL\b`),
		regexp.MustCompile(`\bSUSE\b`),
		regexp.MustCompile(`\bCentOS\b`),
		regexp.MustCompile(`(?i)\bopensuse\b`),
		regexp.MustCompile(`(?i)\bslackware\b`),
		regexp.MustCompile(`\bKDE\b`),
		regexp.MustCompile(`\bGTK\d?\b`),
		regexp.MustCompile(`#GNOME\b`),
		regexp.MustCompile(`\bGNOME\s?\d+`),
		regexp.MustCompile(`(?i)\bkde plasma\b`),
		regexp.MustCompile(`apt-get`),
		regexp.MustCompile(`(?i)\bflatpak\b`),
		regexp.MustCompile(`\b[Xx]org\b`),
	}

	if len(os.Args) != 2 {
		fmt.Println("Usage: go run main.go <iterations>")
		return
	}

	iterationsStr := os.Args[1]
	iterations, err := strconv.Atoi(iterationsStr)
	if err != nil {
		fmt.Println("Error parsing iterations:", err)
		return
	}

	totalMatches := 0

	for i := 0; i < iterations; i++ {
		for _, line := range lines {
			for _, r := range regexps {
				if r.MatchString(line) {
					totalMatches++
					break // Move to the next line if a match is found
				}
			}
		}
	}

	fmt.Printf("Total matches: %d\n", totalMatches / iterations)
}
