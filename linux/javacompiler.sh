function setVar(){
		export filename=$(echo $1 | cut -d . -f 1) 
		export suffix=$(echo $1 | cut -d . -f 2)
}
function exeCommand(){
		echo "编译中........"
		ecj $1      #编译生成class文件
		echo "转换中........"
		dx --dex ${filename}.class > ${filename}.dex  #生成dalvil虚拟机运行的dex类文件
		echo "运行中........"
		dalvikvm -classpath ${filename}.dex ${filename} #运行dex类，并指定主类


}
function checkDevEnv(){
	if ! command -v ecj 1>/dev/null 2>&1 ;then
			echo "你未安装ecj，正在安装ecj"
			apt install ecj 
		    if [ $? != 0 ] ;   then 
					echo "安装失败"
					exit -1
			fi
	fi
    if ! command -v dx 1>/dev/null 2>&1 ;then
			echo "你未安装dx，正在安装dx"
			apt install dx
			if [ $? != 0 ] ;   then 
					echo "安装失败"
					exit -1
			fi
	fi
	if ! command -v dalvikvm 1>/dev/null 2>&1 ;then
			echo "你未安装dalvikvm，正在安装dalvikvm"
			apt install dalvikvm
		    if [ $? != 0 ] ;   then 
					echo "安装失败"
					exit -1
			fi	 
	fi


}
function useage(){
    if [ ${suffix}x != "java"x ]; then
			echo "你的java源代码需要以.java结尾"
			exit -1
	fi



}

function main(){
		useage
		checkDevEnv
		setVar $1
    	exeCommand $1
}

main $1

