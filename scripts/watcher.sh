#!/bin/bash
MONITORDIR="/ftp/$USER/files/"

inotifywait -m -r  --format '%w%f' "${MONITORDIR}" -e moved_to -e create |
        while read -r path; do                
            filepath="${path}"                        
            echo "pasta: '${path}'"            
        done