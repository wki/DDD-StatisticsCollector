use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Measurement::Sensor';

use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Measurement::AllSensors::Memory';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors::Memory->new(
    domain => $d,
);

my $s_xyz = Sensor->new(
    sensor_name        => 'x/y/z',
    latest_measurement => 42,
);
my $s_abc = Sensor->new(
    sensor_name        => 'a/b/c',
    latest_measurement => 13,
);

note 'retrieve list';
{
    my @result = $s->filtered;
    is scalar @result, 0, 'no sensors read (list)';
    
    my $result = $s->filtered;
    is_deeply $result, [], 'no sensors read (scalar)';
    
    %StatisticsCollector::Domain::Measurement::AllSensors::Memory::sensor_for = (
        'a/b/c' => $s_abc,
        'x/y/z' => $s_xyz,
    );

    @result = $s->filtered;
    is scalar @result, 2, '2 sensors read (list)';
    
    $result = $s->filtered;
    is_deeply scalar @$result, 2, '2 sensors read (scalar)';
}

note 'retrieve single';
{
    is $s->by_name('u/v/w'),
        undef,
        'unknown sensor yields undef';
    
    is $s->by_name('a/b/c'),
        $s_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $s_uvw = Sensor->new(
        sensor_name        => 'u/v/w',
        latest_measurement => -42,
    );
    
    $s->save($s_uvw);
    is $s->by_name('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
