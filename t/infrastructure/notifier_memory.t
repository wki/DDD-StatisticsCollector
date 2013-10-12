use strict;
use warnings;
use vars '$class';
use Test::More;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Infrastructure::Notifier::Memory' }

use ok $class;

my $notifier = $class->new;

is_deeply $notifier->messages, [], 'messages initially empty';


on '2013-02-03 12:34:45' => sub {
    $notifier->notify('foo', 'blabla');
    
    is_deeply $notifier->messages,
        [ '[2013-02-03 12:34:45] foo: blabla' ],
        'one message notified';
};


on '2013-02-04 08:09:10' => sub {
    $notifier->notify('bar', 'blablubb');
    
    is_deeply $notifier->messages,
        [
            '[2013-02-03 12:34:45] foo: blabla', 
            '[2013-02-04 08:09:10] bar: blablubb',
        ],
        'two messages notified';
};

done_testing;

