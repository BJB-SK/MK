@echo off & perl -x %0 >04_generate.bat & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/
# export -> encode in utf-8 without bom

my $convert = qq|"C:\\Program Files\\ImageMagick-6.9.0-Q16\\convert.exe"|;
my $size = '2009x339';      # name
my $size2 = '500x130';      # id
my $size3 = '2005x335';     # church
my $size4 = '239x77';       # t-shirt

my %churches;
open IN, '<', '02_export.csv' or die $!;
while(<IN>)
{
    chomp;
    my($id, $name, $church, $pv, $pv2, $sr, $so, $sv, $sv2, $nr, $no, $idTshirt) = split /\s*;\s*/;
    my $idName2 = sprintf("%04d", $id);
    if($church eq '') { $church = ' '; }
    $churches{$church} = 1;
    open OUT, '>', "Names\\$idName2.txt" or die $!;
    print OUT $name;
    close OUT or die $!;
    # name
    print "$convert -background white -transparent white -fill black -font Geometric-231-AT " .
        "-size $size -gravity center label:\@Names\\$idName2.txt Names\\$idName2.png\n";
    # id
    #print "$convert -background white -transparent white -fill black -font Geometric-231-AT " . # -transparent '#0b1837'
    #    "-size $size2 -gravity center label:$idName2 Ids\\$idName2.png\n";
}

for my $name (keys %churches)
{
    my $name2 = $name;
    $name2 =~ s/([^A-Za-z])/sprintf('%2.2x', unpack('U0U*', $1))/ge;
    open OUT, '>', "Churches\\$name2.txt" or die $!;
    print OUT $name;
    close OUT or die $!;
    print "$convert -background white -transparent white -fill black -font Geometric-231-AT " .
        "-size $size3 -gravity center label:\@Churches\\$name2.txt Churches\\$name2.png\n";
}

my $i = 0;
for my $name (qw(Žiadne D-S D-M D-L D-XL D-XXL P-S P-M P-L P-XL P-XXL))
{
    open OUT, '>', "Tshirts\\$i.txt" or die $!;
    print OUT $name;
    close OUT or die $!;
    print "$convert -background white -transparent white -fill black -font Geometric-231-AT " .
        "-size $size4 -gravity center label:\@Tshirts\\$i.txt Tshirts\\$i.png\n";
    $i++;
}
