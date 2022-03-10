# Flutter Autograding

Autograding untuk flutter. Membaca hasil test dari flutter dan transform ke JSON yang bisa dibaca manusya dan dikirim ke API.

How to Use :

Untuk Github (Github Workflow / Action Script) : 
```
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the master branch
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: olah data
      uses: mirfanrafif/flutter-autograding@v0.13
```
