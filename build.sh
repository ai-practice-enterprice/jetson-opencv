#!/bin/bash

# Build the Docker image for ARM64 architecture
docker build --platform linux/arm64/v8 -t jetson-opencv .
docker create --platform linux/arm64/v8 --name jetson-opencv-build jetson-opencv
docker cp jetson-opencv-build:/root/opencv ./*
docker rm jetson-opencv-build
