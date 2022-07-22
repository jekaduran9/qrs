# QR code generator

## Generating QRs

1. create a file named ids.tsv. The file should have as first column the UUIDs of the table and in the second column the number of the table
2. run ./generate_qrs.sh. This script will generate a QR code for each of the tables in the ids.tsv file. The name of the QRs is going to follow the format `<table number>.black.png`
3. run ./change_color.sh. This script will change the color of the original QR codes. The name of the changed QRs is going to follow the format `<table number>.new.png`


