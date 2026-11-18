@echo off
echo ========================================================
echo   PUBLICAR TIENDA DULCE SECRETO EN INTERNET
echo ========================================================
echo.
echo Abriendo la carpeta del proyecto y la pagina de despliegue...
echo Solo debes arrastrar la carpeta 'dulce-secreto' a la pagina web.
echo.
explorer "%~dp0"
start https://app.netlify.com/drop
pause
