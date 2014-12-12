#!/usr/bin/perl

&parse_form;

$mode=$Form{'mode'};
$sort=$Form{'sort'};
$ndisplay=$Form{'ndisplay'};
$query=$Form{'query'};
$filter=$Form{'filter'};
$boostFormula=$Form{'boost'};
$correlFormula=$Form{'correl'};

##$correlFormula="%n12 / sqrt(%n1 * %n2)";
$correlFormula=~s/\%/\$/g;

if ($correlFormula ne "") {
  open(OUT,">formula.pl");
  print OUT "sub getRho{\nmy \$rho;\n\$rho=$correlFormula;\nreturn(\$rho)\n}\n1;\n";
  close(OUT);
##  require "c:\\vlg\\logs\\formula.pl";  #---------------------<<
  require "/home/cluster1/data/d/x/a1168268/cgi-bin/formula.pl"; 
}


if ($sort eq "Ascending") { $sort="a"; }
if ($sort eq "Descending") { $sort="d"; }

if ($mode eq "Silent") { $mode="silent"; }
if ($mode eq "Verbose") { $mode="verbose"; }

if ($filter eq "Yes") { $filter="y"; }
if ($filter eq "No") { $filter="n"; }



##$ndisplay=12;   #----------------<<
##$query="real estate";  #----------------<<
##$filter="n";  #--------------------<<

$query=~s/\n//g;
$query=~s/\+//g;
@aux=split(' ',$query);
$nw=$#aux+1;
for ($k=0; $k<$nw; $k++) {
  $word_i=$aux[$k];
  $head=substr($word_i,0,1);
  if (($head ge 'a')&&($head le 'z')) {
    $filename="../data/kw/kwsum2s_SRCH_CLICKS_$head.txt";
##    $filename="kwsum2s_SRCH_CLICKS_$head.txt";  ##--------<<

  } else {
    $filename="../data/kw/kwsum2s_SRCH_CLICKS_0.txt";
##    $filename="kwsum2s_SRCH_CLICKS_$head.txt";  ##----------<<

  }
  if ($read{$filename} eq "") {
    open(IN,"<$filename");
    while ($i=<IN>) {
      $rows++;
      @lu=split(/\t/,$i);
      $rho=$lu[0];
      $word_i=$lu[1];
      $word_j=$lu[2];
      $word_i=~s/\+/ /g;
      $word_j=~s/\+/ /g;
      if ($lfound{"$word_i $word_j"}==0) {
        $lfound{"$word_i $word_j"}++;
        $n1=$lu[3];
        $n2=$lu[4];
        $n12=$lu[5];
        $nw1=$lu[6];
        $nw2=$lu[7];
        $lclicks{$word_i}=$lu[8];
        $lclicks{$word_j}=$lu[9];
        $lrare{$word_i}=$n1;
        $lrare{$word_j}=$n2;
        $stri=$lcorrq{$word_i};
        $CTR=$lclicks{$word_j}/$n2;
        if ($correlFormula ne "") { $rho=&getRho; }
        if (($filter eq "n")||(($filter eq "y")&&($CTR>0.200))) {
          if ($stri eq "") { $stri="\~"; }
          $stri=$stri."$word_j\+$rho\~";
          $lcorrq{$word_i}=$stri;
        }
      }
    }
    close(IN);
  }
  $read{$filename}="yes";
}



$query=~s/\n//g;
@aux=split(' ',$query);
$nw=$#aux+1;
$nres=0;
@res=();
for ($k=0; $k<$nw; $k++) {
  $word_i=$aux[$k];
  $corr=$lcorrq{$word_i};
  @aux2=split(/\~/,$corr);
  $nq=$#aux2;
  for ($l=1; $l<=$nq; $l++) {
    $word_j=$aux2[$l];
    @aux3=split(/\+/,$aux2[$l]);
    $word_j=$aux3[0];
    $rho=1 * 1 * $aux3[1]; 
    if (($word_j =~ "$query")&&($boostFormula eq "1")) { $rho=$rho+1; }  ##--> rather, compute intersection($query,$word_j)
    $rho=substr($rho,0,5);
    $CTR=$lclicks{$word_j}/$lrare{$word_j};
    $CTR=substr($CTR,0,5);
    $res[$nres]="$rho : $word_i =$word_j= $lrare{$word_i}:$lrare{$word_j}:$CTR";
#    $res[$nres]="<tr><td>$rho</td><td>$word_i</td><td>$word_j</td><td>$lrare{$word_i}</td><td>$lrare{$word_j}</td></tr>";
    $nres++;      
  }
}
for ($k=1; $k<$nw; $k++) {
  $word_i=$aux[$k-1]." ".$aux[$k];
  $corr=$lcorrq{$word_i};
  @aux2=split(/\~/,$corr);
  $nq=$#aux2;
  for ($l=1; $l<=$nq; $l++) {
    $word_j=$aux2[$l];
    @aux3=split(/\+/,$aux2[$l]);
    $word_j=$aux3[0];
    $rho=1 * 1 * $aux3[1];
    if (($word_j =~ "$query")&&($boostFormula eq "1")) { $rho=$rho+2; }  ##--> rather, compute intersection($query,$word_j)
    $rho=substr($rho,0,5);
    $CTR=$lclicks{$word_j}/$lrare{$word_j};
    $CTR=substr($CTR,0,5);
    $res[$nres]="$rho : $word_i =$word_j= $lrare{$word_i}:$lrare{$word_j}:$CTR";
#    $res[$nres]="<tr><td>$rho</td><td>$word_i</td><td>$word_j</td><td>$lrare{$word_i}</td><td>$lrare{$word_j}</td></tr>";
    $nres++;
  }
}

