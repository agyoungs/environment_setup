#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "$DIR/tmux-resurrect" ]; then
  git clone https://github.com/tmux-plugins/tmux-resurrect $DIR/tmux-resurrect
  chown -R alex:alex $DIR/tmux-resurrect
fi

sed -i '/# Custom Settings (ayoungs)/Q' ~/.bashrc
cat <<EOT >> ~/.bashrc
# Custom Settings (ayoungs)
export ROSDISTRO_INDEX_URL=https://ivs-git.dyn.datasys.swri.edu/external/rosdistro/raw/swri/index.yaml

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:\${CUDA_HOME}/lib64"
PATH=\${CUDA_HOME}/bin:\${PATH}
export PATH

tmux_session=\`tmux display-message -p "#S" 2> /dev/null\` 
if [ -f ~/workspaces/\$tmux_session/devel/setup.bash ]; then
  . ~/workspaces/\$tmux_session/devel/setup.bash
fi
EOT

sudo $DIR/scripts/install_scripts.sh
