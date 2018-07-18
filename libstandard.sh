# libstandard.sh  -- group of standard functions
#
# ver: 0.0.1
# tags: standard
# desc: help to make your library.
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License.



EX_USAGE=64
EX_DATAERR=65
EX_NOINPUT=66
EX_NOUSER=67
EX_NOHOST=68
EX_UNAVAILABLE=69
EX_SOFTWARE=70
EX_OSERR=71
EX_OSFILE=72
EX_CANTCREAT=73
EX_IOERR=74
EX_TEMPFAIL=75
EX_PROTOCOL=76
EX_NOPERM=77
EX_CONFIG=78

# output error message to stderr
# @stderr string error message
# @param <int error_code> <string error_message>
# @return <given return code>
function error {
  echo "$2" >2
  exit $1
}

# check if previous command fail and execute command
# @param <function error_op> [<function success_op>]
# @return $EX_OK(0) success
# @return $EX_DATAERR function not found
function is_error {
  local status=$?
  local error_operation=()
  for arg in "$@";do
    [ "$arg" = "--" ] && shift && break
    error_operation=(${error_operation[@]} $arg)
    shift
  done
  local success_operation=($@)

  if [ $status -eq 0 ]; then
    ${success_operation[@]} || return $EX_DATAERR
  else
    ${error_operation[@]} || return $EX_DATAERR
  fi
  return 0
}


# execute all <lib>.init at first. Won't be called by user.
# @param <string lib1> <string lib2> ...
# @return 0 success
# @return 3 fail in some library
function init {
  for lib in "$@";do
    ${lib}.init || ~error "fail: sourcing ${lib}" && return 3
  done
  return 0
}
