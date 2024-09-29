# awesome-cv

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
