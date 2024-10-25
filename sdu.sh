function sdu() {
    # Initialize variables
    param=""
    auto_yes=""
    show_help=0

    # Check for --help or -h and --refresh before parsing options with getopts
    for arg in "$@"; do
        if [ "$arg" = "--help" ] || [ "$arg" = "-h" ]; then
            show_help=1
            break
        elif [ "$arg" = "--refresh" ]; then
            param="--refresh"  # Set param to --refresh
        fi
    done

    # Parse options with getopts for -r and -y
    while getopts ":ry" option; do
        case $option in
            r) param="--refresh" ;;    # Add --refresh if -r is used
            y) auto_yes="-y" ;;         # Use non-interactive mode if -y is used
            *) echo "Invalid parameter -$OPTARG, use -h or --help for more information"; return 1 ;;
        esac
    done

    # If help flag is set, show help and exit
    if [ "$show_help" -eq 1 ]; then
        echo "Usage: $0 [flags]"
        echo "  -r, --refresh: Refresh package libraries"
        echo "  -h, --help: Display help"
        echo "  -y: Non-interactive mode (assume yes for all prompts)"
        return 0
    fi

    # Execute update commands
    sudo dnf upgrade $param $auto_yes && flatpak update $auto_yes
    return 0
}

