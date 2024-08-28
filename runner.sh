#!/bin/bash

user_uid=$UID
user_gid=$(id -rg)
user_name=$USER

echo "running"
podman run \
    --rm \
    --network host \
    --security-opt label=disable \
    -e XDG_RUNTIME_DIR=/tmp \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY:ro \
    -v /run/user/1000/wayland-0:/tmp/wayland-0:ro \  
            # Bind mount Wayland socket
    -v /usr/lib/wayland-egl:/usr/lib/wayland-egl:ro \  
	    # Bind mount Wayland libraries
    -v /usr/share/wayland:/usr/share/wayland:ro \    
	    # Bind mount Wayland protocols
    -it localhost/gpu:latest blender
