# AWESOME-CV

## OpenCV with CUDA for Miniconda
This section contains instructions for building OpenCV with CUDA support in a Miniconda environment. If you need to leverage GPU acceleration for OpenCV on your system, follow this guide to compile OpenCV from source with CUDA enabled

### Requirements

- Miniconda installed on your system.
- CUDA-compatible NVIDIA GPU and CUDA toolkit installed.
- Build tools (CMake) installed.

### Steps to Build OpenCV with CUDA Support for Miniconda

#### 1. Create and Activate a Conda Environment

```bash
conda create -n opencv-cuda python=3.10
conda activate opencv-cuda
```

#### 2. Install Necessary Dependencies

* First of all install update and upgrade your system:
```bash
sudo apt update
sudo apt upgrade
```
* Generic tools:
```bash
sudo apt install build-essential cmake pkg-config unzip yasm git checkinstall
sudo apt install libjpeg-dev libpng-dev libtiff-dev
```
* Image I/O libs
``` 
sudo apt install libjpeg-dev libpng-dev libtiff-dev
``` 
* Video/Audio Libs - FFMPEG, GSTREAMER, x264 and so on.

```
# Install basic codec libraries
sudo apt install libavcodec-dev libavformat-dev libswscale-dev

# Install GStreamer development libraries
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

# Install additional codec and format libraries
sudo apt install libxvidcore-dev libx264-dev libmp3lame-dev libopus-dev

# Install additional audio codec libraries
sudo apt install libmp3lame-dev libvorbis-dev

# Install FFmpeg (which includes libavresample functionality)
sudo apt install ffmpeg

# Optional: Install VA-API for hardware acceleration
sudo apt install libva-dev
```
    
* Cameras programming interface libs
```
# Install video capture libraries and utilities
sudo apt install libdc1394-25 libdc1394-dev libxine2-dev libv4l-dev v4l-utils

# Create a symbolic link for video device header
sudo ln -s /usr/include/libv4l1-videodev.h /usr/include/linux/videodev.h
```

* GTK lib for the graphical user functionalites coming from OpenCV highghui module 
```
sudo apt-get install libgtk-3-dev
```
    
* Parallelism library C++ for CPU
```
sudo apt-get install libtbb-dev
```
* Optimization libraries for OpenCV
```
sudo apt-get install libatlas-base-dev gfortran
```
* Optional libraries:
```
sudo apt-get install libprotobuf-dev protobuf-compiler
sudo apt-get install libgoogle-glog-dev libgflags-dev
sudo apt-get install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
```

#### 3. Download and unzip OpenCV

```
cd ~/ && mkdir Downloads && cd Downloads && mkdir opencv && cd opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/refs/tags/4.10.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/refs/tags/4.10.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

pip install numpy

cd opencv-4.10.0
mkdir build
cd build
```
