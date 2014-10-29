
# this is a simple script to export svg's to png's at the specified
# width in pixels, I suppose.  (it will scale height appropriately too.)


# put default values here
WIDTH=400
DIR=.

# this is not portable...
inkscape="/Applications/Inkscape.app/Contents/Resources/bin/inkscape"

function usage {
      echo Syntax:
      echo "  $(basename $0)  [-w width -d dir] FileName1.svg FileName2.svg, ..."
      echo "
Convert svg files into a png with with of width pixels (default = 400).
Put the png file in the directory dir default = ../diagrams.
      "
}

if [ $# -eq 0 ]; then
    usage;
    exit 1;
fi;

while getopts ":hw:d:" opt; do
    case $opt in
  h    )
	    usage
	    exit 1
	    ;;
	w    )  WIDTH=$OPTARG;
	    ;;
  d    )  DIR=$OPTARG;
	    ;;
	\?   )
	    usage
	    exit  1
	    ;;
    esac
done

shift $((OPTIND-1));


# uncomment to test for right number of required args
if [ $# -lt 1 ]; then
    usage;
    exit 1;
fi



# uncomment to process a series of remaining parameters in order
while (($#)); do
    SVG=$1;   # the SVG file
    PNG=${SVG/.svg/.png}

    WD=$($inkscape -z -W $SVG)
    HT=$($inkscape -z -H $SVG)

    FACTOR=$(echo $WD $WIDTH | awk '{print $2/$1}')

    nWD=$(echo $WD $FACTOR | awk '{print $1 * $2}')
    nHT=$(echo $HT $FACTOR | awk '{print $1 * $2}')

    $inkscape -z -e $DIR/$PNG -w $nWD -h $nHT  -D  $SVG

    echo $VAR

    shift;
done
