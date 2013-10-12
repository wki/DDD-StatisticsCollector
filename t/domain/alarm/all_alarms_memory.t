use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Alarm::Alarm';
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllAlarms::Memory' }

use ok $class;

my $domain = MockDomain->new;
my $all_alarms = $class->new(
    domain => $domain,
);

my $a_xyz = Alarm->new(
    id          => 'x/y/z',
    sensor_name => 'x/y/z',
);

my $a_abc = Alarm->new(
    id          => 'a/b/c',
    sensor_name => 'a/b/c',
);

note 'retrieve';
{
    %StatisticsCollector::Domain::Alarm::AllAlarms::Memory::alarm_for = (
        'a/b/c' => $a_abc,
        'x/y/z' => $a_xyz,
    );

    is $all_alarms->for_sensor('u/v/w'),
        undef,
        'unknown sensor yields undef';

    is $all_alarms->for_sensor('a/b/c'),
        $a_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $a_uvw = Alarm->new(
        id          => 'u/v/w',
        sensor_name => 'u/v/w',
    );

    $all_alarms->save($a_uvw);
    is $all_alarms->for_sensor('u/v/w'),
        $a_uvw,
        'u/v/w saved';
}

done_testing;
