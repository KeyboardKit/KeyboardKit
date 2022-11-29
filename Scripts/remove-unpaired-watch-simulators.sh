xcrun simctl list --json > simulators.json
watch_os_udids=$(jq '.devices[] | map(select(.name | contains("Watch"))) | .[].udid' simulators.json -r)
paired_watch_udids=$(jq '.pairs | map(.watch) | .[].udid' simulators.json -r)

while IFS= read -r udid; do
    if [[ ! "${paired_watch_udids[*]}" =~ "${udid}" ]]; then
        echo ${udid}
    fi
done <<< "$watch_os_udids"