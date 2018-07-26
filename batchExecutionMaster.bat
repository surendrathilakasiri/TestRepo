@echo off

setlocal EnableDelayedExpansion
echo %1
echo %2
echo %3
echo %4
echo %5
echo %6
echo %7
echo %8
Set environment=%1
Set planName1=%2
Set planName2=%3
set SmokeOnly=%4
set RegressionOnly=%5
Set SmokeTestPassCriteria=%6
Set ReleaseName=%7
Set Browser=%8
set "pattern=Passed TC %"
set percentLine=""
set percent=""

if %SmokeOnly%==True (
	echo Executing Smoke Test only...
	call batchExecution.bat %environment% %planname1% %ReleaseName% %Browser%
	if %RegressionOnly%==True (
		for /F "tokens=* delims=" %%x in (ExecutionDetails.txt) do (
			set "line=%%x"
			if "!line:%pattern%=!"=="!line!" (
				REM Do nothing as the pattern not matched
			) else (
				set percentLine=%%x
			)
		)
		for %%A in (!percentLine!) do set last=%%~nA
		echo !last!
		set /a percent=!last!
	
		if !percent! GEQ %SmokeTestPassCriteria% (
			echo SmokeTest pass criteria passed. Executing Regression Test...
			call batchExecution.bat %environment% %planname2% %ReleaseName% %Browser%
		) else (
			echo SmokeTest Pass Criteria failed to meet. Exiting the testrun...
		)
	)
) else if %RegressionOnly%==True (
	echo Executing Regression Test only...	
	call batchExecution.bat %environment% %planname2% %ReleaseName% %Browser%
)