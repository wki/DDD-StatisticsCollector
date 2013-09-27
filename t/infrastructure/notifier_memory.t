use strict;
use warnings;
use Test::More;
use Test::MockDateTime;

use ok 'StatisticsCollector::Infrastructure::Notifier::Memory';

my $n = StatisticsCollector::Infrastructure::Notifier::Memory->new;

is_deeply $n->messages, [], 'messages initially empty';


on '2013-02-03 12:34:45' => sub {
    $n->notify('foo', 'blabla');
    
    is_deeply $n->messages,
        [ '[2013-02-03 12:34:45] foo: blabla' ],
        'one message notified';
};


on '2013-02-04 08:09:10' => sub {
    $n->notify('bar', 'blablubb');
    
    is_deeply $n->messages,
        [
            '[2013-02-03 12:34:45] foo: blabla', 
            '[2013-02-04 08:09:10] bar: blablubb',
        ],
        'two messages notified';
};

done_testing;

