# call this with the quoted blog post title as the only argument

TITLE=$1
title=$(echo $TITLE | sed 's/  */-/g; s/[^-0-9a-zA-Z_]//g' | awk '{print tolower($1)}')
thedate=$(date "+%Y-%m-%d")
filename=_posts/${thedate}-$title.rmd

if [ -e $filename ]; then
  echo "$filename already exists"
  echo "Exiting..."
  exit 1
fi


echo "---
title: $TITLE
layout: default_with_disqus
output:
  html_document:
    toc: yes
  bookdown::html_chapter:
    toc: no
---

# $TITLE ($thedate)


" > $filename


