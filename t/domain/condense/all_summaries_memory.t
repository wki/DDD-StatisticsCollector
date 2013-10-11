use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Condense::Summaries';
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Condense::AllSummaries::Memory' }

use ok $class;

my $d = MockDomain->new;
my $s = $class->new(
    domain => $d,
);

my $s_xyz = Summaries->new(
    id          => 'x/y/z',
    sensor_name => 'x/y/z',
);

my $s_abc = Summaries->new(
    id          => 'a/b/c',
    sensor_name => 'a/b/c',
);

note 'retrieve';
{
    %StatisticsCollector::Domain::Condense::AllSummaries::Memory::summaries_for = (
        'a/b/c' => $s_abc,
        'x/y/z' => $s_xyz,
    );

    is $s->for_sensor('u/v/w'),
        undef,
        'unknown sensor yields undef';

    is $s->for_sensor('a/b/c'),
        $s_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $s_uvw = Summaries->new(
        id          => 'u/v/w',
        sensor_name => 'u/v/w',
    );

    $s->save($s_uvw);
    is $s->for_sensor('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
