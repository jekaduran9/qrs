#/bin/bash
set -exu

DIR_OUT=$1

if [[ -z "$DIR_OUT" ]]; then
  echo "you must provide a directory with QR codes"
  exit 1
fi

for f in ${DIR_OUT}/*.png; do 
  echo "Processing $f file.."; 
  # change bakground
  export QR_BASE64=$(base64 $f)
  export TABLE_ID=$(echo $f | sed "s|${DIR_OUT}/||" | sed 's|.png||')
  export ROTATE=""
  if [[ $(echo $TABLE_ID | wc -c) -gt 3 ]]; then
    ROTATE="rotate(-90)"
  fi
  
   envsubst '$TABLE_ID;$ROTATE;$QR_BASE64' < template-carmina.svg > "$DIR_OUT/$TABLE_ID.svg"
done
