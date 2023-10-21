# ************************************************************************************************************ #
#                                                                                                              #
#                                                      :::::::::  ::::::::   ::::::::   :::    ::: ::::::::::  #
#  Dockerfile                                         :+:    :+: :+:    :+: :+:    :+: :+:    :+: :+:          #
#                                                    +:+    +:+ +:+    +:+ +:+        +:+    +:+ +:+           #
#  By: ES-Yukun <yukun@team.anylinks.jp>            +#+    +:+ +#+    +:+ +#+        +#++:++#++ +#++:++#       #
#                                                  +#+    +#+ +#+    +#+ +#+        +#+    +#+ +#+             #
#  Created: 2023/04/30 01:40:27 by ES-Yukun       #+#    #+# #+#    #+# #+#    #+# #+#    #+# #+#              #
#  Updated: 2023/04/30 04:57:22 by ES-Yukun      #########  ########   ########  ###    ### ##########.io.     #
#                                                                                                              #
# ************************************************************************************************************ #

FROM	archlinux:latest
COPY	./init.sh /tmp/init.sh
RUN		chmod +x /tmp/init.sh
RUN		echo 'Server = https://mirror.cat.net/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist 
RUN		pacman --noconfirm -Syyu
RUN   pacman --noconfirm -S rpm
RUN 	pacman --noconfirm -S git
RUN 	pacman --noconfirm -S openssh
RUN 	pacman --noconfirm -S jq
CMD		bash -c /tmp/init.sh
