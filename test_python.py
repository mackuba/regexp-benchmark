#!/usr/bin/env python

import re
import sys

regexps = [
    re.compile(r'linux', re.IGNORECASE),
    re.compile(r'debian', re.IGNORECASE),
    re.compile(r'ubuntu', re.IGNORECASE),
    re.compile(r'\bredhat\b', re.IGNORECASE),
    re.compile(r'\bRHEL\b'),
    re.compile(r'\bSUSE\b'),
    re.compile(r'\bCentOS\b'),
    re.compile(r'\bopensuse\b', re.IGNORECASE),
    re.compile(r'\bslackware\b', re.IGNORECASE),
    re.compile(r'\bKDE\b'),
    re.compile(r'\bGTK\d?\b'),
    re.compile(r'#GNOME\b'),
    re.compile(r'\bGNOME\s?\d+'),
    re.compile(r'\bkde plasma\b', re.IGNORECASE),
    re.compile(r'apt-get'),
    re.compile(r'\bflatpak\b', re.IGNORECASE),
    re.compile(r'\b[Xx]org\b')
]

with open('posts.txt', 'r') as file:
    posts = file.readlines()

loops = int(sys.argv[1])
matched = 0

for _ in range(loops):
    for txt in posts:
        for r in regexps:
            if r.search(txt):
                matched += 1

print(matched / loops)
