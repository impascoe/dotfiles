function sdu() {
    # Initialize variables
    param=""
    auto_yes=""
    show_help=0

    # Check for --help manually before parsing options with getopts
    for arg in "$@"; do
        if [ "$arg" = "--help" ]; then
            show_help=1
            break
        fi
    done

    # Parse options with getopts
    while getopts ":rhy" option; do
        case $option in
            r) param="--refresh" ;;    # Add --refresh if -r is used
            h) show_help=1 ;;           # Show help if -h is used
            y) auto_yes="-y" ;;         # Use non-interactive mode if -y is used
            *) echo "Invalid parameter -$OPTARG, use -h or --help for more information"; return 1 ;;
        esac
    done

    # If help flag is set, show help and exit
    if [ "$show_help" -eq 1 ]; then
        echo "Usage: $0 [flags]"
        echo "  -r: Refresh package libraries"
        echo "  -h, --help: Display help"
        echo "  -y: Non-interactive mode (assume yes for all prompts)"
        return 0
    fi

    # Execute update commands
    sudo dnf upgrade $param $auto_yes && flatpak update $auto_yes
    return 0
}
