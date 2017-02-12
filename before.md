# 参考文档:http://linuxtools-rst.readthedocs.io/zh_CN/latest/base/05_process_manage.html

# 参考文档:https://github.com/wzb56/13_questions_of_shell

# 参考文档:https://github.com/qinjx/30min_guides/blob/master/shell.md

# 特殊参数的解释

fname() {
  echo $1, $2
  echo "$@"    # 以列表的方式一次性打印所有参数，被扩展为"$1" "$2"
  echo "$*"    # 类似于$@，但是参数被作为单个实体，被扩展为"$1c$2"，其中c是IFS的第一个字符
}

# Bash是Bourne shell的替代品，属GNU Project，二进制文件路径通常是/bin/bash。业界通常混用bash、sh、和shell，比如你会经常在招聘运维工程师的文案中见到：熟悉Linux Bash编程，精通Shell编程。
在CentOS里，/bin/sh是一个指向/bin/bash的符号链接:


