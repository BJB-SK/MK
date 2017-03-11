montage front.png front.png front.png front.png -tile 2x2 -border 1x1 -geometry +0+0 Result\empty_front.png
montage back.png back.png back.png back.png -tile 2x2 -border 1x1 -geometry +0+0 Result\empty_back.png
"C:\Program Files\ImageMagick-6.9.0-Q16\convert.exe" -density 600 Result\empty_front.png Result\empty_back.png PDF\output_empty.pdf
