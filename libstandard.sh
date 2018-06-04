# libstandard.sh  -- group of standard functions
#
# ver: 0.0.1
# tags: standard
# desc: help to make your library.
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License.


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
