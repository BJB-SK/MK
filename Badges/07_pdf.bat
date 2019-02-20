@echo off & perl -x %0 >08_pdf.bat & pause & exit
#!perl
use strict;
use warnings;

# http://strawberryperl.com/ 
# http://www.imagemagick.org/

my $magick = qq|"C:\\Program Files\\ImageMagick-7.0.8-Q16\\magick.exe"|;

my @ids;
my $data = do './02_export.pl';
foreach my $h (@$data)
{
	my $id = $h->{id};
    my $idName2 = sprintf("%04d", $id);
    push @ids, $idName2;
}

my @result;
my $mx = 2;
my $my = 2;
my $page = $mx * $my;

my $i = 0;
my $p = 0;
my @pages;
my $s = 0;
while($i < @ids)
{
    my $p2 = sprintf('%03d', $p);
    my $start = $i;
    # front
    my @front;
    for(my $j = 0; $j < $page; $j++)
    {
        push @front, sprintf("Result\\%s_front.png", get_id($i));
        $i++;
    }
    print "$magick montage " . join(' ', @front) . " -tile ${mx}x${my} -border 1x1 -geometry +0+0 Result\\set_${p2}_front.png\n"; # -rotate 90  -quality 80 
    # back
    my @back;
    for(my $y = 0; $y < $my; $y++)
    {
        for(my $x = 0; $x < $mx; $x++)
        {
            my $k = $start + $y * $mx + ($mx - $x - 1);
            push @back, sprintf("Result\\%s_back.png", get_id($k));
        }
    }
    #4961 x 7016 px
    print "$magick montage " . join(' ', @back) . " -tile ${mx}x${my} -border 1x1 -geometry +0+0 Result\\set_${p2}_back.png\n"; # -rotate -90  -quality 80  -geometry 1234x1742+4+4
    #-bordercolor white
    # 
    
    push @pages, "Result\\set_${p2}_front.png", "Result\\set_${p2}_back.png";
    $p++;
    if(($p % 1000) == 0)
    {
        print "$magick convert -density 600 " . join(' ', @pages) . sprintf(" PDF\\output_%02d.pdf\n", $s++);
        @pages = ();
    }
}
print "$magick convert -density 600 " . join(' ', @pages) . sprintf(" PDF\\output_%02d.pdf\n", $s++);

sub get_id
{
    my $i = shift;
    if($i >= @ids) { $i = @ids - 1; }
    return $ids[$i];
}
