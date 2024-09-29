#!/bin/bash

apt update
apt install build-essential cmake pkg-config unzip yasm git checkinstall -y
apt install libjpeg-dev libpng-dev libtiff-dev -y

#create conda envs
conda create -n opencv_cuda2 -y python=3.10
conda activate opencv_cuda2
# Install basic codec libraries
apt install libavcodec-dev libavformat-dev libswscale-dev -y

# Install GStreamer development libraries
apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev -y

# Install additional codec and format libraries
apt install libxvidcore-dev libx264-dev libmp3lame-dev libopus-dev -y

# Install additional audio codec libraries
apt install libmp3lame-dev libvorbis-dev -y

# Install FFmpeg (which includes libavresample functionality) 
apt install ffmpeg -y

# Optional: Install VA-API for hardware acceleration 
apt install libva-dev -y

apt-get install libtbb-dev -y

apt-get install libatlas-base-dev gfortran -y

#Optional libraries:
apt-get install libprotobuf-dev protobuf-compiler -y
apt-get install libgoogle-glog-dev libgflags-dev -y
apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen -y

cd ~/ && mkdir Downloads && cd Downloads && mkdir opencv && cd opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/refs/tags/4.10.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

pip install numpy

echo "Procced with the installation"
cd opencv-4.10.0
mkdir build
cd build

export CPLUS_INCLUDE_PATH=$CONDA_PREFIX/lib/python3.10

cmake   -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
        -D OPENCV_EXTRA_MODULES_PATH=~/Downloads/opencv/opencv_contrib-4.10.0/modules \
        -D PYTHON3_LIBRARY=$CONDA_PREFIX/lib/libpython3.10.so \
        -D PYTHON3_INCLUDE_DIR=$CONDA_PREFIX/include/python3.10 \
        -D PYTHON3_EXECUTABLE=$CONDA_PREFIX/bin/python \
        -D PYTHON3_PACKAGES_PATH=$CONDA_PREFIX/lib/python3.10/site-packages \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D BUILD_EXAMPLES=ON \
        -D WITH_TBB=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 \
        -D WITH_CUBLAS=1 \
        -D WITH_CUDA=ON \
        -D BUILD_opencv_cudacodec=ON \
        -D WITH_CUDNN=ON \
        -D OPENCV_DNN_CUDA=ON \
        -D CUDA_ARCH_BIN=7.5 \
        -D WITH_V4L=ON \
        -D WITH_QT=OFF \
        -D WITH_OPENGL=ON \
        -D WITH_GSTREAMER=ON ..

make -j$(nproc)
make install

echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf
ldconfig
