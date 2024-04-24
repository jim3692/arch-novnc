# Docker container running ArchLinux accessible through novnc in a browser
FROM archlinux:latest

# Initialize keys
RUN pacman-key --init
RUN pacman-key --populate

# Update all packages
RUN pacman -Syu --noconfirm

# Install additional packages
RUN pacman -S --noconfirm \
	arc-gtk-theme \
	caja \
	enlightenment \
	facter \
	git \
	gnome-keyring \
	gtk-engine-murrine \
	gtk-engines \
	marco \
	mate-desktop \
	mate-extra \
	mate-panel \
	mate-session-manager \
	mate-settings-daemon \
	net-tools \
	papirus-icon-theme \
	python \
	python-numpy \
	supervisor \
	terminator \
	vim \
	x11vnc \
	xorg-apps \
	xorg-server \
	xorg-server-xvfb

COPY dconf.sh /root/dconf.sh

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
