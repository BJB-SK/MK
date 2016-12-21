@echo off & perl -x %0 >06_merge.bat & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# Image::Magick 
my $convert = qq|"C:\\Program Files\\ImageMagick-6.9.0-Q16\\convert.exe"|;
my $x_name = 410;
my $y_name = 720;
my $x_church = 370;
my $y_church = 925;
my $x_check = 646;
my $x_id = 1641;
my $y_id = 944;
my $x_id2 = 807;
my $y_id2 = 1179;

my %churches;
open IN, '<', '02_export.csv' or die $!;
while(<IN>)
{
    chomp;
    my($id, $name, $church, $pv, $pv2, $sr, $so, $sv, $sv2, $nr, $no) = split /\s*;\s*/;
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    my $churchName2 = $church;
    $churchName2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    if(1)
    {
        print "$convert front.png " .
            "\( Names\\$idName2.png -geometry +$x_name+$y_name +distort SRT -2.9 \) -composite " .
            "\( Churches\\$churchName2.png -geometry +$x_church+$y_church +distort SRT -2.9 \) -composite " .
            "\( Ids\\$idName2.png -geometry +$x_id+$y_id +distort SRT -90 \) -composite " .
            "Result\\${idName2}_front.png\n";
    }
    if(1)
    {
        print "$convert back.png " .
            ($pv  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+192 -composite " .
            ($pv2 ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+282 -composite " .
            ($sr  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+490 -composite " .
            ($so  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+624 -composite " .
            ($sv  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+754 -composite " .
            ($sv2 ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+843 -composite " .
            ($nr  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+1051 -composite " .
            ($no  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check+1141 -composite " .
            "Ids\\$idName2.png -geometry +$x_id2+$y_id2 -composite " .
            "Result\\${idName2}_back.png\n";
    }
}
