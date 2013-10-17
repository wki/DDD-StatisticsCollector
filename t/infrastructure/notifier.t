use Test::Most;
use Test::MockDateTime;

use ok 'StatisticsCollector::Infrastructure::Notifier';

my $n = StatisticsCollector::Infrastructure::Notifier->new;

isa_ok $n, 'StatisticsCollector::Infrastructure::Notifier';

dies_ok { $n->notify }
    'notify() dies for abstract base class';

on '2013-01-02 03:04:05' => sub {
    is $n->notified_on,
        '2013-01-02 03:04:05',
        'current time';
};

done_testing;
