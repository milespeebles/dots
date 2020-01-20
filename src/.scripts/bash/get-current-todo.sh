#!/bin/bash

DOWNTIME_PHRASE='Tracking downtime'
ACTIVE=$(task active 2> /dev/null | tail -3 | head -1)
ID=$(echo $ACTIVE | awk '{print $1}')
TIMEBOX=$(cat $HOME/.timer 2> /dev/null | head -1)
IS_DOWN=$(timew 2> /dev/null | head -1)
DESCRIPTION=$(task $ID info 2> /dev/null | head -5 | tail -1 | cut -d ' ' -f4- | sed -e 's/^[[:space:]]*//')
UUID=$(task $ID uuids | cut -c1-8)
TOTAL=$(timew summary uuid:$UUID | tail -2 | head -1 | awk '{$1=$1};1')

if [[ -n $TIMEBOX ]]; then
  if [[ $IS_DOWN == $DOWNTIME_PHRASE ]]; then
    LINE="#[fg=#282a36,bg=#ff92d0] $TIMEBOX #[fg=#282a36,bg=#8be9fd] downtime "
  else
    LINE="#[fg=#282a36,bg=#ff92d0] $TIMEBOX #[fg=#282a36,bg=#8be9fd] [$ID] $DESCRIPTION "
  fi
else
  if [[ $IS_DOWN == $DOWNTIME_PHRASE ]]; then
    LINE="#[fg=#282a36,bg=#8be9fd] downtime "
  else
    LINE="#[fg=#282a36,bg=#ff92d0] $TOTAL #[fg=#282a36,bg=#8be9fd] [$ID] $DESCRIPTION "
  fi
fi

if [[ -n $ACTIVE ]] || [[ $IS_DOWN == $DOWNTIME_PHRASE ]]; then
  echo "$LINE"
fi

