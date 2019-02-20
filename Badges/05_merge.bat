@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# Image::Magick 
my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;

# front
my $x_name = 75;
my $y_name = 240;
my $x_church = 75;
my $y_church = 900;
my $x_id_front = 1993;
my $y_id_front = 3377;

# back
my $x_id_back = 1843;
my $y_id_back = 3368;
my $x_tshirt = 565;
my $y_tshirt = 3077;
my $x_check1 = 1082;
my $x_check2 = 1097;
my $x_check3 = 2275;
my $x_qr = 1842;
my $y_qr = 2870;

open FRONT, '>', "06_merge_front.bat" or die $!;
open BACK, '>', "06_merge_back.bat" or die $!;

my %churches;
my $data = do './02_export.pl';
# my $counter = 10;
foreach my $h (@$data)
{
	# last if $counter-- == 0;
	my $id = $h->{id};
    my $church = $h->{church};
    # my($pv, $pv2, $sr, $so, $sv, $sv2, $nr, $no, $idTshirt) = split /\s*;\s*/;
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    my $churchName2 = $church;
    $churchName2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    my $tshirt = "$h->{idTShirt}_$h->{idTShirtColor}_$h->{idHoodie}_$h->{idHoodieColor}";
    my $hasTShirt = $h->{idTShirt} > 0 || $h->{idHoodie} > 0;
    my $qr = $h->{qr};
    
    print FRONT "$magick convert front.png " .
        "\( Names\\$idName2.png -geometry +$x_name+$y_name \) -composite " .    # +distort SRT -2.9
        "\( Churches\\$churchName2.png -geometry +$x_church+$y_church \) -composite " . #+distort SRT -2.9
        "\( Ids\\$idName2.png -geometry +$x_id_front+$y_id_front \) -composite " . # +distort SRT -90
        "Result\\${idName2}_front.png\n";

    print BACK "$magick convert back.png " .
        ($h->{pv}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+374 -composite " .
        ($h->{pv2} ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+953 -composite " .
        ($h->{sr}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+1413 -composite " .
        ($h->{so}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2013 -composite " .
        ($h->{sv}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2360 -composite " .
        ($h->{sv2} ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2793 -composite " .
        ($h->{nr}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check3+277 -composite " .
        ($h->{no}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check3+953 -composite " .
        "Ids\\$idName2.png -geometry +$x_id_back+$y_id_back -composite " .
        ($hasTShirt ? "TShirts\\$tshirt.png -geometry +$x_tshirt+$y_tshirt -composite " : '') .
        "\( QR\\$idName2.png -resize 484x484 \) -geometry +$x_qr+$y_qr -composite " .
        "Result\\${idName2}_back.png\n";
}
