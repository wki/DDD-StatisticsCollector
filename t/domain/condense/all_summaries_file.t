use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Condense::Summaries';
use Path::Class;
use Test::More;

BEGIN { $class = 'StatisticsCollector::Domain::Condense::AllSummaries::File' }

my $dir = Path::Class::tempdir(CLEANUP => 1);

use ok $class;

my $d = MockDomain->new;
my $s = $class->new(
    domain => $d,
    dir    => $dir,
);

my $s_xyz = Summaries->new(
    id          => 'x/y/z',
    sensor_name => 'x/y/z',
);

note 'internal methods';
{
    is $s->_file_name('a/b/c'), 'a.b.c.summaries.json', 'file_name';
    
    is $s->_file('a/b/c')->stringify,
        $dir->file('a.b.c.summaries.json')->stringify,
        'file';
}

note 'saving';
{
    ok !-f $dir->file('x.y.z.summareis.json'), 'x.y.z.summaries.json not present before save';
    $s->save($s_xyz);
    ok -f $dir->file('x.y.z.summaries.json'), 'x.y.z.summaries.json present after save';
    
    # note scalar $dir->file('x.y.z.json')->slurp;
}

note 'loading';
{
    my $s_xyz = $s->for_sensor('x/y/z');
    
    is $s_xyz->sensor_name->name, 'x/y/z', 'summaries loaded';
}

done_testing;
