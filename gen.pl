#!/usr/bin/perl -w

die "Usage: $0 <filename> [sampling (default = 10)] [max records (default = 2000)]\n" if (@ARGV < 1);
# adjust values below ...
$FILENAME = $ARGV[0];
$MAX_SIZE = $ARGV[2] || 2000;
$SAMPLING = $ARGV[1] || 10;
$MAX_WWW = $MAX_SIZE/200;
$MAX_MASTER = $MAX_SIZE/1000;
$MAX_PHD = $MAX_SIZE/100;

# first scan for common publications
open(FILE,"< $FILENAME");
$iter = 0;
$count_item = 0;
$common_size = $MAX_SIZE - $MAX_WWW - $MAX_MASTER - $MAX_PHD;
while ($line = <FILE>) {
	chomp $line;
	if ($line =~ /^<(article|inproceedings|proceedings|book|incollection) [^>].*>/) {
		if ($iter == $count_item*$SAMPLING or $line =~ /^<mastersthesis .*>/) {
			print $line;
			while ($line = <FILE>) {
				print $line;
				last if ($line =~ /^<\/[a-z]+>$/);
			}
			$count_item++;
		}
		$iter++;
	}
	print $line."\n" if ($line =~ /^<\?xml/);
	print $line."\n" if ($line =~ /^<!DOC/);
	print $line."\n" if ($line =~ /^<dblp/);
	last if ($count_item >= $common_size);
}
close(FILE);

# second scan for www, master, and phd thesis
open(FILE, "< $FILENAME");
$count_www = 0;
$count_master = 0;
$count_phd = 0;
while ($line = <FILE>) {
	chomp $line;
	if ($line =~ /^<www [^>].*>/ and $count_www < $MAX_WWW) {
		print $line;
		while ($line = <FILE>) {
			print $line;
			last if ($line =~ /^<\/www>$/);	
		}
		$count_www++;	
	}
	elsif ($line =~ /^<mastersthesis [^>].*>/ and $count_master < $MAX_MASTER) {
		print $line;
		while ($line = <FILE>) {
			print $line;
			last if ($line =~ /^<\/mastersthesis>$/);	
		}
		$count_master++;	
	}
	elsif ($line =~ /^<phdthesis [^>].*>/ and $count_phd < $MAX_PHD) {
		print $line;
		while ($line = <FILE>) {
			print $line;
			last if ($line =~ /^<\/phdthesis>$/);	
		}
		$count_phd++;	
	}
	last if ($count_www >= $MAX_WWW and $count_master >= $MAX_MASTER and $count_phd >= $MAX_PHD);
}
print "</dblp>\n";
close(FILE);

