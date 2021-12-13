#!/bin/sh

#config flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub get

#flutter test
flutter test --machine |& tee test-result.txt

#install python3
sudo apt install python3

#move test log to flutter autogradign folder
cp ./test-result.txt /app/flutter-autograding/test-result.txt
cd /app/flutter-autograding

#run parser to generate and send summative and formative feedback
python3 main.py ./test-result.txt $GITLAB_USER_LOGIN $CI_PROJECT_NAME $CI_PIPELINE_IID