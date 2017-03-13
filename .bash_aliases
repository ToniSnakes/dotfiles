# personal aliases
azi() {
    echo -n "Azi ii: "
    date +"%A, %-d %B, %Y"
}

pcpp() {
    if [ "$1" != "" ]; then
        mkdir ./$1
        cd ./$1
        vim $1.cpp
    else 
	echo "Da-i dracului un nume!"
    fi
}

inn() {
    if [ "$1" != "" ]; then
        mkdir ./$1
        cd ./$1
    else
        echo "Da-i dracului un nume!"
    fi
}
