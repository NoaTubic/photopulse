#!/bin/bash

totalLines=0
testedLines=0

generateCovMessage="Run 'bash gencov.sh' in order to generate code coverage."

# Get the named parameters --threshold, --severity
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"*  ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done


if [ -z "$threshold" ]; then
  echo "Please provide the coverage threshold using the --threshold option" && exit 1
fi
if [[ ! -d coverage ]];then
  echo "$generateCovMessage" && exit 0
fi

lines=`cat coverage/lcov.info`
for line in $lines; do
 firstPart=${line:0:2}
 if [[ "$firstPart" == "LF" ]]; then
   count=`cut -d ":" -f2 <<< $line""`
   totalLines=$(($totalLines + $count)) 
 fi

 if [[ "$firstPart" == "LH" ]]; then
   testedCount=`cut -d ":" -f2 <<< $line`
   testedLines=$(($testedLines + $testedCount))
 fi
done

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
coverage=$(bc <<< "scale=3; $testedLines / $totalLines")
if (( $(echo "$coverage < $threshold" | bc -l) )); then
   # No Color
  printf "${RED}Code coverage too low: minimum: ${threshold} acctual ${coverage}.\n${NC}${generateCovMessage}\n"
  if [[ "$severity" == "error" ]]; then
    exit 1
  fi
else
  printf "${GREEN}Code coverage test passed: minimum: ${threshold} acctual ${coverage}.\n${NC}"
fi