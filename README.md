# WSL-ML
Code for setting up a GPU accelerated machine learning environment in WSL2 platform.

Environment description:
* WSL2 - Ubuntu 20.04
* Pytorch
* CUDA 11.3
* TensorRT 8
* OpenCV

## Why?
It can be quite a hazzle to setup properly working WSL environment from scratch, so this
repository tries to provide base code for doing that. This solution should be used when exact version control of library versions is required. (If specific versions are not needed, then maybe try using Nvidia/Pytroch docker containers).

The environment configuration hazzle arises from the fact, that the environment doesn't necessarily work when following official installation guides. For example, Pytorch may be unable to detect GPU, although suitable packages have been installed, because WSL2 may not simply support these packages yet.
