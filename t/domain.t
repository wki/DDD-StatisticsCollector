use strict;
use warnings;
use Test::More;

use ok 'StatisticsCollector::Domain';

my $domain = StatisticsCollector::Domain->new;

is $domain->domain,
    $domain, 
    'domain reflects itself';

# infrastructure
isa_ok $domain->event_publisher,
    'DDD::EventPublisher';
can_ok $domain, qw(publish add_listener);

isa_ok $domain->notifier,
    'StatisticsCollector::Infrastructure::Notifier';
can_ok $domain->notifier, qw(notify);

# subdomains
isa_ok $domain->measurement,
    'StatisticsCollector::Domain::Measurement';

done_testing;
