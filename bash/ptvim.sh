#!/bin/bash

function ptvim () {
  vim $(pt $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