if ($sort eq "a") {
  @ress = sort { $a <=> $b } @res;
} else {
  @ress = sort { $b <=> $a } @res;
}


%lword_j=();
$offset=0;
if ($nres-$ndisplay>0) { $offset=$nres-$ndisplay; }
if ($sort eq "a") {
  for ($k=$offset; $k<$nres; $k++) {
    @lu=split("=",$ress[$k]);
    $word_j=$lu[1];
    $lword_j{$word_j}++;
    if (($lword_j{$word_j}==1)&&($query ne $word_j)) { 
          @aux=split('=',$ress[$k]);
          if ($mode eq "silent") { $ress[$k]=$aux[1]; }
          $link=$word_j;
          $link=~s/ /\+/g;
          $url="/cgi-bin/kw8x3.pl?query=$link&ndisplay=$ndisplay&sort=$sort&mode=$mode&filter=$filter&boost=$boostFormula&correl=$correlFormual";
          $output=$output."<a href=\"$url\">$ress[$k]</a><br>"; 
    }  # to avoid showing up duplicates
  }
} else {
  for ($k=0; $k<$ndisplay; $k++) {
    @lu=split("=",$ress[$k]);
    $word_j=$lu[1];
    $lword_j{$word_j}++;
    if (($lword_j{$word_j}==1)&&($query ne $word_j)) { 
          @aux=split('=',$ress[$k]);
          if ($mode eq "silent") { $ress[$k]=$aux[1]; }
          $link=$word_j;
          $link=~s/ /\+/g;
          $url="/cgi-bin/kw8x3.pl?query=$link&ndisplay=$ndisplay&sort=$sort&mode=$mode&filter=$filter&boost=$boostFormula&correl=$correlFormual";
          $output=$output."<a href=\"$url\">$ress[$k]</a><br>"; 
    }  # to avoid showing up duplicates
  }
} 
 
if ($output eq "") { $output="<p>No results found."; } 
print "Content-type: text/html\n\n";
print<<"EOG";

<link rel=stylesheet href="http://www.datashaping.com/template2.css" type="text/css">
<link rel=stylesheet href="http://www.datashaping.com/template55.css?AFFID=1013" type="text/css">
<table width=100% valign=center align=center cellpadding=1 cellspacing=0 border=0 bgcolor=><tr>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript" SRC="http://www.datashaping.com/ds.js"></SCRIPT>
</tr>
</table>
<p>


<b>Query:</b> $query<p>
<b>Related Queries:</b>
<p>
<font face="courier">
<blockquote>
$output
</blockquote>
</font>

<a href="/kw8.html"><b>Try another query</b></a><p>


EOG


#------------------------------------------------------------------------
sub parse_form {
    if ($ENV{'REQUEST_METHOD'} eq 'GET') {
        # Split the name-value pairs
        @pairs = split(/&/, $ENV{'QUERY_STRING'});
    }
    elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
        # Get the input
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
 
        # Split the name-value pairs
        @pairs = split(/&/, $buffer);
    }
    else {
       # &error('request_method');
    }
    # For each name-value pair:                                              #
    foreach $pair (@pairs) {
        # Split the pair up into individual variables.                       #
        local($name, $value) = split(/=/, $pair);
 
        # Decode the form encoding on the name and value variables.          #
        $name =~ tr/+/ /;
        $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        $value =~ s/<!--(.|\n)*-->//g;
        if (defined($Config{$name})) {
            $Config{$name} = $value;
        }
        else {
            if ($Form{$name} && $value) {
                $Form{$name} = "$Form{$name}, $value";
            }
            elsif ($value) {
                push(@Field_Order,$name);
                $Form{$name} = $value;
            }
        }
    }
}