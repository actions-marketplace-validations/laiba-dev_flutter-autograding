#!/bin/sh -l

#ambil token github apps. anggap aja url itu buat ngambil token lah ya. nanti dipindah ke url asli
result=$(wget -qO- http://168.138.160.59/api/access_token --header "Authorization: Bearer $API_TOKEN")

#ambil test file
git clone https://$result@github.com/laiba-dev/hello-flutter-test.git test

#config flutter path
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutter pub get

#flutter test
flutter test --machine 2>test-runtime-errors.txt 1>test-result.txt

#move test log files to autograding folder
cp ./test-result.txt /app/flutter-autograding/test-result.txt
cp ./test-runtime-errors.txt /app/flutter-autograding/test-runtime-errors.txt

#run parser to generate summative and formative feedback
python3 /app/flutter-autograding/main.py /app/flutter-autograding/test-result.txt /app/flutter-autograding/test-runtime-errors.txt $GITHUB_ACTOR $GITHUB_REPOSITORY $GITHUB_ACTION