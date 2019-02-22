@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# Image::Magick 
my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;

# front
my $x_id_front = 1993;
my $y_id_front = 3377;

# back
my $x_id_back = 1843;
my $y_id_back = 3368;
my $x_qr = 1842;
my $y_qr = 2870;

open FRONT, '>', "06_merge_empty_front.bat" or die $!;
open BACK, '>', "06_merge_empty_back.bat" or die $!;

foreach my $id (500..600)
{
    my $idName2 = sprintf("%04d", $id);
    
    print FRONT "$magick convert front.png " .
        "\( Ids\\$idName2.png -geometry +$x_id_front+$y_id_front \) -composite " . # +distort SRT -90
        "Front\\${idName2}.png\n";

    print BACK "$magick convert back.png " .
        "Ids\\$idName2.png -geometry +$x_id_back+$y_id_back -composite " .
        "\( QR\\$idName2.png -resize 484x484 \) -geometry +$x_qr+$y_qr -composite " .
        "Back\\${idName2}.png\n";
}
