# MAIN


Looks like CDI is best candidate https://github.com/cncf-tags/container-device-interface .

It is used by NVIDIA https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html

and by INTEL https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/gpu/USAGE.md


STATUS:

1. CDI would be great to run containers and CRI-O is CDI-enabled by default.
2. Operator should be created by vendor and we have
   NVIDIA: https://catalog.redhat.com/software/container-stacks/detail/5faa9cb6b72282d84b742c6e?gs&q=nvidia
   INTEL: https://catalog.redhat.com/software/containers/intel/intel-data-center-gpu-driver-container/6495ee55c8b2461e35fb8264?gs&q=intel
   AMD: no operator
3. Running with podman is easy with --device= 


## INTEL

CRDs for Intel are following


deployment/ directory contains all required YAMLs:
deployments/gpu/static/crds/ - Custom Resource Definitions the GPU resource driver uses.

GpuAllocationState - main object of communication between controller and kubelet-plugins
GpuClaimParameters - used in ResourceClaims to specify details about requested HW, e.g. quantity, type, minimum requested memory, millicores.
GpuClassParameters - used in ResourceClass to customize the allocation logic, e.g. shared or exclusive GPU allocation, or allocation of all devices at once for monitoring purposes.
deployments/gpu/resource-class.yaml - pre-defined ResourceClasses that ResourceClaims can refer to.

deployments/gpu/resource-driver-namespace.yaml - Kubernetes namespace for GPU Resource Driver.

deployments/gpu/resource-defaults.yaml - ConfigMap allowing customizing otherwise hardcoded default values.

deployments/gpu/resource-driver.yaml - actual resource driver with service account and RBAC policy

controller Deployment - controller of the GPU resource driver make decisions on what GPU or SR-IOV VF should be allocated to a particular ResourceClaim based on the GpuClaimParameters and allocatableDevices of particular Kubernetes node
kubelet-plugin DaemonSet - node-agent, it performs three functions:
supported hardware discovery on Kubernetes cluster node and it's announcement to the GpuAllocationState that is specific to the node.
preparation of the hardware allocated to the ResourceClaims for the Pod that is being started on the node.
unpreparation of the hardware allocated to the ResourceClaims for the Pod that is being started on the node

https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/gpu/USAGE.md#deployment-directory-contains-all-required-yamls



## NVIDIA

https://github.com/NVIDIA/gpu-operator

CRDs are at https://github.com/NVIDIA/gpu-operator/tree/main/deployments/gpu-operator

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-cri-o

https://github.com/NVIDIA/libnvidia-container

https://github.com/NVIDIA/nvidia-container-toolkit


## AMD

TODO: for AMD check https://github.com/ROCm/k8s-device-plugin?tab=readme-ov-file