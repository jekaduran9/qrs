#/bin/bash
set -ex
IDS=$1
DIR_OUT=$2
if [[ -z "$IDS" ]] || [[ -z "$DIR_OUT" ]]; then
  echo "you must provide a tsv file with the IDs and an output directory"
  echo "for example: generate_qr.sh carmina_ids.tsv carmina"
  exit 1
fi
rm  $DIR_OUT/*.png || true
mkdir -p $DIR_OUT

while IFS="" read -r p || [ -n "$p" ]
do
  URL=$(echo $p | awk '{print "https://webapp.yumminn.com/" $1}')
  TABLE=$(echo $p | awk '{print $2}')
  echo "url: $URL"
  echo "table: $TABLE"
  qrencode -o $DIR_OUT/$TABLE.png $URL
done < $IDS

