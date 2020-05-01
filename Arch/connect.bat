@echo off
@cd /d %~dp0

@setlocal enableDelayedExpansion
@doskey vpu=vagrant snapshot push
@doskey vpo=vagrant snapshot pop 
@doskey vrl=vagrant reload $T vagrant ssh
@doskey vsh=vagrant ssh
@doskey vs=vagrant suspend $T exit 
@doskey vr=vagrant resume $T vagrant ssh 
@doskey vh=vagrant halt $T exit 
@doskey vu=vagrant up $T vagrant ssh 
@doskey h=doskey /macros

for /f "tokens=2* delims=," %%F IN ('vagrant status --machine-readable ^| find /I "state-human-short"') DO (SET "STATE=%%F%%G")
SET STATE=%STATE:~25%

IF "%STATE%"=="poweroff" (vagrant up) 
IF "%STATE%"=="aborted" (vagrant up) 
IF "%STATE%"=="saved" (vagrant resume)
vagrant ssh