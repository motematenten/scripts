#!/bin/sh

for index in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
do
array=()
if [ `expr $index % 2` -eq 0 ]; then
  array+=(',')
  array+=('tag1')
fi

if [ `expr $index % 3` -eq 0 ]; then
  array+=(',')
  array+=('tag2')
fi

if [ `expr $index % 5` -eq 0 ]; then
  array+=(',')
  array+=('tag3')
fi

if [ ${#array[@]} -eq 2 ]; then
  unset array[0]
fi

if [ ${#array[@]} -eq 4 ]; then
  unset array[0]
fi

if [ ${#array[@]} -eq 6 ]; then
  unset array[0]
fi

html_body(){

echo "---
title: $index
tags: ${array[@]}
---
## this article is $index
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"
}

touch ./source/news/jp/2017-12-21-$index.html.markdown
html_body > ./source/news/jp/2017-12-21-$index.html.markdown
done

for index in 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
do
array=()
if [ `expr $index % 2` -eq 0 ]; then
  array+=(',')
  array+=('tag1')
fi

if [ `expr $index % 3` -eq 0 ]; then
  array+=(',')
  array+=('tag2')
fi

if [ `expr $index % 5` -eq 0 ]; then
  array+=(',')
  array+=('tag3')
fi

if [ ${#array[@]} -eq 2 ]; then
  unset array[0]
fi

if [ ${#array[@]} -eq 4 ]; then
  unset array[0]
fi

if [ ${#array[@]} -eq 6 ]; then
  unset array[0]
fi

html_body(){

echo "---
title: $index
tags: ${array[@]}
---
## this article is $index
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"
}

touch ./source/events/jp/2017-12-21-$index.html.markdown
html_body > ./source/events/jp/2017-12-21-$index.html.markdown
done

