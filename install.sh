# rpi_zram install

#Download the script and copy to /usr/bin/ folder
sudo wget -O /usr/local/bin/zram.sh https://raw.githubusercontent.com/abarrile/rpi_zram/master/zram.sh

#make file executable
sudo chmod +x /usr/local/bin/zram.sh

#add line before exit 0
#sudo vi /etc/rc.local -c 'normal GO/usr/bin/zram.sh &' -c ':wq'

#add systemd service

sudo tee /etc/systemd/system/zram.service <<-'EOF'
[Unit]
Description=Script to dynamically enable ZRAM on a Raspberry Pi or other Linux system
After=local-fs.target

[Service]
RemainAfterExit=yes
ExecStart=/usr/local/bin/zram.sh
ExecStop=/usr/local/bin/zram.sh stop
TimeoutStopSec=600
Nice=-19
OOMScoreAdjust=-1000
CPUAccounting=true
ProtectHome=read-only

[Install]
WantedBy=local-fs.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable zram.service
