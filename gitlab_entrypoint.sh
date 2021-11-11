#!/bin/sh

cp ./test-result.txt /app/flutter-autograding/test-result.txt
ls /app/flutter-autograding
cd /app/flutter-autograding
python3 main.py ./test-result.txt $GITLAB_USER_LOGIN $CI_PROJECT_NAME $CI_PIPELINE_IID