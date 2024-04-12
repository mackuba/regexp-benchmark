#!/bin/bash

crystal build test_crystal.cr -o build/test_crystal
swiftc test_swift_native.swift -o build/test_swift_native
swiftc test_swift_ns.swift -o build/test_swift_ns

cd ObjC
swift build
