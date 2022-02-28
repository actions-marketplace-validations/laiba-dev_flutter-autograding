#!/bin/sh

# menghapus folder test
echo "Remove Existing Test Folder"
[ -d "test" ] && rm -R test

#ambil token github apps. anggap aja url itu buat ngambil token lah ya. nanti dipindah ke url asli
echo "Getting Access Token from Github"
result=$(wget -qO- http://168.138.160.59/api/access_token --header "Authorization: Bearer $API_TOKEN")

#ambil test file
echo "Cloning Test Files"
git clone https://$result@github.com/laiba-dev/hello-flutter-test.git test

#config flutter
export PATH="$PATH":"$HOME/.pub-cache/bin"
echo "Getting Dependencies for Flutter"
flutter pub get

#flutter test
echo "Running Flutter Test"
flutter test --machine 2>test-runtime-errors.txt 1>test-result.txt

#move test log to flutter autogradign folder
cp ./test-result.txt /app/flutter-autograding/test-result.txt
cp ./test-runtime-errors.txt /app/flutter-autograding/test-runtime-errors.txt
cd /app/flutter-autograding

#run parser to generate summative and formative feedback
echo "Running Parser"
python3 main.py ./test-result.txt ./test-runtime-errors.txt $GITLAB_USER_LOGIN $CI_PROJECT_NAME $CI_PIPELINE_IID
