@echo off

rem tiffcomment.bat: a batch file for extracting the comment
rem                  (OME-XML block or otherwise) from a TIFF file

rem Required JARs: loci_tools.jar

rem JAR libraries must be in the same directory as this
rem command line script for the command to function.

rem If your CLASSPATH already includes the needed classes,
rem you can set the SCIFIO_DEVEL environment variable to
rem disable the required JAR library checks.

set PROG=loci.formats.tools.TiffComment
set DIR=%~dp0
if "%DIR:~1%" == ":\" (
  set DIR1=%DIR%
) else (
  rem Remove trailing backslash
  set DIR1=%DIR:~0,-1%
)

if "%SCIFIO_DEVEL%" == "" (
  rem Developer environment variable unset; look for proper libraries
  if exist "%DIR%loci_tools.jar" goto found
  if exist "%DIR%bio-formats.jar" goto found
  goto missing
) else (
  rem Developer environment variable set; try to launch
  java -mx512m %PROG% %*
  goto end
)

:found
rem Library found; try to launch
java -mx512m -cp "%DIR1%";"%DIR%bio-formats.jar";"%DIR%loci_tools.jar" %PROG% %*
goto end

:missing
echo Required JAR libraries not found. Please download:
echo   loci_tools.jar
echo from:
echo   http://www.loci.wisc.edu/bio-formats/downloads
echo and place in the same directory as the command line tools.

:end
