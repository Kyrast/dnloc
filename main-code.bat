@echo off
echo off
cls
TITLE Dungeons And Lines Of Code
setlocal enabledelayedexpansion

:menu
cls
echo %hp% %lvl% %exp% %exptill% !weapon! !playerdmg! %gold% %dmggain%
echo.
echo.
echo       ___________
echo .._____l_______l_____..
echo   .._____/  .  \____..
echo        /   .   \
echo       /    .    \
echo      /     .     \
echo     /      .      \
echo    /       .       \
echo   /        .        \
echo  .         .         .
echo   \        .        /
echo     \      .      /
echo       \    .    /
echo         \  .  /
echo           \./
echo            `
echo. 
echo ûûûûûûûûûûûûûûû
echo ûDungeons And Lines Of Codeû
echo ûûûûûûûûûûûûûûû               
echo.
echo 1) Begin!
echo 2) Exit.
echo 3) Look at the update notes.
echo. 
set /p c=Choice: 
if "!c!" == "1" goto new
if "!c!" == "2" exit
if "!c!" == "3" goto notes
goto menu 

:new
cls
set hp=100
set monster1hp=35
set playerdmg=7
set monster1dmg=7
set weapon=Fists
set gold=0
set slainm=0
set item1=Broadsword
set item1price=15
set item1damage=10
set item2=Curved Bow
set item2price=18
set item2damage=11
set storemsg=Ello there. Welcome to my shop.
set item1priceminus1=9
set item2priceminus1=10
set location=Kasdred
set goldearned=5
set exp=0
set exptill=10
set level=1
set dmggain=3
set battlemsg=Fight
set floor=0
set advmsg=On an adventure
set healermsg=Ello' there. I can heal ye' for 8 gold! Would that be fine? Y/N 
set bossdmg=!random! * 10 / 32768
set bosshp=!random! * 50 / 100
set boss=1
goto intro

:intro
cls 
echo Enter your name!
echo.
set /p name=

:home 
cls 
if !hp! lss 1 goto d-screen
set /a monster1hp=35
set battlemsg=Fight
echo Welcome Home, !name!. Feel nice and cozy here.
echo -----------------------------------------------------------------------------
echo --------------------------------------------------------------------------

echo ------------------------------Health: !hp! ---------------------------
echo  Slain Monsters: !slainm!     Damage: %playerdmg%   Weapon: %weapon%
echo.  Gold Coins: !gold!          EXP: !exp!/!exptill! Level: !level!   
echo.
echo Where would you like to travel?
echo 1) Outside the village.
echo 2) Go to merchant.
echo 3) Go to healer.
echo 4) Save the game.
echo 5) Exit.
echo.

if !slainm! == "5" (
set /a monster1hp=40
set /a monster1dmg=10
set /a goldearned=8
)
set /p i=Choice: 

if "%i%" == "1" goto adventure
if "%i%" == "5" goto menu
if "!i!" == "2" goto store
if "!i!" == "3" goto healer
if "!i!" == "4" goto add

goto home


:store
cls
echo !storemsg!
echo 1) !item1!
echo 2) !item2!
echo 3) Leave
set /p l=Choice: 

if "!l!" == "1" goto purchase.item1
if "!l!" == "2" goto purchase.item2
if "!l!" == "3" (
set storemsg=Ello there. Welcome to my shop.
goto home
)

:purchase.item1
set storemsg=Ello' there. Welcome to my shop. What'll it be?
cls
echo      ___________
echo ._____l_______l_____.
echo   ._____/  .  \____.
echo       /   .   \
echo      /    .    \
echo     /     .     \
echo    /      .      \
echo   /       .       \
echo  /        .        \
echo .         .         .
echo  \        .        /
echo    \      .      /
echo      \    .    /
echo        \  .  /
echo          \./
echo           `
echo Attributes: !item1! does 10 damage 
echo This item costs !item1price! gold. Would you like to buy it? (Y/N)
set /p s=Choice: 
if "!s!" == "y" (
if !gold! lss !item1price! (
set storemsg=You do not have enough money for this item.
goto store
)
if !gold! gtr !item1priceminus1! (
set playerdmg+=!item1damage!
set /a gold-=!item1price!
set weapon=!item1!
set item1=Waiting for new stock...
set item1price=0
set item1damage=0
set storemsg=Item Bought
goto store
)
)
if "!s!" == "n" goto store

:purchase.item2
set storemsg=Ello' there. Welcome to my shop. What'll it be?
cls
echo .\
echo . \
echo .  \
echo .   \
echo .   /
echo .  /
echo . /
echo Attributes: !item2! does !item2damage! damage. 
echo This item costs !item2price! gold. Would you like to buy it? Y/N
set /p s=Choice: 
if "!s!" == "y" (
if !gold! lss !item2price! (
set storemsg=You do not have enough money for this item.
goto store
)
if !gold! gtr !item2priceminus1! (
set playerdmg+=!item2damage!
set /a gold-=!item2price!
set weapon=!item2!
set item2=Waiting for new stock...
set item2price=0
set item2damage=0
set storemsg=Item Bought.
goto store
)
)

