@echo off

set JAVA_HOME=D:\AnyBuilder\bin\jdk\jdk1.6.0_32

call D:\AnyBuilder\bin\ant\apache-ant-1.8.4\bin\ant.bat -buildfile %~dp0conf\build.xml

pause
