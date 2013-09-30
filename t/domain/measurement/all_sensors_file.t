use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;

use Path::Class;
use Test::More;

my $dir = Path::Class::tempdir(CLEANUP => 1);

use ok 'StatisticsCollector::Domain::Measurement::AllSensors::File';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors::File->new(
    domain => $d,
    dir    => $dir,
);

note 'internal methods';
{
    is $s->_file_name('a/b/c'), 'a.b.c.json', 'file_name';
    
    is $s->_file('a/b/c')->stringify,
        $dir->file('a.b.c.json')->stringify,
        'file';
}

done_testing;