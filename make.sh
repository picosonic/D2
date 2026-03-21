#!/bin/bash

# Tool names
beebasm="beebasm"

##############################################################

function refreshrequired()
{
  local target="$1"
  local targettime=`stat -c %Y ${target} 2>/dev/null`

  if [ "${targettime}" == "" ]
  then
    return 0
  fi
  
  for var in "$@"
  do
    local source="$var"
    local sourcetime=`stat -c %Y ${source} 2>/dev/null`
    
    if [ ${sourcetime} -gt ${targettime} ]
    then
      return 0
    fi
  done

  return 1
}

##############################################################

# Build roomdata if required
if refreshrequired RMDATA rooms/room*.bin roomdata.asm
then
  ${beebasm} ${verbose} -i roomdata.asm
fi

${beebasm} -i dizzy2_64.asm
