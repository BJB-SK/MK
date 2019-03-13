@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
use utf8;

my $fileName = 'tricka.sql';
open my $fh, '>:utf8', $fileName or die "Can't open '$fileName' for writing: $!";
print $fh "declare \@idProduct int;\n";
# binmode($fh, ':utf8');
# print $fh chr(0xFEFF);
    
foreach my $type ('Tričko', 'Mikina') {
    my @sexes = ('Dámske', 'Pánske');
    my $price = 5.5;
    my $column = 'idTricko';
    my $colorColumn = 'idFarbaTricka';
    my $idProductCategory = 3;
    if($type eq 'Mikina') {
        @sexes = ('Dámska', 'Pánska');
        $price = 16;
        $column = 'idMikina';
        $colorColumn = 'idFarbaMikiny';
        $idProductCategory = 4;
    }
    my $idSize = 1;
    foreach my $sex (@sexes) {
        foreach my $size (qw(S M L XL XXL)) {
            my @colors = ('Žlté', 'Ružové');
            if($type eq 'Mikina') {
                @colors = ('Čierna', 'Žltá');
            }
            my $idColor = 0;
            foreach my $color (@colors) {
                my $name = "$type $sex $size $color";
                my $code = first2chars($type) . ' ' . first2chars($sex) . ' ' . 
                    $size . ' ' . first2chars($color);
                $code = lc($code);
                $code =~ s/á/a/g;
                $code =~ s/ž/z/g;
                $code =~ s/č/c/g;
                print $fh <<END;
INSERT INTO [dbo].[product] ([name], [price], [max], [code], [idProductCategory]) VALUES (N'$name', $price, 100, N'$code', $idProductCategory);

select \@idProduct = id from dbo.product where code = '$code';
insert into dbo.attendee_product (idAttendee, idProduct)
select id, \@idProduct
from dbo.attendee where $column = $idSize and $colorColumn = $idColor;

END
                $idColor++;
            }
            $idSize++;
        }
    }
}
close $fh;

sub first2chars {
    my $s = shift;
    if ($s =~ /^(..)/) {
        return $1;
    }
    return $s;
}