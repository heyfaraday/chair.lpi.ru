#!/usr/local/bin/perl -w

use CGI::Carp qw(fatalsToBrowser);

print <<EOF;
Content-type: text/html

<html>
<head>
<title>����������</title>
<meta charset="windows-1251">
<LINK type="text/css" HREF="/rus/comsheet.css" rel="stylesheet">
<STYLE type="text/css">
        .off
               {color:#666666; font-family:"Arial Narrow"; font-weight:bold}
        .on
             {color:blue; font-family:"Arial Narrow"; font-weight:bold; cursor:pointer}
</STYLE>
</head> 
<body bgcolor=#999999 text=#111111 alink=black vlink=black link=black>
<center>
<table width=85% height=100% bgcolor=#b6b6b6 border=0 cellpadding=0 cellspacing=0>
<tr valign=top><td align=center>

<table width=85% height=5 border=0 cellpadding=0 cellspacing=0>
<tr><td></td>
</table>

<table width=85% height=70 border=0 cellpadding=0 cellspacing=0>
<tr><td align=center ID=heading>���������� <Font face="webdings">&igrave;</Font></td>
</table>
<hr width=80%>

<table width=80% height=40 border=0 cellpadding=0 cellspacing=0>
<tr valign=top><td align=right>
<u class=off onmouseover="this.className='on'" onmouseout="this.className='off'"
   onclick="document.location='/rus/grad.shtml'">�����</u>
</td>
</tr>
</table>

<table border=0 width=85% cellpadding=0 cellspacing=0>
<tr><td>
<FORM name='send' action="/cgi-bin/add_grad.pl" method=post>
<FIELDSET>
<LEGEND><b>����� ���������</b></LEGEND>

<table border=0 width=90% cellpadding=0 cellspacing=0>
<tr><td align=center>������� �.�.:</td><td> <input size=25 type=text name="name"/></td>
<tr><td align=center>���:</td>
        <td>�&nbsp;<input type=radio name=sex value='�'>&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;�&nbsp;<input type=radio name=sex value='�'></td>
<tr><td align=center>��� ������:</td><td> <input size=3 type=text name="in"/></td>
<tr><td align=center>��� �������:</td><td> <input size=3 type=text name="out"/></td>
<tr><td align=center>������:</td>
<td>
<SELECT name='status' rows="3">
        <OPTION value="s">�������</OPTION>
        <OPTION value="a">��������</OPTION>
        <OPTION value="sa">�������, ��������</OPTION>
</SELECT>
</td>
<tr><td align=center>�������(�):</td>
<td>
<SELECT name='defend' rows="3">
        <OPTION value="no"></OPTION>
        <OPTION value="d">������</OPTION>
        <OPTION value="a">�����������</OPTION>
        <OPTION value="da">������, �����������</OPTION>
</SELECT>
</td>

<tr><td align=center>������� ������������:</td><td> <input size=20 type=text name="r_adv1"/></td>

<tr><td align=center>������� ������������:</td><td> <input size=20 type=text name="r_adv2"/></td>

<tr><td align=center>������� ������������:</td><td> <input size=20 type=text name="r_adv3"/></td>

<tr><td align=center>������� ������������:</td><td> <input size=20 type=text name="r_adv4"/></td>

</table>

</FIELDSET>
<p>
<tr><td>&nbsp;<button onclick="if(confirm('�� �������?')) document.forms.send.submit()">��������</button><button onclick="document.forms.send.reset()">��������</button>
</td></tr>
</table>
</FORM>

</td></tr>
</table>
</center>

</body>
</html>

EOF

exit;