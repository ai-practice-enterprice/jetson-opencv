FROM nvcr.io/nvidia/l4t-base:r32.7.1 AS builder

RUN apt-get update

#VOLUME [ "/root/opencv" ]
#RUN cd /root/opencv
RUN apt-get -y install build-essential cmake git unzip pkg-config zlib1g-dev
RUN apt-get -y install libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev
RUN apt-get -y install libpng-dev libtiff-dev libglew-dev
RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get -y install libgtk2.0-dev libgtk-3-dev libcanberra-gtk*
RUN apt-get -y install python-dev python-numpy python-pip
RUN apt-get -y install python3-dev python3-numpy python3-pip
RUN apt-get -y install libxvidcore-dev libx264-dev libgtk-3-dev
RUN apt-get -y install libtbb2 libtbb-dev libdc1394-22-dev libxine2-dev
RUN apt-get -y install gstreamer1.0-tools libgstreamer-plugins-base1.0-dev
RUN apt-get -y install libgstreamer-plugins-good1.0-dev
RUN apt-get -y install libv4l-dev v4l-utils v4l2ucp qv4l2
RUN apt-get -y install libtesseract-dev libxine2-dev libpostproc-dev
RUN apt-get -y install libavresample-dev libvorbis-dev
RUN apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev
RUN apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev
RUN apt-get -y install libopenblas-dev libatlas-base-dev libblas-dev
RUN apt-get -y install liblapack-dev liblapacke-dev libeigen3-dev gfortran
RUN apt-get -y install libhdf5-dev libprotobuf-dev protobuf-compiler
RUN apt-get -y install libgoogle-glog-dev libgflags-dev
RUN apt-get -y install qt5-default
RUN sh -c "echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/nvidia-tegra.conf"
RUN ldconfig
WORKDIR /root
RUN git clone --depth=1 https://github.com/opencv/opencv.git
RUN git clone --depth=1 https://github.com/opencv/opencv_contrib.git
WORKDIR /root/opencv
RUN mkdir build
WORKDIR /root/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
-D WITH_OPENCL=OFF \
-D WITH_CUDA=OFF \
-D CUDA_ARCH_BIN=5.3 \
-D CUDA_ARCH_PTX="" \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D ENABLE_FAST_MATH=ON \
-D CUDA_FAST_MATH=OFF \
-D OPENCV_DNN_CUDA=OFF \
-D ENABLE_NEON=ON \
-D WITH_QT=OFF \
-D WITH_OPENMP=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D WITH_PROTOBUF=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF ..
RUN make -j23
#COPY build.sh /root/build.sh

#RUN chmod +x /root/build.sh

#CMD ["/root/build.sh"]
