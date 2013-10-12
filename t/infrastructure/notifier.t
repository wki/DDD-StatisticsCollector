use strict;
use warnings;
use vars '$class';
use Test::More;
use Test::Exception;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Infrastructure::Notifier' }

use ok $class;

my $notifier = $class->new;

isa_ok $notifier, $class;

dies_ok { $notifier->notify }
    'notify() dies for abstract base class';

on '2013-01-02 03:04:05' => sub {
    is $notifier->notified_on,
        '2013-01-02 03:04:05',
        'current time';
};

done_testing;
