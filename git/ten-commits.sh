#!/bin/sh

git checkout -b sample
touch sample.rb
for i in 1 2 3 4 5 6 7 8 9 10
do
  echo "commit number $i" > sample.rb 
  git add .
  git commit -m "$i"
done
