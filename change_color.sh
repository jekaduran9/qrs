#/bin/bash
set -ex

DIR_OUT=$1
QR_COLOR=$2
BACKGROUND_COLOR=${3:-"#ffffff"}

if [[ -z "$DIR_OUT" ]] || [[ -z "$QR_COLOR" ]]; then
  echo "you must provide a directory with QR codes and a QR color"
  echo "for example: change_color.sh carmina #ff0000"
  exit 1
fi


find $DIR_OUT -name '*.black.png' | xargs -I{} sh -c "convert {} -fill '${QR_COLOR}' -opaque '#000' \$(echo {} | sed 's/.black.png/.new.png/')"

OPTS="-fill '${BACKGROUND_COLOR}' -opaque '#fff'"
if [[ "$BACKGROUND_COLOR" = "transparent" ]]; then
  OPTS="-transparent '#fff'"
fi

find $DIR_OUT -name '*.new.png' | xargs -I{} sh -c "export TMP=\$(mktemp) && convert {} $OPTS \$TMP && mv \$TMP {}"

