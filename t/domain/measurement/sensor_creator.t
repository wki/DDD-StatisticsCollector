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

my $d = MockDomain->new;
my $c = $class->new(
    domain => $d,
);

note 'failing creation';
{
    dies_ok { $c->new_sensor }
        'creating an unnamed sensor dies';
    
    dies_ok { $c->new_sensor('') }
        'creating a sensor with empty name dies';

    dies_ok { $c->new_sensor('abc') }
        'creating a illegal-named sensor dies';
}

note 'succeeding creation';
{
    my $s = $c->new_sensor('a/bb/ccc');
    
    isa_ok $s, 'StatisticsCollector::Domain::Measurement::Sensor';
}

done_testing;
