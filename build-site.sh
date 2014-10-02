# put default values here
SERVE_LOCAL=0
CONFIG=""
DEPLOY_IT=0


function usage {
      echo Syntax:
      echo "  $(basename $0)  [-l -h]"
      echo
      echo "Options:"
      echo "     -h :  print out a list of options"
      echo "     -l :  build site and serve it locally using jekyll server"
      echo "     -d :  build site locally and copy _site contents to rep-res-web to host on GitHub."
}


while getopts ":hld" opt; do
    case $opt in
	h    )
	    usage
	    exit 1
	    ;;
	l    )  SERVE_LOCAL=1
					CONFIG=" --config _config.yml,_config_test.yml "
	    ;;
  d    )  DEPLOY_IT=1
	    ;;
	\?   )
	    usage
	    exit  1
	    ;;
    esac
done

shift $((OPTIND-1));


# uncomment to test for right number of required args
if [ $# -ne 0 ]; then
    usage;
    exit 1;
fi


# uncomment to process a series of remaining parameters in order
#while (($#)); do
#    VAR=$1;
#    shift;
#done


if [ $SERVE_LOCAL -eq 1 ] && [ $DEPLOY_IT -eq 1 ]; then
  echo "You can't give both the -l and the -d options.  Exiting..."
  exit 1
fi

jekyll build  $CONFIG


# now, move the figures made while knitting
# to the appropriate locations
mv lecture_figs _site/lectures/
mv blog_figs _site/blog/


# and also render the index.rmd to PDF and WORD formats
# but only if index.rmd has changed from the previous version or
# if the files index.pdf and index.docx are missing
shasum index.rmd > .temp_shasum
if cmp .temp_shasum extras/index_shasum.txt; then
  echo; echo "index.rmd unchanged. No-need to re-render PDF and WORD formats if they already exist"; echo
  rm .temp_shasum
else
  echo; echo "index.rmd changed. Re-rendering PDF and WORD formats"; echo
  Rscript extras/render_welcome.R
  mv .temp_shasum extras/index_shasum.txt
fi


# if they don't exist, however, re-render them
if [ ! -f word_and_pdf/index.pdf ] || [ ! -f word_and_pdf/index.docx ]; then
  echo; echo "PDF and WORD formats of index.rmd not found.  Re-rendering..."; echo
  Rscript extras/render_welcome.R
fi

# at the end of that, we copy the word_and_pdf directory into _site
cp -r word_and_pdf _site/


# and here if we are doing it locally we just need to start the jekyll server
if [ $SERVE_LOCAL -eq 1 ]; then
	jekyll serve --no-watch -V --skip-initial-build $CONFIG
fi


# and here we push it to rep-res-web
if [ $DEPLOY_IT -eq 1 ]; then
  echo "Copying to rep-res-web...."
  rm -rf ../rep-res-web/*
  cp -r  _site/* ../rep-res-web/

  echo "

Cool Beans. Now, go ahead and push those changes to github pages:
    cd ../rep-res-web
    git add .
    git commit
    git push origin gh-pages
"
fi



