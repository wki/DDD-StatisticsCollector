use strict;
use warnings;
use Test::More;
use Test::Exception;

{
    package D;              # Mock Domain
    use Moose;
    
    extends 'DDD::Base::Domain';
}

use ok 'StatisticsCollector::Domain::Measurement::Sensor';

my $d = D->new;

# TODO: test more

done_testing;
