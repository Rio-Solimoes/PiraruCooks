#!/bin/bash

if [ "$1" == "nokill" ]; then
    echo "Skipping killall"
else
    killall Xcode
fi

rm -rf PiraruCooks.xcodeproj 
xcodegen
open PiraruCooks.xcodeproj