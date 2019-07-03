#!/bin/bash
current_path=$(pwd)

var1=$(echo "$current_path"|awk -F '/' '{print $2}')

var2=$(echo "$current_path"|awk -F '/' '{print $3}')

gitConfig_path="/"${var1}"/"${var2}"/.gitconfig"

echo ${gitConfig_path}

if [ ! -f "$gitConfig_path" ]; then
	echo "git配置文件不存在~~~~"
	exit
fi

echo "保存.gitconfig文件到当前路径下:"
cp ${gitConfig_path} ./


echo ".gitconfig中的[alias]的位置:"
originLocation=$(grep -n '\[alias\]' ${gitConfig_path} |head -1 | cut -f 1 -d":")

originLocation=$((10#${originLocation} - 1)) 

echo ${originLocation}

if [[ ${originLocation} != '-1'	]]; then
	#删除 文本中的[alias]
	sed -n '/[^[alias]]/,/[[alias]]/p' ${gitConfig_path} | sed '/[[alias]]/d' > tmp.txt

	echo "提取出来的配置文件:"

	cat tmp.txt

	sed -i '' "${originLocation} r ./gitAlias" tmp.txt

	echo "最终输出:"

	cat tmp.txt

	cat tmp.txt > ${gitConfig_path}

	rm -r tmp.txt
else
	echo "之前没有alias，现在新增"
	cat ./gitAlias >> ${gitConfig_path}
fi



