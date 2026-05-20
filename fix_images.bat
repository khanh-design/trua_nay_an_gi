@echo off
:: ============================================================
:: fix_images.bat - Copy ảnh mới vào đúng thư mục /images/dish/
:: Chạy file này 1 lần để sửa lỗi không hiện ảnh
:: ============================================================

set BASE=src\main\resources\static\images\dish

echo [1/4] Tao cac thu muc con trong /images/dish/ ...
mkdir "%BASE%\toppings"  2>nul
mkdir "%BASE%\vegetables" 2>nul
mkdir "%BASE%\juice"      2>nul
mkdir "%BASE%\healthy"    2>nul

echo [2/4] Copy anh Topping...
copy /Y "src\main\resources\static\images\toppings\*" "%BASE%\toppings\"

echo [3/4] Copy anh Rau cu - Nuoc ep - Healthy...
copy /Y "src\main\resources\static\images\vegetables\*" "%BASE%\vegetables\"
copy /Y "src\main\resources\static\images\juice\*"      "%BASE%\juice\"
copy /Y "src\main\resources\static\images\healthy\*"    "%BASE%\healthy\"

echo [4/4] Ket qua:
echo --- Toppings:
dir /b "%BASE%\toppings"
echo --- Vegetables:
dir /b "%BASE%\vegetables"
echo --- Juice:
dir /b "%BASE%\juice"
echo --- Healthy:
dir /b "%BASE%\healthy"

echo.
echo ===================================
echo XONG! Restart Spring Boot la xong.
echo ===================================
pause
