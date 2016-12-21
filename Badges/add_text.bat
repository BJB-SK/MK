convert v02_stA.png -gravity south -annotate +0+200 "Abigail Lehotkaiová" output.png
pause
rem -stroke '#000C' -strokewidth 2 -annotate 0 'Faerie Dragon' \
rem -stroke none -fill white

convert \
    -size 165x70 \
    xc:lightblue \
    -font Bookman-DemiItalic \
    -pointsize 12 \
    -fill blue \
    -gravity center \
    -draw "text 0,0 'It is 28 degrees today'" \
    image.png