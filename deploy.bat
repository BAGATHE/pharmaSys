@echo off
set webapp=D:\WindowsApp\Tomcat\webapps
set name=pharmacie
xcopy /s /e /i "bin\*" "web\WEB-INF\classes\"

cd web
jar -cvf "%name%.war" .

del %webapp%\%name%.war
del %webapp%\%name%.war.deployed
copy "%name%.war" "%webapp%"

del %name%.war
cd ..

pause


