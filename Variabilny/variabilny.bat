@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
#use Text::Levenshtein qw(distance);
use Text::Levenshtein::Damerau::XS qw/xs_edistance/;

open SQL, '>', 'variabilny.sql' or die $!;

print SQL <<END;
DELETE FROM [dbo].[variabilny];
DBCC CHECKIDENT ('dbo.variabilny', RESEED, 1);
SET IDENTITY_INSERT dbo.variabilny ON;
END

my @a;
my $x = 759; #seed
my $n = 2000;
my $i = 1;
while($i < $n)
{
    $x = (1103515245 * $x + 12345) & 0x7fffffff;
    #if(@a)
    #{
    #   my @distances = distance($x, @a);
    #   next if grep($_ < 4, @distances);
    #}
    my $good = 1;
	next unless length($x) == 9;
    for(@a) { if(xs_edistance($x, $_) < 4) { $good = 0; last; } }
    next unless $good;
    push @a, $x;
    print SQL "INSERT INTO [dbo].[variabilny] ([id], [vs]) VALUES ($i, $x);\n";
    $i++;
    print "$i -> $x\n";
}
print SQL <<END;
SET IDENTITY_INSERT dbo.variabilny OFF;
END
