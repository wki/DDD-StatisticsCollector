use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Measurement::SensorCreator' }

use ok $class;

my $domain = MockDomain->new;
my $sensor_creator = $class->new(
    domain => $domain,
);

note 'failing creation';
{
    dies_ok { $sensor_creator->new_sensor }
        'creating an unnamed sensor dies';
    
    dies_ok { $sensor_creator->new_sensor('') }
        'creating a sensor with empty name dies';

    dies_ok { $sensor_creator->new_sensor('abc') }
        'creating a illegal-named sensor dies';
}

note 'succeeding creation';
{
    my $sensor = $sensor_creator->new_sensor('a/bb/ccc');
    
    isa_ok $sensor, 'StatisticsCollector::Domain::Measurement::Sensor';
}

done_testing;
