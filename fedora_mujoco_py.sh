sudo yum install -y make gcc-c++ mesa-libGL-devel mesa-libOSMesa-devel glfw redhat-rpm-config patchelf

# optional if above doesn't work
conda install -c conda-forge gcc gxx ffmpeg
conda install -c conda-forge glew mesalib
