# Work related Functions

function gitcommitcheck() {
    currentbranch=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f2)
    if [[ $currentbranch =~ 'CSEAV-[0-9]{4}' ]]
    then
        if [[ ! -z $1 ]]
        then
            commitname=$(echo $currentbranch-$1)
            git commit -m $currentbranch: $1
        else
            echo 'No Changes specified'
        fi
    else
        echo 'Not IN Shop Repo'
    fi
}

function gitcommitcheckpupf() {
    currentbranch=$(git branch | grep \* | cut -d ' ' -f2 | cut -d '/' -f2)
    if [[ $currentbranch =~ 'CSEAV-[0-9]{4}' ]]
    then
        if [[ ! -z $1 ]]
        then
            commitname=$(echo $currentbranch-$1)
            git commit -m fix($currentbranch): $1
        else
            echo 'No Changes specified'
        fi
    else
        echo 'Not IN Pupf Repo'
    fi
}

# Random

function darkTheme() {
}
