
prompt-yes-no() {
	local answer=""
	while [[ ! "$answer" =~ ^yes$|^no$ ]]; do
		echo "$1(yes/no)"
		read answer
	done;
	[[ $answer == "yes" ]];
}