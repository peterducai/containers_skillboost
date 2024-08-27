# MAIN


Looks like CDI is best candidate https://github.com/cncf-tags/container-device-interface .

It is used by NVIDIA https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html

and by INTEL https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/gpu/USAGE.md


STATUS:

1. CDI would be great to run containers and CRI-O is CDI-enabled by default.
2. Operator should be created by vendor and we have
   NVIDIA: https://catalog.redhat.com/software/container-stacks/detail/5faa9cb6b72282d84b742c6e?gs&q=nvidia
   INTEL: https://catalog.redhat.com/software/containers/intel/intel-data-center-gpu-driver-container/6495ee55c8b2461e35fb8264?gs&q=intel
          https://github.com/intel/intel-data-center-gpu-driver-for-openshift/blob/main/README.md
   AMD: no OCP operator
3. Running with podman is easy with --device= 


## INTEL

We recommend users use the Kernel Module Management (KMM) operator to install and manage the Intel Data Center GPU driver on RHOCP. The KMM operator can be used to deploy all the necessary driver components as well as the firmware from within the driver container image.

CRDs for Intel are following






## NVIDIA

https://github.com/NVIDIA/gpu-operator

CRDs are at https://github.com/NVIDIA/gpu-operator/tree/main/deployments/gpu-operator

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-cri-o

https://github.com/NVIDIA/libnvidia-container

https://github.com/NVIDIA/nvidia-container-toolkit


## AMD

TODO: for AMD check https://github.com/ROCm/k8s-device-plugin?tab=readme-ov-file





TODO:

podman run --env DISPLAY --security-opt label=type:container_runtime_t

https://discussion.fedoraproject.org/t/how-can-i-create-a-container-with-podman-that-runs-graphical-application-in-isolation-from-the-file-system/73520/5