#/bin/bash
set -exu

DIR_OUT=$1
TEMPLATE=$2

if [[ -z "$DIR_OUT" ]] || [[ -z "$TEMPLATE" ]]; then
  echo "you must provide a directory with QR codes and a TEMPLATE"
  exit 1
fi

for f in ${DIR_OUT}/*.png; do 
  echo "Processing $f file.."; 
  # change bakground
  export QR_BASE64=$(base64 $f)
  export TABLE_ID=$(echo $f | sed "s|${DIR_OUT}/||" | sed 's|.png||')
  export ROTATE=""
  if [[ $(echo $TABLE_ID | wc -c) -gt 4 ]]; then
    ROTATE="rotate(-90)"
  fi
  
   envsubst '$TABLE_ID;$ROTATE;$QR_BASE64' < $TEMPLATE > "$DIR_OUT/$TABLE_ID.svg"
done

rm $DIR_OUT/*.svg.png || true
qlmanage -t -s 990 -o $DIR_OUT $(find $DIR_OUT -name '*.svg')
