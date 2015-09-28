
color_lookup() {
    local COLOR="[0m"
    case $1 in
        black)      COLOR="[0;30m" ;;
        red)        COLOR="[0;31m" ;;
        green)      COLOR="[0;32m" ;;
        orange)     COLOR="[0;33m" ;;
        blue)       COLOR="[0;34m" ;;
        purple)     COLOR="[0;35m" ;;
        cyan)       COLOR="[0;36m" ;;
        light-gray) COLOR="[0;37m" ;;
        dark-gray)  COLOR="[1;30m" ;;
        light-red)  COLOR="[1;31m" ;;
        light-green)COLOR="[1;32m" ;;
        yellow)     COLOR="[1;33m" ;;
        light-blue) COLOR="[1;34m" ;;
        light-purple) COLOR="[1;35m" ;;
        light-cyan)   COLOR="[1;36m" ;;
        white)        COLOR="[1;37m" ;;
        off)          COLOR="[0m" ;;
    esac
    echo $COLOR
}

colorize() {
    local COLOR_OFF=$(color_lookup off)
    local COLOR=$(color_lookup $1)
    echo "\033${COLOR}$2\033${COLOR_OFF}"
}

printf_color(){
    local colorized=$(colorize $1 "$2")
    shift
    shift
    printf "$colorized" "$@"
}
