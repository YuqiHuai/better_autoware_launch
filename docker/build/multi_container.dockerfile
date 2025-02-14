FROM ghcr.io/autowarefoundation/autoware:20240903-devel-cuda-amd64

ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV ROS_LOCALHOST_ONLY=1

CMD ["bash", "-c", "sudo ip link set lo multicast on && exec bash"]
