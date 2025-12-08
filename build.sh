#!/bin/bash

crystal build test_crystal.cr -o build/test_crystal

swiftc test_swift_native.swift -O -o build/test_swift_native
swiftc test_swift_ns.swift -O -o build/test_swift_ns

cd ObjC
swift build
