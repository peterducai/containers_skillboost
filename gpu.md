# GPU


podman run --device=host-device[:container-device][:permissions] 

podman run --device /dev/video0 --group-add keep-group 

https://www.redhat.com/sysadmin/files-devices-podman

CDI:

https://github.com/cncf-tags/container-device-interface

NVIDIA:

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html

INTEL:  

https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/gpu/README.md
https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/gpu/USAGE.md
https://github.com/intel/intel-resource-drivers-for-kubernetes/blob/main/doc/CLUSTER_SETUP.md
https://www.kernel.org/doc/html/v4.14/gpu/i915.html#c.intel_vgt_balloon

https://github.com/intel/compute-runtime
https://www.intel.com/content/www/us/en/developer/articles/tool/opencl-drivers.html
https://github.com/intel/compute-samples
https://github.com/intel/ai-reference-models
https://dgpu-docs.intel.com/solutions/max-sw/index.html



AMD:
only mention of CDI in https://github.com/ROCm/ROCm I see is https://github.com/ROCm/ROCm/issues/3029