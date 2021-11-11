#!/bin/sh -l

echo $GITHUB_WORKSPACE

ls -la /github/workspace

ls /app/flutter-autograding

cp /github/workspace/test-result.txt /app/flutter-autograding/test-result.txt

ls /app/flutter-autograding

python3 /app/flutter-autograding/main.py /app/flutter-autograding/test-result.txt $GITHUB_ACTOR $GITHUB_REPOSITORY $GITHUB_ACTION