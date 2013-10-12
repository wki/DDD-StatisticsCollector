use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Measurement::Sensor';
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Measurement::AllSensors::Memory' }

use ok $class;

my $domain = MockDomain->new;
my $all_sensors = $class->new(
    domain => $domain,
);

my $s_xyz = Sensor->new(
    id                 => 'x/y/z',
    latest_measurement => 42,
);
my $s_abc = Sensor->new(
    id                 => 'a/b/c',
    latest_measurement => 13,
);

note 'retrieve list';
{
    my @result = $all_sensors->filtered;
    is scalar @result, 0, 'no sensors read (list)';
    
    my $result = $all_sensors->filtered;
    is_deeply $result, [], 'no sensors read (scalar)';
    
    %StatisticsCollector::Domain::Measurement::AllSensors::Memory::sensor_for = (
        'a/b/c' => $s_abc,
        'x/y/z' => $s_xyz,
    );

    @result = $all_sensors->filtered;
    is scalar @result, 2, '2 sensors read (list)';
    
    $result = $all_sensors->filtered;
    is_deeply scalar @$result, 2, '2 sensors read (scalar)';
}

note 'retrieve single';
{
    is $all_sensors->by_name('u/v/w'),
        undef,
        'unknown sensor yields undef';
    
    is $all_sensors->by_name('a/b/c'),
        $s_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $s_uvw = Sensor->new(
        id                 => 'u/v/w',
        latest_measurement => -42,
    );
    
    $all_sensors->save($s_uvw);
    is $all_sensors->by_name('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
