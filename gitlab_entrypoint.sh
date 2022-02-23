#!/bin/sh

#ambil token github apps. anggap aja url itu buat ngambil token lah ya. nanti dipindah ke url asli
result=$(wget -qO- http://168.138.160.59/api/access_token --header "Authorization: Bearer $API_TOKEN")

#ambil test file
git clone https://$result@github.com/laiba-dev/hello-flutter-test.git test

#config flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub get

#flutter test
flutter test --machine 2>test-runtime-errors.txt 1>test-result.txt

#move test log to flutter autogradign folder
cp ./test-result.txt /app/flutter-autograding/test-result.txt
cp ./test-runtime-errors.txt /app/flutter-autograding/test-runtime-errors.txt
cd /app/flutter-autograding

#run parser to generate and send summative and formative feedback
python3 main.py ./test-result.txt ./test-runtime-errors.txt $GITLAB_USER_LOGIN $CI_PROJECT_NAME $CI_PIPELINE_IID