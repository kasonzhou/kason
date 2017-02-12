#!/bin/bash
# printf

printf "%-5s %-10s %-4s\n" No Name Mark
printf "%-5s %-10s %-4.2f\n" 1 Kason 90.3456
printf "%-5s %-10s %-4.2f\n" 2 Jerry 80.1287
printf "%-5s %-10s %-4.2f\n" 3 Jim 70.9801

# print 和 printf 的区别

# printf使用引用文本或由空格分隔的参数。我们可以在printf中使用格式化字符串，还可以指定字符串的宽度、左右对齐方式等。

# %s\%c\%d\%f都是格式替换符，%-5s指明了一个格式为左对齐且宽度为5的字符串替换。


