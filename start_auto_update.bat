@echo off
cd /d %~dp0
:loop
julia auto_update.jl
timeout /t 60
goto loop
