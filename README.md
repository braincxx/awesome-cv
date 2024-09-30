# 🛠️AWESOME-CV

## OpenCV with CUDA for Miniconda
This section contains instructions for building OpenCV with CUDA support in a Miniconda environment. If you need to leverage GPU acceleration for OpenCV on your system, follow this guide to compile OpenCV from source with CUDA enabled

### Requirements

- Miniconda installed on your system. ([how to install Miniconda](https://docs.anaconda.com/miniconda/#quick-command-line-install))
- CUDA-compatible NVIDIA GPU and CUDA toolkit installed.
- Build tools (CMake) installed.

### 

### Check CUDA version and CUDA Toolkit
```
nvidia-smi
```
```
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.154.05             Driver Version: 535.154.05   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
```

```
nvcc --version
```
```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2023 NVIDIA Corporation
Built on Tue_Jun_13_19:16:58_PDT_2023
Cuda compilation tools, release 12.2, V12.2.91
Build cuda_12.2.r12.2/compiler.32965470_0
```

### Steps to Build OpenCV with CUDA Support for Miniconda

#### 1. Create and Activate a Conda Environment

```bash
conda create -n cv_cuda python=3.10
conda activate cv_cuda
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

#### 4. Create Makefile with cmake

* Set CUDA_ARCH_BIN version from https://developer.nvidia.com/cuda-gpus 
```
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
```

* Before the compilation you must check configuration summary printed on the screen. (If you have problems with the CUDA Architecture go to the end of the document).

```
--   NVIDIA CUDA:                   YES (ver 12.2, CUFFT CUBLAS FAST_MATH)
--     NVIDIA GPU arch:             75
--     NVIDIA PTX archs:
-- 
--   cuDNN:                         YES (ver 8.2.2)

--   Python 3:
--     Interpreter:                 /root/miniconda3/envs/cv_cuda/bin/python (ver 3.10.14)
--     Libraries:                   /root/miniconda3/envs/cv_cuda/lib/libpython3.10.so (ver 3.10.14)
--     Limited API:                 NO
--     numpy:                       /root/miniconda3/envs/cv_cuda/lib/python3.10/site-packages/numpy/_core/include (ver 2.1.1)
--     install path:                /root/miniconda3/envs/cv_cuda/lib/python3.10/site-packages/cv2/python-3.10
-- 
--   Python (for build):            /root/miniconda3/envs/cv_cuda/bin/python


--   Install to:                    /root/miniconda3/envs/cv_cuda
```

#### 5. Compile 
```
make -j$(nproc)
make install

echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf
ldconfig
```

#### Notes
* If you got errors:
```
  return _bootstrap._gcd_import(name[level:], package, level)
ImportError: /lib/x86_64-linux-gnu/libp11-kit.so.0: undefined symbol: ffi_type_pointer, version LIBFFI_BASE_7.0
```
FOR FIX ERROR ENTER COMMAND:
```
ln -sf /usr/lib/x86_64-linux-gnu/libffi.so.7 $CONDA_PREFIX/lib/libffi.so.7
```
* For compatiable cupy version need install from conda
```
conda install -c conda-forge cupy
```

## Contributing

We welcome contributions from the community! If you have a new technique or improvement to suggest:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/AmazingFeature`
3. Commit your changes: `git commit -m 'Add some AmazingFeature'`
4. Push to the branch: `git push origin feature/AmazingFeature`
5. Open a pull request

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

---

⭐️ If you find this repository helpful, please consider giving it a star!

Keywords: OPENCV CUDA, Computer vision, BUILD OPENCV WITH CUDA FOR MINICONDA, FIX ERROR WHEN BUILDING OPENCV, Machine Learning
