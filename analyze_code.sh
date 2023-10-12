#!/bin/bash

linter_report=`flutter pub run dart_code_metrics:metrics analyze lib`

warnings_count=`echo $linter_report | grep -o 'WARNING' | wc -l`
alarm_count=`echo $linter_report | grep -o 'ALARM' | wc -l`
error_count=`echo $linter_report | grep -o 'ERROR' | wc -l`

if [ $warnings_count -gt 0  ] || [ $alarm_count -gt 0  ] || [ $error_count -gt 0  ]; then
    echo "Please fix all errors, warnings and alarms."
    flutter pub run dart_code_metrics:metrics analyze lib -r html
    open metrics/index.html
    exit 1
fi

exit 0