while read -r ip
    do
        if [[ $ip == "$1" ]]; then
            shift
            printf '%s\n' 'This IP is in the List'
        else
            printf '%s\n' 'IP Not Found'
        fi
    done < ./bambenek_banjori.ipset
