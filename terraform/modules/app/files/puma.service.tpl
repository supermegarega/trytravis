[Unit]
Description=Puma server
After=network.target

[Service]
Type=simple
User=appuser
Environment=DATABASE_URL=${mongo_ext_ip}
WorkingDirectory=/home/appuser/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=on-failure

[Install]
WantedBy=multi-user.target