if "!s!" == "n" goto store


:enctr1
cls
echo An enemy has appeared! 
echo !battlemsg! 
echo Player: %hp%
echo Enemy: %monster1hp%
echo.
echo 1) Attack
echo 2) Flee
echo.
set /p o=Choice: 

if "!o!" == "1" goto attack1
if "!o!" == "2" goto cor
if !hp! lss 1 goto d-screen
goto enctr1

:attack1
set "q"=!random! * 10 / 32768
if !q! geq 7 (
goto enctr1
set /a playermissorhit=0
)
if !q! leq 6 (
set /a monster1hp-=!playerdmg!
set /a playermissorhit=!playerdmg!
)
set "l"=!random! * 10 / 32768
if !l! geq 5 (
goto enctr1
set enemymissorhit=0
)
if !l! leq 4 (
set /a hp-=!monster1dmg!
set /a enemymissorhit=!monster1dmg!
)
set battlemsg=You dealt !playermissorhit! damage. Enemy dealt !enemymissorhit! damage.
if !monster1hp! lss 1 goto continue1
if !hp! lss 1 goto d-screen
goto enctr1

:continue1 
cls
if "!slainm!" == "4" set /a monster1hp=40
if "!slainm!" == "4" set /a monster1dmg=10
set battlemsg=Fight
set /a gold+=!goldearned!
set /a slainm+=1
set /a floor+=1
set /a exp+=5
set /a advmsg= On an adventure
if !exp! geq !exptill! goto levelup
cls
echo !goldearned! more Gold. Advanced one floor.
pause

:adventure
cls
set /a monster1hp=35
if !slainm! geq "5" set /a monster1hp=40
if !slainm! geq "5" set /a monster1dmg=10
if !floor! == geq "50" goto stageboss
echo You are at floor %floor% on stage !location!.
echo !advmsg!
echo.
echo 1) Continue
echo 2) Go Home
set /p l=Choice:
if "!l!" == "1" goto adv-chances
if "!l!" == "2" goto home

:adv-chances
set /a chance=!random! * 4 / 32768 
if !chance! leq 2 (
set /a floor+=1
set advmsg=No enemies here
goto adventure
)

if !chance! geq 3 goto enctr1

:d-screen
cls 
echo You have died...
echo You lost some things.
set /a gold=!gold! - (!gold! * 65/100)
set /a exp=%exp% - (!exp! * 65/100)
set /a hp=40
pause >nul 
goto home

:run
cls
if !chanceofrun! leq 9 ( 
set battlemsg=Failed to run!
goto enctr1
)

:cor
set /a chanceofrun=!random! * 20 / 32768
if !chanceofrun! geq 10 (
cls
echo You ran away! 
pause >nul
goto home
)

if !chanceofrun! leq 9 goto run

:levelup
cls 
set /a level+=1
echo Congratulations. You have leveled up to level !level!.
set /a exp=0
set /a exptill=%exptill% + !exptill! * 66 / 100
set /a playerdmg+=!dmggain!
set /a hp=!hp! + (!hp! * 65/100)
pause >nul

:stats 
echo !name!: Level !level!
echo !exp!/!exptill! Experience
echo.
echo !hp!/100 health left.
echo !gold! gold.
echo You deal !playerdmg! damage.
echo You wield a !weapon!.
echo PRESS ANY KEY TO CONTINUE
pause >nul 
goto home

:healer
cls
echo !healermsg! 
echo Current HP: !hp!
set /p k=Choice: 
if "!k!" == "y" (
if !gold! lss 8 (
set healermsg=You do not have enough money for me. Get out.
pause 
goto home
)
set /a hp=100
set /a gold-=8
goto home
)
if "!k!" == "n" goto home

:stageboss
cls
echo Who dares disturb my slumber?
pause
echo Boss: !bossname!
echo Boss Health: !bosshp! 
goto attack2

:attack2 
cls
set /a hp-=!bossdmg!
set "q"=!random! * 10 / 32768
if !q! geq 7 (
goto enctr1
set /a playermissorhit=0
)
if !q! leq 6 (
set /a bosshp-=!playerdmg!
set /a playermissorhit=!playerdmg!
)
set "l"=!random! * 10 / 32768
if !l! geq 5 (
goto enctr1
)
set battlemsg=You dealt !playermissorhit! damage. Enemy dealt !bossdmg! damage.
if !bosshp! lss 1 goto afterboss
if !hp! lss 1 goto d-screen
goto enctr1

:bosses
if !boss! == "1" set bossname=Skeleton King
if !boss! == "2" set bossname=The Giant
if !boss! == "3" set bossname=Prime A.
if !boss! == geq "4" set bossname=Rotting Corpse
goto afterboss

:afterboss
echo Boss defeated!
set /a gold+=40
set /a boss+=1
set /a hp=100
set /a stage+=1
pause 
goto home

:notes
echo           Notes
echo ------------------------------------
echo.
echo The miss system is unable to function
echo.
echo       PRESS ANY KEY TO CONTINUE
pause>nul
goto home
