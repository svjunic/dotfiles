#!/bin/bash

# USBで接続されているデバイス一覧
#adb devices -l

# browserのコンソールログだけ見る
adb logcat | grep Console
