#!/usr/bin/perl -w

die "Usage: $0 <keyword: (article|inproceedings|proceedings|book|incollection|phdthesis|mastersthesis|www)> <filename>\n" if (@ARGV != 2 or $ARGV[0] !~ /^(article|inproceedings|proceedings|book|incollection|phdthesis|mastersthesis|www)$/);
$keyword = $ARGV[0];
open(FILE,"< $ARGV[1]");
$line_num = 0;
while ($line = <FILE>) {
	$line_num++;
	if ($line =~ /^<($keyword) [^>]*>/) {
		print $line_num. ": ".$line;
		last;
	}
}
close(FILE);
