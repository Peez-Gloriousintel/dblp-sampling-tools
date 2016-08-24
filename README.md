# dblp-sampling-tools
DBLP sampling tools are useful scripts written in Perl for extracting a sample set of dblp records from a dblp dataset in xml format. You can download a dblp dataset from http://dblp.uni-trier.de/xml.

## Usage
* gen.pl
 * This tool is used to extract a sample data set from dblp.xml.
 * Sampling value is relative to how many records will be scanned in order to take just 1 record to the output file.
 * Max records value is relative to how many records you expect to have in the output file.
 * You may need to adjust these values appropriately in order to make this tool work as you wanted.
 * By default, this tool prints out sampling records to stdout. You may need a manual redirection (>) if you want to write to a file.
```
$ perl gen.pl
Usage: gen.pl <filename> [sampling (default = 10)] [max records (default = 2000)]
```
* count.pl
 * This tool is used to summarise a total number of records in each type of publications.
 * It is very useful for checking if it can generate a proper set of dblp records as needed with a given sampling value.
```
$ perl count.pl
Usage: ./count.pl <filename>
```
* search.pl
 * This tool is used to search for the first record of a specified publication type.
```
$ perl search.pl
Usage: ./search.pl <keyword: (article|inproceedings|proceedings|book|incollection|phdthesis|mastersthesis|www)> <filename>
```

## Example
dblp.xml with 20,000 records (from over millions of records) is provided as an example input file. You can validate the correctness of output file with dblp.dtd by using a unix command line tool: xmllint.
```
$ perl gen.pl dblp.xml > sample.xml
$ xmllint --noout --dtdvalid dblp.dtd sample.xml
(new line) 
$ perl count.pl sample.xml
article: 263
mastersthesis: 1
incollection: 6
www: 3
book: 1
proceedings: 2
phdthesis: 5
inproceedings: 220
total: 501
$ perl search.pl inproceedings sample.xml
1288: <inproceedings mdate="2015-05-05" key="journals/procedia/AkarsuK11"><author>Emre Akarsu</author><author>Adem Karahoca</author>
$
```
