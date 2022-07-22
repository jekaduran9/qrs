#/bin/bash

cat ids.tsv | xargs -I{} sh -c "export URL=\$(echo {} | awk '{print \"https://webapp.yumminn.com/\" \$1 }') && export TABLE=\$(echo {} | awk '{print \$2}') && qrencode -o \$TABLE.black.png \$URL"
