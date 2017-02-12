#!/bin/bash
# rsync.sh
# 将源目录复制到目的端
#rsync -av source_path destination_path

rsync -av rsync.sh root@192.168.128.85:/tmp

# 将远端主机上的数据恢复到本地主机
rsync -av username@hostname:PATH destination

# rsync通过网络传输时，压缩数据能够明显改善传输效率，可以使用rsync的选项-z

# rsync排除一部分文件和内容
rsync -avz /data/some_code /mnt/backup/code --exclude "*.txt"
--exclude-from FILEPATH
