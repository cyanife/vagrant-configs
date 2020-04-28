@echo off
@cd /d %~dp0

@doskey vpu=vagrant snapshot push
@doskey vpo=vagrant snapshot pop 
@doskey vs=vagrant suspend $T exit 
@doskey vr=vagrant resume $T vagrant ssh 
@doskey vh=vagrant halt $T exit 
@doskey vu=vagrant up $T vagrant ssh 

for /f "tokens=2* delims=," %%F IN ('vagrant status --machine-readable ^| find /I "state-human-short"') DO (SET "STATE=%%F%%G")
SET STATE=%STATE:~25%

IF "%STATE%"=="poweroff" (vagrant up) 
IF "%STATE%"=="saved" (vagrant resume)
vagrant ssh