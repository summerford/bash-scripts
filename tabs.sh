#!/bin/bash

# to run script ./tabs.sh -s
browser=("Google Chrome" "Safari")

# Capture all open tabs for Safari or Chrome
b_list () {
    for b in "${browser[@]}"; do
        tab=0
        window=1

        # Use exit status of osascript as loop-breaker.
        while [[ $? != 1 ]]; do
            while [[ $? != 1 ]] ; do
                tab=$((tab+1))
                osascript -e "tell application \"${b}\" to get URL of tab $tab of window $window" 2> /dev/null
            done
            # Check for other windows, reseting tab counter.
            tab=1
            window=$((window+1))
            osascript -e "tell application \"${b}\" to get URL of tab $tab of window $window" 2> /dev/null
        done
    done
}

# Open list of URLs passed as command-line args w/ safari.
b_open () {
    for sites in "$@"; do
#        if [[ "$1" =~ "chrome" ]]; then
#            open -a /Applications/Google Chrome.app/ ${sites};
#        else
            open -a /Applications/Safari.app/ ${sites};
#        fi
    done
}

# Main execution thread
if [ "$1" != "" ]; then
    case $1 in
        -o | --open )       shift
                            b_open $(cat $1)
                            ;;
        -s | --save )       shift #save urls to file name <browser><date><time>
                            b_list >> "$(date "+%d%m%y.%H%M%S").tabs"
                            ;;
        -h | --help )       echo " -o open list of urls, -s save to dated file "
                            ;;
    esac
else
    b_list
fi

# Add command-line flag to -o (open), by default list.
