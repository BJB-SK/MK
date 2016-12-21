montage front.png front.png front.png front.png -tile 2x2 -geometry +0+0 -quality 80 -rotate 90 Result\empty_front.jpg
montage back.png back.png back.png back.png -tile 2x2 -border 4x4 -bordercolor white -geometry 1234x1742+4+4 -quality 80 -rotate -90 Result\empty_back.jpg
"C:\Program Files\ImageMagick-6.9.0-Q16\convert.exe" Result\empty_front.jpg Result\empty_back.jpg PDF\output_empty.pdf
