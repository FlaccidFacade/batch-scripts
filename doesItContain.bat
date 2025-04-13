@setlocal enableextensions enabledelayedexpansion
@echo off
set str2Check=%1
set pattern2Find=%2
if not x%str2Check:%pattern2Find=%==x%str2Check% echo It contains bcd
endlocal