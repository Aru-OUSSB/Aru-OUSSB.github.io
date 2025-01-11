@echo off
cd /d %~dp0
:loop
julia Codes/auto_update.jl
timeout /t 60
goto loop
