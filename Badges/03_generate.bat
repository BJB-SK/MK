@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
use Data::Dumper;
use Imager::QRCode;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# export -> encode in utf-8 without bom

my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;
my $sizeId = '483x101';
my $sizeName = '2330x650';
my $sizeChurch = '2330x1040';
my $sizeTeeShirt = '603x74';
my $options = '-background black -transparent black -fill white -font font.otf';

open IDS, '>', "04_generate_ids.bat" or die $!;
open NAMES, '>', "04_generate_names.bat" or die $!;
open CHURCHES, '>', "04_generate_churches.bat" or die $!;
open TSHIRTS, '>', "04_generate_tshirts.bat" or die $!;

my %churches;
my $data = do './02_export.pl';
# my $counter = 10;
foreach my $h (@$data)
{
	# last if $counter-- == 0;
	my $id = $h->{id};
    my $church = $h->{church};
	my $qr = $h->{qr};
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    $churches{$church} = 1;
	# id
    print IDS "$magick convert -size $sizeId $options -gravity center caption:$idName2 Ids\\$idName2.png\n";
	# name
    open OUT, '>', "Names\\$idName2.txt" or die $!;
    print OUT "\n", $h->{name};
    close OUT or die $!;
    print NAMES "$magick convert -size $sizeName $options -gravity NorthWest caption:\@Names\\$idName2.txt Names\\$idName2.png\n";
	
	# QR codes
    my $url = "http://mk.baptist.sk/seminare/?q=$qr";
 
	my $qrcode = Imager::QRCode->new(
		size          => 2,
		margin        => 2,
		version       => 1,
		level         => 'M',
		casesensitive => 1,
		lightcolor    => Imager::Color->new(255, 255, 255),
		darkcolor     => Imager::Color->new(0, 0, 0),
	);
	my $img = $qrcode->plot($url);
	$img->write(file => "QR\\$idName2.png") or die "Failed to write: " . $img->errstr;
}

for my $name (keys %churches)
{
    my $name2 = $name;
    $name2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    open OUT, '>', "Churches\\$name2.txt" or die $!;
    print OUT "\n", $name;
    close OUT or die $!;
    print CHURCHES "$magick convert -size $sizeChurch $options -gravity NorthWest caption:\@Churches\\$name2.txt Churches\\$name2.png\n";
}

my @size = ('', 'D-S', 'D-M', 'D-L', 'D-XL', 'D-XXL', 'P-S', 'P-M', 'P-L', 'P-XL', 'P-XXL');
my @colorTShirt = ('ZL', 'RU');
my @colorHoodie = ('CI', 'ZL');
for my $idTShirt (0..@size-1) {
    for my $idTShirtColor (0..@colorTShirt-1) {
        for my $idHoodie (0..@size-1) {
            for my $idHoodieColor (0..@colorHoodie-1) {
                my $fileName = "${idTShirt}_${idTShirtColor}_${idHoodie}_${idHoodieColor}";
                my $text = '';
                if ($idTShirt > 0) {
                    $text .= 'Tr ' . $size[$idTShirt] . ' ' . $colorTShirt[$idTShirtColor];
                }
                if ($idHoodie > 0) {
                    if ($text ne '') { $text .= ', '; }
                    $text .= 'Mi ' . $size[$idHoodie] . ' ' . $colorHoodie[$idHoodieColor];
                }
                if ($idTShirt > 0 || $idHoodie > 0) {
                    open OUT, '>', "TShirts\\$fileName.txt" or die $!;
                    print OUT $text;
                    close OUT or die $!;
                    print TSHIRTS "$magick convert -size $sizeTeeShirt $options -gravity center caption:\@TShirts\\$fileName.txt TShirts\\$fileName.png\n";
                }
            }
        }
    }
}
