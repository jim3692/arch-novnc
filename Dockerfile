# Docker container running ArchLinux accessible through novnc in a browser
FROM archlinux:latest

# Install packages
RUN pacman-key --init
RUN pacman-key --populate
RUN pacman -S --noconfirm \
	facter \
	git \
	enlightenment \
	mate-desktop \
	net-tools \
	python \
	python-numpy \
	supervisor \
	terminator \
	vim \
	x11vnc \
	xorg-server \
	xorg-apps \
	xorg-server-xvfb

# Update all packages
RUN pacman -Syu

# noVNC cooking
WORKDIR /opt/
RUN git clone https://github.com/novnc/noVNC.git
# Avoid another checkout when launching noVnc
WORKDIR /opt/noVNC/utils/
RUN git clone https://github.com/novnc/websockify

# Comfort
WORKDIR /var/log/supervisor/

# Not seems to work, but...
RUN export DISPLAY=:0.0

# Prepare X11, x11vnc, mate and noVNC from supervisor
COPY supervisord.ini /etc/supervisor.d/supervisord.ini

# Be sure that the noVNC port is exposed
EXPOSE 8083

# Launch X11, x11vnc, mate and noVNC from supervisor
CMD ["/usr/bin/supervisord"]
