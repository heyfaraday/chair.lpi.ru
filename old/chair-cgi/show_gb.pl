#!/usr/local/bin/perl -w

# $ARGV[0]-selected page, $ARGV[1]-1st page shown, $ARGV[2]- language

use DBI;
use CGI qw (:param);
use CGI::Carp qw(fatalsToBrowser);

$DB_HOST = 'localhost';
#$DB_NAME = '/usr/local/www/chair/rus/RCHAIR.GDB';
$DB_NAME = 'rchair' if  ($ARGV[2] eq 'rus');
$DB_NAME = 'echair' if  ($ARGV[2] eq 'eng');
$DB_USER = 'chair';
$DB_PASSWORD = 'casimir';
$DB_CHARSET = 'WIN1251';
$dsn = "DBI:Firebird:database=$DB_NAME;host=$DB_HOST;ib_charset=$DB_CHARSET";

my $dbh = DBI->connect($dsn, $DB_USER, $DB_PASSWORD) or die "Can't connect to 
$data_source: $DBI::errstr";


$sth = $dbh->prepare( qq(SELECT COUNT(*) FROM guest_book) ) or die $dbh->errstr;
$sth->execute();
@ary = $sth->fetchrow_array();
$num_of_rec=$ary[0];

$news2show=3;
$buts2show=5;

&get_news;
&get_buts;
&show_page;
exit;


sub get_news {

$sth = $dbh->prepare( qq(SELECT * FROM guest_book ORDER BY num DESC) ) or die $dbh->errstr;
$sth->execute();
$i=0;
while( @ary = $sth->fetchrow_array() ) {
                $i++;
                next if( $i<$news2show*($ARGV[0]-1) +1);

        $ary[4]=~s/(\bwww\.\S+\.\S+\b)/<A href=\"http:\/\/$1\">$1<\/A>/ig;
        $ary[4]=~s/(\b\S+\@\S+(\.\S+)+\b)/<A href=\"mailto:$1\">$1<\/A>/ig;
        $ary[4]=~s/\n/<BR>/ig;
        $sender='�����������' if  ($ARGV[2] eq 'rus');
        $sender='Sender' if  ($ARGV[2] eq 'eng');
        $recs.="<TR><TD><div align=right><B>".$ary[1]."</B></div><BR>
<div align=left><Font size=+1><B>&nbsp;&nbsp;&nbsp;&nbsp;$sender:
<U>".$ary[2]."</U></B></Font><B> (<A href='".$ary[3]."'>".$ary[3]."</A>)</B></div><BR>".$ary[4]."<hr noshade color=#ffffff><P></TD>\n";
                last  if( ($i==$news2show*$ARGV[0]) || ($i==$num_of_rec) );
        }
}

sub get_buts {
        $buts='';
        $slash='/';
        $total=1;
        $total=2 if (0!=$num_of_rec % $news2show);
        $total+=int ($num_of_rec / $news2show);
        goto EMPTY if($total==2);
        if($ARGV[1]>1) {
        $j=$ARGV[1]-$buts2show;
        $buts.=qq(<A href="/cgi-bin/show_gb.pl?$ARGV[0]+$j+$ARGV[2]"><< </A>);
        }
        else {
        $buts.='';
        }
        for ($i=$ARGV[1]; ($i<$ARGV[1]+$buts2show) && ($i<$total); $i++) {
                local $slash='' if( ($i==$ARGV[1]+$buts2show-1) || ($i==$total-1) );
                if($i==$ARGV[0]) {
                        $buts.=qq(<B style="color:#666666">$i </B> $slash\n);
                }
                else {
                        $buts.=qq(<A href="/cgi-bin/show_gb.pl?$i+$ARGV[1]+$ARGV[2]">$i </A>$slash \n);
                }
        }
        if($ARGV[1]+$buts2show<$total) {
        $j=$ARGV[1]+$buts2show;
        $buts.=qq(<A href="/cgi-bin/show_gb.pl?$ARGV[0]+$j+$ARGV[2]">>></A>);
        }
        else {
        $buts.='';
        }
EMPTY:
}

sub show_page {

if($ARGV[2] eq 'rus') {
        $title='�������� �����';
        $sign=qq(<u class=off onmouseover="this.className='on'" onmouseout="this.className='off'"
        onclick="document.location='/rus/add_rec.html'" title='������� ������'>&amp\;</u>);
}
if($ARGV[2] eq 'eng') {
        $title='Guest book';
        $sign=qq(<u class=off onmouseover="this.className='on'" onmouseout="this.className='off'"
        onclick="document.location='/eng/add_rec.html'" title='Make a record'>&amp\;</u>);
}


print <<EOF;
Content-type: text/html

<html>
<head>
<title>$title</title></head>
<meta charset="windows-1251">
<LINK type="text/css" HREF="/rus/comsheet.css" rel="stylesheet">
<STYLE type="text/css">
.off
        {color:#666666; font-weight:bold;text-decoration: none}
.on
        {color:black; font-weight:bold; cursor:hand; text-decoration: none}
A 
        {font-weight:bold; font-family:Arial}
</STYLE>
</head> 

<body bgcolor=#999999 text=#111111 alink=black vlink=black link=black>
<basefont face="Times New Roman">
<center>
<table width=85% height=100% bgcolor=#b6b6b6 border=0 cellpadding=0 cellspacing=0>
<tr><td align=center valign=top>

<table width=85% height=5 border=0 cellpadding=0 cellspacing=0>
<tr><td></td>
</table>

<table width=85% height=70 border=0 cellpadding=0 cellspacing=0>
<tr><td align=center ID=heading>$title <Font face="Wingdings">$sign</Font>
</td></tr>
</table>
<hr width=80%>

<table width=80% height=40 border=0 cellpadding=0 cellspacing=0>
<tr valign=top><td align=left><font size=+1 color=black>
$buts
</font>
</td>
</tr>
</table>

<table width=80% border=0 cellpadding=0 cellspacing=0>
$recs
</table>
<p>
</td></tr>
</table>
</center>

</body>
</html>
EOF
}