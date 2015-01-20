#!/bin/bash

if [ $# == 0 ];
then
echo "usage : . myfs.sh command param1 param2..." 
echo "createdir -- for creating directory in current folder"
echo "createfile -- for creating file in a currrent directory"
echo "changedir --for changing directory"
echo "writeafile --for write content to a file"
echo "copyfile --copy file source to destination" 
echo "display  --display file content"
echo "listdir --list directory contents"
echo "searchfile -- find a file starting from current directory"
echo "searchfile2 -- find a file starting from a specified directory"
echo "copydir -- copy a directory to another directory"
fi
export ERRLOG='/tmp/myfs.log'

if [ !  -f  $ERRLOG ];
then
touch $ERRLOG  
fi


checkerror()
{
ec=$(grep -ci -E -e ERROR -e FAILED -e "command not found" -e "cannot" ${ERRLOG} )
if [ "0${ec}" -ne 0 ];
then  
echo "Error reported ."
echo "---------------"
cat $ERRLOG
fi
}
 

if [ "$1" == "createdir" ] ;
then
mkdir $2 >> $ERRLOG 
if [ $? -eq 0 ]; then
echo "created folder"
fi
fi



if [ "$1" == "createfile" ] ;
then
touch $2>> $ERRLOG
if [ $? -eq 0 ]; then
echo "created file"
fi
fi

if [ "$1" == "changedir" ] ;
then 
cd $2>> $ERRLOG
if [ $? -eq 0 ]; then
echo "changed directory"
fi
fi

if [ "$1" == "writeafile" ] ;
then 
echo $2 >> $3

if [ $? -eq 0 ]; then
echo "file written"
fi
fi

if [ "$1" == "copyfile" ] ;
then
cp $2 $3 >> $ERRLOG
if [ $? -eq 0 ]; then
echo "file successfully copied"
fi
fi

if [ "$1" == "display" ];
then
cat $2>>$ERRLOG
if [ $? -eq 0 ]; then
echo "success"
fi
fi

if [ "$1" == "listdir" ];
then 
ls -lrt $2>>$ERRLOG
if [ $? -eq 0 ]; then
echo "success"
fi
fi

if [ "$1" == "searchfile" ];
then 
find  -iname $2 >>$ERRLOG
if [ $? -eq 0 ]; then
echo "success"
fi
fi

if [ "$1" == "searchfile2" ];
then
find  $2 -name $3>>$ERRLOG
if [ $? -eq 0 ]; then
echo "Success"
fi
fi 

if [ "$1" == "copydir" ];
then 
cp -avr  $2 $3

if [ $? == 0 ]; then
echo "copied directory"
fi

fi

checkerror

if [ -f "$ERRLOG" ];
then
echo "deleting error file ${ERRLOG}"
cat $ERRLOG
/bin/rm -f $ERRLOG
fi

