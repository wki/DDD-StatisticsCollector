use vars '$summary', '$result';
use DateTime;
use Test::Most;
use Test::MockDateTime;

BEGIN { 
    $result  = 'StatisticsCollector::Domain::Common::Measurement';
    $summary = 'StatisticsCollector::Domain::Common::Summary';
};

use ok $result;
use ok $summary;

# TODO: note 'failing construction';

note 'succeeding construction';
on '2012-12-10 21:13:45' => sub {
    my $r1 = $result->new(result => 10);
    my $r2 = $result->new(result => 20);
    
    my $s1 = $summary->from_measurement($r1);
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
    
    my $s2 = $s1->append_measurement($r2);
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
