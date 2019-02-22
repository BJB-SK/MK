@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
use Imager::QRCode;

my $data = do './02_qr.pl';
foreach my $h (@$data)
{
	my $id = $h->{id};
	my $qr = $h->{qr};
    my $idName2 = sprintf("%04d", $id);
    
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
