"C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe" montage front_empty.png front_empty.png front_empty.png front_empty.png -tile 2x2 -border 1x1 -geometry +0+0 Result2\empty_front.png
"C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe" montage back_empty.png back_empty.png back_empty.png back_empty.png -tile 2x2 -border 1x1 -geometry +0+0 Result2\empty_back.png
"C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe" convert -density 600 Result2\empty_front.png Result2\empty_back.png PDF\output_empty.pdf
pause