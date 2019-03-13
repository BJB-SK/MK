@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
use Data::Dumper;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# export -> encode in utf-8 without bom

my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;
my $sizeId = '483x101';
my $sizeName = '1403x717'; # '1443x487';
my $sizeChurch = '1163x913'; # '1093x755';
my $sizeTeeShirt = '603x74';
my $options = '-background black -transparent black -fill white -font font.otf';

open IDS, '>', "04_generate_ids.bat" or die $!;
open NAMES, '>', "04_generate_names.bat" or die $!;
open CHURCHES, '>', "04_generate_churches.bat" or die $!;
open TSHIRTS, '>', "04_generate_tshirts.bat" or die $!;

my %tshirts;
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
	my $qr = $h->{qr};
    my $products = $h->{products};
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    $churches{$church} = 1;
    foreach my $item (keys %{$products}) {
        if($item =~ /^(tr|mi)/) {
            $tshirts{$item} = 1;
        }
    }
	# id
    if (!-e "./Ids/$idName2.png") {
        print IDS "$magick convert -size $sizeId $options -gravity center caption:$idName2 Ids\\$idName2.png\n";
    }
	# name
    if (!-e "./Names/$idName2.png") {
        open OUT, '>', "Names\\$idName2.txt" or die $!;
        print OUT "\n" . $h->{name};
        close OUT or die $!;
        print NAMES "$magick convert -size $sizeName $options -gravity SouthWest caption:\@Names\\$idName2.txt Names\\$idName2.png\n";
    }
}

foreach my $id (500..600)
{
    my $idName2 = sprintf("%04d", $id);
    if (!-e "./Ids/$idName2.png") {
        print IDS "$magick convert -size $sizeId $options -gravity center caption:$idName2 Ids\\$idName2.png\n";
    }
}

for my $name (keys %churches)
{
    my $name2 = $name;
    $name2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    open OUT, '>', "Churches\\$name2.txt" or die $!;
    print OUT "\n" . $name;
    close OUT or die $!;
    print CHURCHES "$magick convert -size $sizeChurch $options -gravity NorthWest caption:\@Churches\\$name2.txt Churches\\$name2.png\n";
}

for my $name (keys %tshirts)
{
    my $fileName = $name;
    $fileName =~ s/\s+/_/g;
    open OUT, '>', "TShirts\\$fileName.txt" or die $!;
    print OUT $name;
    close OUT or die $!;
    print TSHIRTS "$magick convert -size $sizeTeeShirt $options -gravity center caption:\@TShirts\\$fileName.txt TShirts\\$fileName.png\n";
}
