# ************************************************************************************************************ #
#                                                                                                              #
#                                                      :::::::::  ::::::::   ::::::::   :::    ::: ::::::::::  #
#  init.sh                                            :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:          #
#                                                    +:+    +:+ +:+    +:+ +:+        +:+    +:+ +:+           #
#  By: ES-Yukun <yukun@team.anylinks.jp>            +#+    +:+ +#+    +:+ +#+        +#++:++#++ +#++:++#       #
#                                                  +#+    +#+ +#+    +#+ +#+        +#+    +#+ +#+             #
#  Created: 2023/04/30 01:50:48 by ES-Yukun       #+#    #+# #+#    #+# #+#    #+# #+#    #+# #+#              #
#  Updated: 2023/04/30 03:23:58 by ES-Yukun      #########  ########   ########  ###    ### ##########.io.     #
#                                                                                                              #
# ************************************************************************************************************ #

VERSION=$(curl https://api.github.com/repos/coder/code-server/releases/latest  -s | jq .name -r | sed -e s/v//g)

echo -e "$(date --utc +[%Y-%m-%dT%H:%M:%S.%3NZ]) info  Installing requirements packages"
pacman --noconfirm -Syyu rpm nodejs > /dev/null

echo -e "$(date --utc +[%Y-%m-%dT%H:%M:%S.%3NZ]) info  Installing code-server\033[0m"
rpm -i https://github.com/coder/code-server/releases/download/v${VERSION}/code-server-${VERSION}-amd64.rpm

echo -e "$(date --utc +[%Y-%m-%dT%H:%M:%S.%3NZ]) info  Installing code-server"
cat <<EOF > /tmp/.code-server.yaml
bind-addr: 0.0.0.0:8080
auth: password
password: $(echo $RANDOM | md5sum | head -c 20)
cert: false
EOF

if [ ! -f ~/.installrc ]; then
	touch ~/.installrc
fi

if [ ! -f /tmp/installed ]; then
	touch /tmp/installed;
	source ~/.installrc
fi

echo -e "$(date --utc +[%Y-%m-%dT%H:%M:%S.%3NZ]) info  code-server start"
code-server --config /tmp/.code-server.yaml
