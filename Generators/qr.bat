@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;

open SQL, '>', 'qr.sql' or die $!;

print SQL <<END;
DELETE FROM [dbo].[qr];
DBCC CHECKIDENT ('dbo.qr', RESEED, 1);
SET IDENTITY_INSERT dbo.qr ON;
END

my %alreadyGenerated;
my $n = 2000;
my $i = 1;
while($i < $n)
{
    my $code = getRandomCode();
	while(defined($alreadyGenerated{$code})) {
		$code = getRandomCode();
	}
    $alreadyGenerated{$code} = 1;
    print SQL "INSERT INTO [dbo].[qr] ([id], [seminare]) VALUES ($i, N'$code');\n";
    $i++;
}
print SQL <<END;
SET IDENTITY_INSERT dbo.qr OFF;
END

sub getRandomCode {
	my @chars = ('A'..'Z');
	my $string;
	$string .= $chars[rand @chars] for 1..4;
	return $string;
}
