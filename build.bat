@echo off

set src=src\
set lib=lib\
set bin=bin
set temp_src=temp_src

mkdir %temp_src%

cd "%src%"

for /r %%F in (*.java) do (
    copy "%%F" "..\%temp_src%"
)


javac -cp ../%lib%* -g:vars -d ../%bin% ../%temp_src%/*.java

cd ../

pause