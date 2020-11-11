dir=$(pwd)
cd ~/code/work/$1
currentBranch=$(git branch --show-current) > /dev/null
currentPr=$(hub pr show) > /dev/null
cd $dir
echo $currentBranch $currentPr
