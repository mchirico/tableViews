#!/bin/bash
cd tv
xcodebuild clean build -project tv.xcodeproj -scheme tv CODE_SIGNING_REQUIRED=NO -destination 'platform=iOS Simulator,name=iPhone X,OS=12.0' -quiet
xcodebuild test -project tv.xcodeproj -scheme tv -destination 'platform=iOS Simulator,name=iPhone X,OS=12.0'  -enableCodeCoverage  YES -quiet
