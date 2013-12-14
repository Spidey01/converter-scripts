#!/bin/sh

for VIDEO; do
    ffprobe "$VIDEO" 2>&1 | grep -iE input\|stream\|title | grep -vi chapter | grep -v '^\['
done
