@echo off
setlocal EnableDelayedExpansion
echo %1
echo %2
echo %3
echo %4
echo %5


set environment=%1
set planName=%2
set releaseVersion=%3
set browserName=%4
set browserStackCapabilities=%5


(for /F "delims=" %%a in (environmentDataTemp.xml) do (
   set "line=%%a"
   set "newLine=!line:TargetTestEnvironment>=!"
   set "newLine2=!line:ReleaseVersion>=!"
   set "newLine3=!line:BrowserName>=!"
   set "newLine4=!line:BrowserStackCapabilities>=!"
   if "!newLine!" neq "!line!" (
      set "newLine=<TargetTestEnvironment>%environment%</TargetTestEnvironment>"
   ) else if "!newLine2!" neq "!line!" (
      set "newLine=<ReleaseVersion>%releaseVersion%</ReleaseVersion>"
   )else if "!newLine3!" neq "!line!" (
      set "newLine=<BrowserName>%browserName%</BrowserName>"
   )else if "!newLine4!" neq "!line!" (
      set "newLine=<BrowserStackCapabilities>%browserStackCapabilities%</BrowserStackCapabilities>"
   )
   echo !newLine!
   
)) > environmentData.xml

ant -buildfile buildTemp.xml -DtestngXml=Plans\%planName%.xml