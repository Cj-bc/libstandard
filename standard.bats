#!/usr/bin/env bats

function setup {
  source ./libstandard.sh
}


@test "check all constant" {
  EX=("EX_USAGE" "EX_DATAERR" "EX_NOINPUT" "EX_NOUSER" "EX_NOHOST" "EX_UNAVAILABLE" "EX_SOFTWARE" "EX_OSERR" "EX_OSFILE" "EX_XANTCREAT" "EX_IOERR" "EX_TEMPFAIL" "EX_PROTOCOL" "EX_NOPERM" "EX_CONFIg")
  for i in {0..14};do
    [ ${${EX[i]}} -eq $((64 + $1)) ]
  done
}

@test ""

function teardown {

}

