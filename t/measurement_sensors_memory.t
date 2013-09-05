use strict;
use warnings;
use Test::More;
use Test::Exception;

{
    package D;              # Mock domain
    use Moose;
    extends 'DDD::Base::Domain';
    
    package I;              # Mock SensorInfo
    use Moose;
    extends 'DDD::Value';
    has name => (is => 'ro', isa => 'Str');
    
    package S;              # Mock Sensor
    use Moose;
    extends 'DDD::Aggregate';
    has info => (is => 'rw', isa => 'I');
}

use ok 'StatisticsCollector::Domain::Measurement::Sensors::Memory';

my $d = D->new;
my $s = StatisticsCollector::Domain::Measurement::Sensors::Memory->new(domain => $d);

my $s_xyz = S->new(domain => $d, info => I->new(name => 'x/y/z'));
my $s_abc = S->new(domain => $d, info => I->new(name => 'a/b/c'));

note 'retrieve list';
{
    my @result = $s->sensor_info;
    is scalar @result, 0, 'no sensors read (list)';
    
    my $result = $s->sensor_info;
    is_deeply $result, [], 'no sensors read (scalar)';
    
    %StatisticsCollector::Domain::Measurement::Sensors::Memory::sensor_for = (
        'a/b/c' => $s_abc,
        'x/y/z' => $s_xyz,
    );

    @result = $s->sensor_info;
    is scalar @result, 2, '2 sensors read (list)';
    
    $result = $s->sensor_info;
    is_deeply scalar @$result, 2, '2 sensors read (scalar)';
}

note 'retrieve single';
{
    is $s->sensor_by_name('u/v/w'),
        undef,
        'unknown sensor yields undef';
    
    is $s->sensor_by_name('a/b/c'),
        $s_abc,
        'a/b/c retrieved';
}

note 'save';
{
    my $s_uvw = S->new(domain => $d, info => I->new(name => 'u/v/w'));
    
    $s->save($s_uvw);
    is $s->sensor_by_name('u/v/w'),
        $s_uvw,
        'u/v/w saved';
}

done_testing;
