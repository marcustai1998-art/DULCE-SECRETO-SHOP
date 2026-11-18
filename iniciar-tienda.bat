@echo off
title DULCE SECRETO - Servidor Local E-Commerce
echo ========================================================
echo     INICIANDO TIENDA VIRTUAL DULCE SECRETO
echo ========================================================
echo.
echo Abriendo navegador en http://localhost:3000 ...
start http://localhost:3000/index.html

echo.
echo Iniciando servidor HTTP local con agy-node...
"C:\Users\lis14\AppData\Roaming\Antigravity\bin\agy-node.cmd" server.js

pause
