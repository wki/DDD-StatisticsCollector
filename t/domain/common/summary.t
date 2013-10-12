use strict;
use warnings;
use vars '$class';
use DateTime;
use Test::More;
use Test::Exception;
use Test::MockDateTime;
use aliased 'StatisticsCollector::Domain::Common::Measurement';

BEGIN { $class = 'StatisticsCollector::Domain::Common::Summary' }

use ok $class;

# TODO: note 'failing construction';

note 'succeeding construction';
on '2012-12-10 21:13:45' => sub {
    my $measurement1 = Measurement->new(result => 10);
    my $measurement2 = Measurement->new(result => 20);
    
    my $s1 = $class->from_measurement($measurement1);
    is $s1->from->hms,
        '21:00:00',
        's1: from time is truncated';
    is $s1->to->hms,
        '22:00:00',
        's1: to time is one hour ahead';
    
    is $s1->min, 10, 'min is 10';
    is $s1->max, 10, 'max is 10';
    is $s1->sum, 10, 'sum is 10';
    is $s1->nr_values, 1, 'nr_values is 1';
    
    my $s2 = $s1->append_measurement($measurement2);
    isnt $s1, $s2, 'new value object created';
    
    is $s2->from->hms,
        '21:00:00',
        's2: from time is truncated';
    is $s2->to->hms,
        '22:00:00',
        's2: to time is one hour ahead';
    
    is $s2->min, 10, 'min is 10';
    is $s2->max, 20, 'max is 20';
    is $s2->sum, 30, 'sum is 30';
    is $s2->nr_values, 2, 'nr_values is 2';
};

done_testing;
