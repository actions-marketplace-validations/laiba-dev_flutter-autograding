#!/bin/sh -l

#config flutter path
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub get

#flutter test
flutter test --machine 2>test-runtime-errors.txt 1>test-result.txt

#move test log files to autograding folder
cp /github/workspace/test-result.txt /app/flutter-autograding/test-result.txt

#run parser to generate summative and formative feedback
python3 /app/flutter-autograding/main.py /app/flutter-autograding/test-result.txt $GITHUB_ACTOR $GITHUB_REPOSITORY $GITHUB_ACTION