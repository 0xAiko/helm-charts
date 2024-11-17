#!/usr/bin/env bash

TARGETS=(Chart.yaml README.md)
BUMP_TYPE="patch"

usage() {
    cat <<EOF
Usage: $0 [OPTION...] CHART

Example: ./bump-version.sh -t patch microservice
CHART can be chart name or path to chart root

Options:
    -t          type of version to bump,
                one of major,minor,patch. (default: patch)
    -d          dry run

    -h          print this help message
EOF
}

if [ $# == 0 ]; then
    usage
    exit 0
fi

args=()
while [ $OPTIND -le "$#" ]; do
    if getopts t:dh opt; then
        case $opt in
        t)
            case "$OPTARG" in
            major | minor | patch)
                BUMP_TYPE="$OPTARG"
                ;;
            *)
                echo "Error: type can only be one of major|minor|patch, not '$OPTARG'"
                exit 1
                ;;
            esac
            ;;
        d) dryrun='true';;
        ? | h)
            usage
            exit 0
            ;;
        esac
    else
        args+=("${!OPTIND}")
        ((OPTIND++))
    fi
done
CHART=${args[@]:0:1}

if [[ -z "$CHART" ]]; then
    echo "Error: CHART is required."
    usage
    exit 1
fi

[ -f "charts/$CHART/Chart.yaml" ] && chartyaml="charts/$CHART/Chart.yaml"
[ -f "$CHART/Chart.yaml" ] && chartyaml="$CHART/Chart.yaml"

if [[ -f $chartyaml ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        current=$(grep -E '^version: [0-9]+\.[0-9]+\.[0-9]+' "$chartyaml" | awk '{print $2}')
    else
        current=$(grep -oP '^version:\s*\K\d+\.\d+\.\d+' "$chartyaml")
    fi

    if [[ "$current" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Current version: $current"

        IFS=. read -r major minor patch <<<"$current"
        unset IFS
        case $BUMP_TYPE in
        major)
            new="$((major + 1)).0.0"
            ;;
        minor)
            new="$major.$((minor + 1)).0"
            ;;
        patch)
            new="$major.$minor.$((patch + 1))"
            ;;
        esac

        echo "Bumping $BUMP_TYPE version of chart '$CHART': $current -> $new"
    else
        echo "Error: Invalid version format in '$chartyaml'. Expected format: x.y.z"
        exit 3
    fi
else
    echo "Error: Chart '$CHART' not found."
    exit 2
fi

dir=$(dirname "$chartyaml")
for f in "${TARGETS[@]}"; do
    if [[ -f "$dir/$f" ]]; then
        echo "Processing file $dir/$f"
        [[ "$dryrun" ]] && continue
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|$current|$new|g" "$dir/$f"
        else
            sed -i "s|$current|$new|g" "$dir/$f"
        fi
    fi
done

[[ "$dryrun" ]] && echo "Dry run complete. No changes were made."
echo "Done!"
