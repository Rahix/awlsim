# command line interface tests

sh_test()
{
	local interpreter="$1"

	cd "$rootdir" || die "Failed to change to rootdir '$rootdir'"


	# check awlsim-test executable

	"$interpreter" ./awlsim-test -h >/dev/null ||\
		test_failed "Call to awlsim-test -h failed"
	"$interpreter" ./awlsim-test --help >/dev/null ||\
		test_failed "Call to awlsim-test -h failed"

	"$interpreter" ./awlsim-test -I dummy >/dev/null ||\
		test_failed "Call to awlsim-test -I dummy failed"
	"$interpreter" ./awlsim-test --hardware-info dummy >/dev/null ||\
		test_failed "Call to awlsim-test --hardware-info dummy failed"

	"$interpreter" ./awlsim-test --list-sfc >/dev/null ||\
		test_failed "Call to awlsim-test --list-sfc failed"
	"$interpreter" ./awlsim-test --list-sfc-verbose >/dev/null ||\
		test_failed "Call to awlsim-test --list-sfc-verbose failed"
	"$interpreter" ./awlsim-test --list-sfb >/dev/null ||\
		test_failed "Call to awlsim-test --list-sfb failed"
	"$interpreter" ./awlsim-test --list-sfb-verbose >/dev/null ||\
		test_failed "Call to awlsim-test --list-sfb-verbose failed"


	# check awlsim-proupgrade executable
	# (proupgrade uses GUI code, so only run in compatible environment)

	if interpreter_is_gui_compat "$interpreter"; then

		local tmp_project="$(maketemp project)"
		cat "$basedir"/000-base/EXAMPLE.awlpro > "$tmp_project" ||\
			test_failed "Copying of EXAMPLE.awlpro failed"

		"$interpreter" ./awlsim-proupgrade -h >/dev/null ||\
			test_failed "Call to awlsim-proupgrade -h failed"
		"$interpreter" ./awlsim-proupgrade --help >/dev/null ||\
			test_failed "Call to awlsim-proupgrade --help failed"
		"$interpreter" ./awlsim-proupgrade "$tmp_project" >/dev/null ||\
			test_failed "Call to awlsim-proupgrade '$tmp_project' failed"
		"$interpreter" ./awlsim-proupgrade -L 5 "$tmp_project" >/dev/null ||\
			test_failed "Call to awlsim-proupgrade '$tmp_project' failed"
	fi
}
