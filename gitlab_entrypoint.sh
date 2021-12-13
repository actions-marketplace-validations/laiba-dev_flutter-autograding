#!/bin/sh

#config flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub get

#flutter test
flutter test --machine 2>test-runtime-errors.txt 1>test-result.txt

#install python3
apt install python3 -y

#move test log to flutter autogradign folder
cp ./test-result.txt /app/flutter-autograding/test-result.txt
cp ./test-runtime-errors.txt /app/flutter-autograding/test-runtime-errors.txt
cd /app/flutter-autograding

#run parser to generate and send summative and formative feedback
python3 main.py ./test-result.txt $GITLAB_USER_LOGIN $CI_PROJECT_NAME $CI_PIPELINE_IID