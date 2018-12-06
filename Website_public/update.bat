@echo off & perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
#use File::Slurper qw(read_text write_text);
#use File::Slurp;

print "Reading index.html...\n";

my $file = slurp_file('index.html');
$file = '<%@ Master Language="C#" AutoEventWireup="true" CodeFile="MasterPageIndex.master.cs" Inherits="MasterPageIndex" %>' . 
	"\n" . $file;
$file =~ s{<!-- <asp:ContentPlaceHolder runat="server" ID="Registration(Head|Body)"></asp:ContentPlaceHolder> -->}{<asp:ContentPlaceHolder runat="server" ID="Registration$1"></asp:ContentPlaceHolder>}gi;
$file =~ s/<head>/<head runat="server">/g;
$file =~ s/program\.html/program.aspx/g;
$file =~ s/seminare\.html/seminare.aspx/g;
spew_file('MasterPageIndex.master', $file);

print "Reading program.html...\n";
$file = slurp_file('program.html');
spew_file('program.aspx', $file);

print "Reading seminare.html...\n";
$file = slurp_file('seminare.html');
spew_file('seminare.aspx', $file);

print "Success!\n";

sub slurp_file
{
    my $name = shift;
    open my $fh, '<:encoding(UTF-8)', $name or die "Can't open '$name' for reading: $!";
    $/ = undef;
    my $data = <$fh>;
    close $fh;
    return $data;
}

sub spew_file
{
    my $name = shift;
    my $data = shift;
    open my $fh, '>:encoding(UTF-8)', $name or die "Can't open '$name' for writing: $!";
    print $fh chr(0xFEFF), $data;
    close $fh;
}