#!/usr/bin/env bash

#        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#                    Version 2, December 2004 
#
# Copyright (C) 2013 Mathieu Robardey <offim.r@gmail.com> 
#
# Everyone is permitted to copy and distribute verbatim or modified 
# copies of this license document, and changing it is allowed as long 
# as the name is changed. 
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

DEFAULT_MODULES=(sessions registrations passwords unlocks confirmations)
DEFAULT_SCOPE=users

function controller_template {
cat <<RubyCode
class ${1}::${2}Controller < Devise::${2}Controller
  # def new
  #   super
  # end

  # def create
  #   super
  # end
end
RubyCode
}

# Prompt for devise scope
read -p "Specify devise scope ('users' by default) : " SCOPE
if [ -z "$SCOPE" ]; then 
  SCOPE=$DEFAULT_SCOPE
fi

# Prompt for modules
echo "Devise modules: ${DEFAULT_MODULES[@]}"
read -p "Specify devise module(s) you want to override, separated by a space. (all by default) : " MODULES
if [ -z "$MODULES" ]; then 
  MODULES=(${DEFAULT_MODULES[@]})
else
  MODULES=($MODULES)
fi

# Check for devise scope folder
if [ ! -d "app/controllers/$SCOPE" ]; then
  mkdir app/controllers/$SCOPE
fi

# Then create files & inject code
for module in "${MODULES[@]}"
  do :
    echo "Generating controller for $module ..."
    touch app/controllers/${SCOPE}/${module}_controller.rb
    cat > app/controllers/${SCOPE}/${module}_controller.rb <<EOF
$(controller_template ${SCOPE[@]^} ${module[@]^})
EOF
done