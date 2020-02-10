#
# CUDA
#
if [[ $(uname -n) =~ "^baracuda" ]] || [[ $(uname -n) =~ "^moss" ]] || [[ $(uname -n) = "saffron" ]]; then
    export CUDA_HOME=/usr/local/cuda
    export CUDA_PATH=/usr/local/cuda
    export PATH=/usr/local/bin:$CUDA_HOME/bin:$PATH
    export LD_LIBRARY_PATH=/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/local/lib64:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
    export CUDA_DEVICE_ORDER=PCI_BUS_ID
fi

#
# Shared programs
#
if [[ -e /mnt/orange/ubrew/data ]]; then
  export PATH="/mnt/orange/ubrew/data/bin:$PATH"
  export MANPATH="/mnt/orange/ubrew/data/share/man:$MANPATH"
  export INFOPATH="/mnt/orange/ubrew/data/share/info:$INFOPATH"
fi
