use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Measurement::AllSensors' }
use ok $class;

my $domain = MockDomain->new;
my $all_sensors = $class->new(domain => $domain);

can_ok $all_sensors, qw(filtered by_name save);

dies_ok { $all_sensors->filtered } 'filtered dies';
dies_ok { $all_sensors->by_name } 'by_name dies';
dies_ok { $all_sensors->save } 'save dies';

done_testing;
