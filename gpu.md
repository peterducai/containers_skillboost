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



podman run -it --network host --env DISPLAY --security-opt label=type:container_runtime_t --name myContainer fedora


To run Wayland applications in docker without X, you need a running wayland compositor like Gnome-Wayland or Weston. You have to share the Wayland socket. You find it in XDG_RUNTIME_DIR and its name is stored in WAYLAND_DISPLAY. As XDG_RUNTIME_DIR only allows access for its owner, you need the same user in container as on host. Example:

docker run -e XDG_RUNTIME_DIR=/tmp \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY  \
           --user=$(id -u):$(id -g) \
           imagename waylandapplication
QT5 applications also need -e QT_QPA_PLATFORM=wayland and must be started with imagename dbus-launch waylandapplication





```
build_args=(
  # Reuse host cache
  --volume /var/cache/pacman/pkg:/var/cache/pacman/pkg
  # Config files
  --volume /home:/home
)

run_args=(
  --name='game'

  # Support /sbin/init
  --systemd=always
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro

  # Detect file changes in Containerfile
  --rm='true'
  --replace='true'

  # Bridge network
  --network='host'

  # GPU access
  --privileged='true'
  --ipc='host'
  --device /dev/dri:/dev/dri:rwm
  --device /dev/fb0:/dev/fb0:rwm
  --volume /dev/shm:/dev/shm

  # Seats
  --volume /dev/tty0:/dev/tty0
  --volume /dev/tty1:/dev/tty1

  # SELinux
  --security-opt seccomp=unconfined
  --security-opt unmask=/sys/dev

  # Peripherals
  --volume /dev/input:/dev/input
  --volume /run/udev:/run/udev
  --volume /dev/snd:/dev/snd
)

# CTRL+P+Q to quit
clear && \
  sudo podman build \
    "${build_args[@]}" \
    -t local/game:latest \
    -f Containerfile.game \
    "$@" \
    ./ && \
  sudo podman run \
    "${run_args[@]}" \
    "${build_args[@]}" \
    -d \
    local/game:latest && \
  systemctl stop \
    getty@tty1.service && \
  sudo podman exec \
    -it game \
    /bin/login
```



user_uid=$UID
user_gid=$(id -rg)
user_name=$USER

podman run \
    --rm \
    --security-opt label=disable \
    -e XDG_RUNTIME_DIR=/tmp \
    -e "WAYLAND_DISPLAY=$WAYLAND_DISPLAY" \
    -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY:ro" \
    -v /run/user/$user_uid/wayland-0:/tmp/wayland-0:ro \  # Bind mount Wayland socket
    -v /usr/lib/wayland-egl:/usr/lib/wayland-egl:ro \   # Bind mount Wayland libraries
    -v /usr/share/wayland:/usr/share/wayland:ro \     # Bind mount Wayland protocols
    -it \
    fedora \
    bash -euo pipefail -c "
        dnf install -y \
            coreutils bash bash-completion less nano sudo tree util-linux gedit
        groupadd -g $user_gid $user_name
        useradd -u $user_uid -g $user_gid -ms /usr/bin/bash $user_name
        usermod -aG wheel $user_name
        echo '$user_name ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/nopasswd
        cd /home/$user_name
        exec sudo -iu $user_name --preserve-env=XDG_RUNTIME_DIR,WAYLAND_DISPLAY
    "

if you have SELinux and the policy-coreutils you can run a sandbox for a browser/app very easily as well. sandbox -X -w 1920x1080 -H temphome -T tmp -t sandbox_web_t firefox &








pducai@fedora:~/Documents/GitHub/containers_skillboost$ podman run -it --rm -v $XAUTHORITY:$XAUTHORITY:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro --userns keep-id -e "DISPLAY" --security-opt label=type:container_runtime_t gpu:latest xeyes
GHOST/Wayland: error: XDG_RUNTIME_DIR is invalid or not set in the environment.
/usr/bin/blender(+0xef5ccc) [0x560360b03ccc]
/lib64/libwayland-client.so.0(+0x6c9e) [0x7fdec9e96c9e]
/lib64/libwayland-client.so.0(wl_display_connect+0x36f) [0x7fdec9e9be4f]
/usr/bin/blender(+0x2356a34) [0x560361f64a34]
/usr/bin/blender(+0xf887dd) [0x560360b967dd]
/usr/bin/blender(+0x8fd70d) [0x56036050b70d]
/lib64/libc.so.6(+0x2814a) [0x7fdeeca4614a]
/lib64/libc.so.6(__libc_start_main+0x8b) [0x7fdeeca4620b]
/usr/bin/blender(+0x94b195) [0x560360559195]
Authorization required, but no authorization protocol specified
GHOST: failed to initialize display for back-end(s): ['WAYLAND', 'X11']
  'WAYLAND': unable to connect to display!
  'X11': unable to open a display!
GHOST: unable to initialize, exiting!



podman run -it --network host --env DISPLAY -e XDG_RUNTIME_DIR --security-opt label=type:container_runtime_t --name myContainer localhost/gpu:latest
Authorization required, but no authorization protocol specified
GHOST: failed to initialize display for back-end(s): ['WAYLAND', 'X11']
  'WAYLAND': unable to connect to display!
  'X11': unable to open a display!
GHOST: unable to initialize, exiting!






APACHE GUACAMOLE 

https://gist.github.com/dmi3mis/1e7dc9c5d423ab588d555f0a2c399f26