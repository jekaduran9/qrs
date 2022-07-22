#/bin/bash
ls *.black.png | xargs -I{} sh -c "convert {} -fill '#FA4515' -opaque 'rgb(0,0,0)' \$(echo {} | sed 's/.black.png/.new.png/')"

