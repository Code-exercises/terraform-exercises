#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<p>Server port: ${port}</p>
EOF

nohup busybox httpd -f -p ${port} &