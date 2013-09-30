use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use MockSensorInfo;
use MockSensor;

use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Domain::Measurement::AllSensors::Memory';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors::Memory->new(domain => $d);

my $s_xyz = MockSensor->new(domain => $d, info => MockSensorInfo->new(name => 'x/y/z'));
my $s_abc = MockSensor->new(domain => $d, info => MockSensorInfo->new(name => 'a/b/c'));

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
    my $s_uvw = MockSensor->new(domain => $d, info => MockSensorInfo->new(name => 'u/v/w'));
    
    $s->save($s_uvw);
    is $s->by_name('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
