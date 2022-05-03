#!/bin/bash
cd log_directory
zip logfiles.zip Log*.txt
mv logfiles.zip ./archive_directory
chmod +x diskcleanup.sh
./diskcleanup
