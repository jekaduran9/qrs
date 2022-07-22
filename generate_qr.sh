#/bin/bash
IDS=$1
DIR_OUT=$2
if [[ -z "$IDS" ]] || [[ -z "$DIR_OUT" ]]; then
  echo "you must provide a tsv file with the IDs and an output directory"
  echo "for example: generate_qr.sh carmina_ids.tsv carmina"
  exit 1
fi

mkdir -p $DIR_OUT

cat $IDS | xargs -I{} sh -c "export URL=\$(echo {} | awk '{print \"https://webapp.yumminn.com/\" \$1 }') && export TABLE=\$(echo {} | awk '{print \$2}') && qrencode -o $DIR_OUT/\$TABLE.black.png \$URL"
