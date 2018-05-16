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
# @param <string error_message>
# @return 0 success
function error {
  echo "$@" >2
  return 0
}

# check if previous command fail and execute command
# @param <function error_op> [<function success_op>]
# @return 0 success
# @return 1 function not found
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
    ${success_operation[@]} || return 1
  else
    ${error_operation[@]} || return 1
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
