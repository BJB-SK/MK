@echo off & perl -x %0 >06_merge.bat & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# Image::Magick 
my $convert = qq|"C:\\Program Files\\ImageMagick-6.9.0-Q16\\convert.exe"|;
my $x_name = 201;
my $y_name = 2160;
my $x_church = 201;
my $y_church = 2804;
my $x_id = 1841;
my $y_id = 1134;
my $x_id2 = 1839;
my $y_id2 = 2928;
my $x_tshirt = 921;
my $y_tshirt = 2926;
my $x_check1 = 1098;
my $x_check2 = 2166;

my %churches;
open IN, '<', '02_export.csv' or die $!;
while(<IN>)
{
    chomp;
    my($id, $name, $church, $pv, $pv2, $sr, $so, $sv, $sv2, $nr, $no, $idTshirt) = split /\s*;\s*/;
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    my $churchName2 = $church;
    $churchName2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    if(1)
    {
        print "$convert front.png " .
            "\( Names\\$idName2.png -geometry +$x_name+$y_name \) -composite " .    # +distort SRT -2.9
            "\( Churches\\$churchName2.png -geometry +$x_church+$y_church \) -composite " . #+distort SRT -2.9
            #"\( Ids\\$idName2.png -geometry +$x_id+$y_id \) -composite " . # +distort SRT -90
            "Result\\${idName2}_front.png\n";
    }
    if(1)
    {
        print "$convert back.png " .
            ($pv  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+527 -composite " .
            ($pv2 ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+1049 -composite " .
            ($sr  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+1433 -composite " .
            ($so  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+1904 -composite " .
            ($sv  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+2281 -composite " .
            ($sv2 ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+2658 -composite " .
            ($nr  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+418 -composite " .
            ($no  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+1043 -composite " .
            #"Ids\\$idName2.png -geometry +$x_id2+$y_id2 -composite " .
            "Tshirts\\$idTshirt.png -geometry +$x_tshirt+$y_tshirt -composite " .
            "Result\\${idName2}_back.png\n";
    }
}
