use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::More;
use Test::Exception;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllAlarms' }

use ok $class;

my $domain = MockDomain->new;
my $all_alarms = $class->new(domain => $domain);

can_ok $all_alarms, qw(for_sensor save);

dies_ok { $all_alarms->for_sensor } 'for_sensor dies';
dies_ok { $all_alarms->save } 'save dies';

done_testing;
