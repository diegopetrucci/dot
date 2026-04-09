# Trace every compinit invocation when COMPINIT_TRACE is set.
if [[ -n ${COMPINIT_TRACE:-} ]]; then
  _compinit_trace_log="${XDG_CACHE_HOME:-${HOME}/.cache}/compinit-trace.log"
  mkdir -p -- "${_compinit_trace_log:h}"
  : >! "${_compinit_trace_log}"

  _compinit_trace_hook() {
    if [[ ${ZSH_DEBUG_CMD} == *compinit* ]]; then
      print -r -- "$(date +%s) ${ZSH_DEBUG_CMD} <- ${funcfiletrace[*]:-main}" >> "${_compinit_trace_log}"
    fi
  }

  trap _compinit_trace_hook DEBUG
fi
