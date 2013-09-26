use strict;
use warnings;
use Test::More;
use Test::Exception;

use ok 'StatisticsCollector::Infrastructure::Notifier';

my $n = StatisticsCollector::Infrastructure::Notifier->new;

isa_ok $n, 'StatisticsCollector::Infrastructure::Notifier';

dies_ok { $n->notify }
    'notify() dies for abstract base class';

# check notified_on with mocked time


#  TODO: DateTime::Format::DateParse->parse_datetime( $date );
# on '2013-01-02 03:04:05' => sub {
#     is $n->notified_on,
#         '2013-01-02 03:04:05',
#         'current time';
# };

done_testing;
