FROM fedora:latest

RUN dnf -y update && dnf -y install @deepin-desktop-environment gdm blender  && dnf clean all

EXPOSE 80

ENTRYPOINT /usr/bin/blender