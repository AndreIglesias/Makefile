#!/usr/bin/env bash

LIB='git@github.com:andreiglesias/libft.git'
HEADERS=./include
SRC=./src

git submodule add $LIB
mkdir -p $HEADERS $SRC
