#!/usr/bin/zsh

BLUE='\033[1;34m'
NC='\033[0m'
local_add=0
add_files=0
location=$(pwd)
separating_element_from_array ()
{

    for el in $@
        do
            case_function ${el}
        done

    if [ $add_files -lt 1 ]; then
        echo -e "${BLUE} Adding all files! ${NC}"
        cd $location && git add .
    else
        ls
        echo -e "${BLUE}"
        read -p "Name file[s] to add: " docname
        echo -e "${NC}"
        cd $location && git add $docname
    fi

    echo -e "${BLUE}"
    read -p "Commit Message: " commitmesage
    echo -e "${NC}"
    cd $location && git commit -m "$commitmesage"

    if [ $local_add -lt 1 ]; then
        echo -e "${BLUE}"
        read -p "Origin Name: " originname
        echo -e "${NC}"
        echo -e "${BLUE} Pushing... ${NC}"
        cd $location && git push origin $originname
    fi

}
case_function()
{
    case $1 in
        --help )
            echo -e "${BLUE}ARGUMENTS: ${NC}"
            echo -e "${BLUE} -l: local adding files in git without pushing to an external git repository ${NC}"
            echo -e "${BLUE} -a: adding only the specified files in git ${NC}"
            echo -e "${BLUE} --help: shoing help $1 ${NC}"
            exit
        ;;
        -l )
            local_add=1
        ;;
        -a )
            add_files=1
        ;;
        * )
            echo -e "${BLUE}>>>> THIS ARGUMENT DON'T EXIST! ${NC}"
        ;;
    esac
}

if [ $# -gt 3 ]; then
    echo -e "${BLUE}>>>> INCORECT SINTAX ${NC}"
else
  separating_element_from_array $@
fi


