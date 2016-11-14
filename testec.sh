./striprados -p ecpool -j -r test

#interupted somehow
./striprados -p ecpool -j -u test ~/golang-bin-1.5.1-0.el6.x86_64.rpm

#get the size
size=$(./striprados -p ecpool -i test|awk -F\| '{print $2}')



#new pos
function round_down() {
	size=$1
	if [[ $size -le 4194304 ]];then
		echo 0
	fi
	echo "(($size-4194304)/5242880)*5242880" | bc
}

pos=$(round_down $size)

echo "new pos is $pos"


#truncate
if [[ $pos -gt 0 ]]; then
./striprados -p ecpool -t test -o $pos
fi


#upload from $pos
./striprados -p ecpool -j -u test ~/golang-bin-1.5.1-0.el6.x86_64.rpm -o $pos
