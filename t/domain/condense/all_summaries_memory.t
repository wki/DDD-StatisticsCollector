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

my $domain = MockDomain->new;
my $all_summaries = $class->new(
    domain => $domain,
);

my $s_xyz = Summaries->new(
    id          => 'x/y/z',
    sensor_id => 'x/y/z',
);

my $s_abc = Summaries->new(
    id          => 'a/b/c',
    sensor_id => 'a/b/c',
);

note 'retrieve';
{
    %StatisticsCollector::Domain::Condense::AllSummaries::Memory::summaries_for = (
        'a/b/c' => $s_abc,
        'x/y/z' => $s_xyz,
    );

    is $all_summaries->for_sensor('u/v/w'),
        undef,
        'unknown sensor yields undef';

    is $all_summaries->for_sensor('a/b/c'),
        $s_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $s_uvw = Summaries->new(
        id          => 'u/v/w',
        sensor_id => 'u/v/w',
    );

    $all_summaries->save($s_uvw);
    is $all_summaries->for_sensor('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
