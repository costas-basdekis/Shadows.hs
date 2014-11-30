#!/usr/bin/env bash

COLOR_OK=$(echo -e "\e[42m")
COLOR_ERROR=$(echo -e "\e[105m")
COLOR_FAIL=$(echo -e "\e[101m")
COLOR_RESET=$(echo -e "\e[0m")

runghc tests.hs "$@" 2>&1 | sed -r "
    # Color the tests results
    s/(### Failure in:.*)/${COLOR_FAIL}\1${COLOR_RESET}/;
    s/(### Error in:.*)/${COLOR_ERROR}\1${COLOR_RESET}/;
    # Color the summaries
    s/([Ff]ailures\s?[:=] [^0]\d*)/${COLOR_FAIL}\1${COLOR_RESET}/;
    s/([Ee]rrors\s?[:=] [^0]\d*)/${COLOR_ERROR}\1${COLOR_RESET}/;
    s/(C.*[Ee]rrors\s?[:=] 0[ ,] [Ff]ailures\s?[:=] 0}?)/${COLOR_OK}\1${COLOR_RESET}/;
"
