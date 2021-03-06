@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# Image::Magick 
my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;

# front
my $x_name = 83;
my $y_name = 156; # 399;
my $x_church = 83;
my $y_church = 925; # 1061;
my $x_id_front = 1993;
my $y_id_front = 3377;

# back
my $x_id_back = 1843;
my $y_id_back = 3368;
my $x_tshirt = 565;
my $y_tshirt = 3077;
my $y_hoodie = 3097;
my $x_check1 = 1082;
my $x_check2 = 1097;
my $x_check3 = 2275;
my $x_qr = 1842;
my $y_qr = 2870;

open FRONT, '>', "06_merge_front.bat" or die $!;
open BACK, '>', "06_merge_back.bat" or die $!;

my %churches;
my $inputFile = './02_export.pl';
my $data = do $inputFile;
if (!$data) {
    die "Couldn't parse $inputFile: $@" if $@;
    die "Couldn't do $inputFile: $!" unless defined $data;
    die "Couldn't run $inputFile" unless $data;
}
my $counter = 20;
foreach my $h (@$data)
{
	last if $counter-- == 0;
	my $id = $h->{id};
    my $church = $h->{church};
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    my $churchName2 = $church;
    $churchName2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    my $p = $h->{products};
    my $tshirt = '';
    my $hoodie = '';
    foreach my $c (keys %{$p}) {
        if($c =~ /^tr/) { $tshirt = $c; $tshirt =~ s/\s+/_/g; }
        if($c =~ /^mi/) { $hoodie = $c; $hoodie =~ s/\s+/_/g; }
    }
    my $qr = $h->{qr};
    
    print FRONT "$magick convert front.png " .
        "\( Names\\$idName2.png -geometry +$x_name+$y_name \) -composite " .    # +distort SRT -2.9
        "\( Churches\\$churchName2.png -geometry +$x_church+$y_church \) -composite " . #+distort SRT -2.9
        "\( Ids\\$idName2.png -geometry +$x_id_front+$y_id_front \) -composite " . # +distort SRT -90
        "Front\\${idName2}.png\n";

    print BACK "$magick convert back.png " .
        ($p->{pv}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+374 -composite " .
        ($p->{pv2} ? "check_yes.png" : "check_no.png") . " -geometry +$x_check1+953 -composite " .
        ($p->{sr}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+1413 -composite " .
        ($p->{so}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2013 -composite " .
        ($p->{sv}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2360 -composite " .
        ($p->{sv2} ? "check_yes.png" : "check_no.png") . " -geometry +$x_check2+2793 -composite " .
        ($p->{nr}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check3+277 -composite " .
        ($p->{no}  ? "check_yes.png" : "check_no.png") . " -geometry +$x_check3+953 -composite " .
        "Ids\\$idName2.png -geometry +$x_id_back+$y_id_back -composite " .
        ($tshirt ne '' ? "TShirts\\$tshirt.png -geometry +$x_tshirt+$y_tshirt -composite " : '') .
        ($hoodie ne '' ? "TShirts\\$hoodie.png -geometry +$x_tshirt+$y_hoodie -composite " : '') .
        "\( QR\\$idName2.png -resize 484x484 \) -geometry +$x_qr+$y_qr -composite " .
        "Back\\${idName2}.png\n";
}
