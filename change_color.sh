#/bin/bash
set -exu

DIR_OUT=$1
CURR_COLOR=$2
NEW_COLOR=$3

if [[ -z "$DIR_OUT" ]] || [[ -z "$CURR_COLOR" ]] || [[ -z "$NEW_COLOR" ]]; then
  echo "you must provide a directory with QR codes, a current color and a new color"
  echo "for example: change_color.sh carmina #ff0000 #0f0"
  exit 1
fi

for f in ${DIR_OUT}/*.png; do 
  echo "Processing $f file.."; 
  # change bakground
  OPTS="-fill ${NEW_COLOR} -opaque ${CURR_COLOR}"
  if [[ "$NEW_COLOR" = "transparent" ]]; then
    OPTS="-transparent ${CURR_COLOR}"
  fi
  TMP=$(mktemp)
  convert $f $OPTS $TMP
  mv $TMP $f
done


