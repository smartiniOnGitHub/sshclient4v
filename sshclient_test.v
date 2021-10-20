import sshclient

fn test_hello() {
	println('${@FN}')
	assert true
	sshclient.hello()
	assert true
}
