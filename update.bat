xcopy BJB-SK.github.io Website_public /s /e /y
copy BJB-SK.github.io\program.html Website_public\program.aspx
perl -x %0 & pause & exit
#!perl
use strict;
use warnings;
use File::Slurper qw(read_text write_text);

my $file = read_text('Website_public/index.html');
$file = '<%@ Master Language="C#" AutoEventWireup="true" CodeFile="MasterPageIndex.master.cs" Inherits="MasterPageIndex" %>' . 
	"\n" . $file;
$file =~ s{<!-- <asp:ContentPlaceHolder id="Registration(Head|Body)" runat="server"></asp:ContentPlaceHolder> -->}{<asp:ContentPlaceHolder id="Registration$1" runat="server"></asp:ContentPlaceHolder>}g;
$file =~ s/<head>/<head runat="server">/g;
$file =~ s/program\.html/program.aspx/g;
write_text('Website_public/MasterPageIndex.master', $file);

# $file = read_text('Website_public/program.html');
# write_text('Website_public/program.aspx', $file);

print "Success!\n";
