#!/usr/bin/perl -w
# @author: pj4dev.mit@gmail.com
# @url: https://github.com/pj4dev/dblp-sampling-tools

die "Usage: $0 <filename>\n" if (@ARGV != 1);
open(FILE,"< $ARGV[0]");
%count = ();
$count{"article"} = 0;
$count{"inproceedings"} = 0;
$count{"proceedings"} = 0;
$count{"book"} = 0;
$count{"incollection"} = 0;
$count{"phdthesis"} = 0;
$count{"mastersthesis"} = 0;
$count{"www"} = 0;
$limit = 100;
$line_num = 0;
$break = 0;
while ($line = <FILE>) {
	if ($line =~ /^<([a-z]+) [^>]*>/) {
		$keyword = $1;
		$count{$keyword}++  if (exists $count{$keyword});
	}
	if ($break) {
		$line_num++;
		last if ($line_num >= $limit);
	}
}
close(FILE);
$total = 0;
foreach $keyword (keys %count) {
	print "$keyword: $count{$keyword}\n";
	$total += $count{$keyword};
}
print "total: $total\n"; 
