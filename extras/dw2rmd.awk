

# simple script to get my dokuwiki slides partway-converted to .Rmd

# ignore the SLIDESHOW line
/~~SLIDE/ {next}

# get the main title and spew it into the yaml front matter
/^======/ {
  tit = $0
  gsub(/=/, "", tit)
  print "---"
  print "title:", tit
  print "layout: default"
  print "author: Eric C. Anderson"
  print "---"
  print ""
  print "#", tit
  next
}


# get slide titles and make them ##'s:
/^=====/ {
  tit = $0
  gsub(/=/, "", tit)
  print "##", tit
  next
}

# remove the R output lines (because we will evaluate those in Rmarkdown)
# this gets rid of the short output lines at least
/^ *\[1\]/ {next}

# get the line here
{
  line = $0

  # if it was ended with a \\, then make it end with a space-space
  gsub(/\\\\$/, "  ", line)

  # convert italics
  gsub(/\/\//, "_", line)

  # convert bold
  gsub(/\*\*/, "__", line)

  # convert inline code style
  gsub(/''/, "`", line)

  # convert <code R>'s into ```{r} fences, etc.  Try to put returns in there
  # where they might be needed.
  gsub(/^<code R>/, "```{r}", line)
  gsub(/<code R>/, "\n```{r}", line)
  gsub(/^<\/code>/, "```", line)
  gsub(/<\/code>/, "\n```", line)

  # strip the >'s out of the R code when they appear
  gsub(/^>. */,"",line)

  # now, if it is an itemized list, make it so in markdown.
  if(match(line, /^  \*/)) {
    if(inItems==1) {
      gsub(/^ *\*/, "* ", line)
    }
    else {
      gsub(/^ *\*/, "\n* ", line)
      inItems = 1
    }
  }
  else {
    if(inItems) {
      line = line "\n"
    }
    inItems = 0
  }



  # now, if it is an enumerate list, make it so in markdown.
  if(match(line, /^  -/)) {
    if(inEnums==1) {
      gsub(/^  -/, "1. ", line)
    }
    else {
      gsub(/^  -/, "\n1. ", line)
      inEnums = 1
    }
  }
  else {
    if(inEnums) {
      line = line "\n"
    }
    inEnums = 0
  }

  print line
}


