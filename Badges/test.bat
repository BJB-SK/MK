@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;

# To run, install http://strawberryperl.com/ and http://www.imagemagick.org/
# ------------------------------------------------------------------------------

# the script will convert all photos in the folder where it's placed and 
# will put the corrected photos in the following folder
my $output_dir = "corrected";

# coordinates of the centers of the 4 little "L"s
my $top_left = "817,596";
my $top_right = "1687,573";
my $bottom_left = "728,1132";
my $bottom_right = "1773,1117";

# unfortunately, the "L"s don't form a square, but a rectangle
# 1. run with square = 1 (for a single photo)
# 2. measure dx and dy of center circle and enter them below
# 3. run with square = 0 (for a lot of photos with the same perspective)
my $square = 0;
my $dx = 560;
my $dy = 670;

# ------------------------------------------------------------------------------
# create output dir
if(!-d $output_dir) { mkdir $output_dir or die $!; }

# iterate over files in folder
for my $file (<*.jpg *.png>)
{
    print "\nProcessing $file...\n";
    # output file
    my $file2 = "$output_dir/$file";
    next if -e $file2;
    next unless -e $file;
    
    # get input image size
    my $s = `identify $file`;
    my($ix, $iy);
    if($s =~ /(\d+)x(\d+)/) { $ix = $1; $iy = $2; } else { die "Couldn't get image size."; }
    print "Image size: $ix x $iy\n";

    # output size
    my $ox = $ix;
    my $oy = $ix;   # nb: square output

    # new location of "L"s
    my $x1 = int(0.25 * $ox);
    my $x2 = int(0.75 * $ox);
    my $y1 = int(0.25 * $oy);
    my $y2 = int(0.75 * $oy);

    # correct rectangular position of "L"s
    my $m = int(($y1 + $y2) / 2);
    my $d = int(($y2 - $y1) * $dx / (2 * $dy));
    if(!$square) { $y1 = $m - $d; $y2 = $m + $d; }

    # call imagemagick
    my $p = "$top_left,$x1,$y1 " .
            "$top_right,$x2,$y1 " .
            "$bottom_left,$x1,$y2 " .
            "$bottom_right,$x2,$y2";
            
    my $c = "convert $file -virtual-pixel black" .
            " -define distort:viewport=${ox}x${oy}" .
            " -distort Perspective \"$p\" $file2";
    print $c, "\n";
    print `$c`;
}
