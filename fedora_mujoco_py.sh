sudo yum install -y make gcc-c++ mesa-libGL-devel mesa-libOSMesa-devel glfw redhat-rpm-config patchelf
sudo yum install -y mesa-libGLU-devel mesa-libEGL-devel

# optional if above doesn't work
conda install -c conda-forge gcc gxx ffmpeg
conda install -c conda-forge glew mesalib


# google football dependencies
# Ref: https://github.com/vlang/sdl#fedora
sudo dnf install SDL2-devel SDL2_ttf-devel SDL2_mixer-devel SDL2_image-devel SDL2_gfx-devel SDL2_net-devel SDL2_sound-devel
conda install -c conda-forge boost
