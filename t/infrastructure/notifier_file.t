use strict;
use warnings;
use Test::More;
use Test::MockDateTime;

use ok 'StatisticsCollector::Infrastructure::Notifier::File';

my $dir  = Path::Class::tempdir(CLEANUP => 1);
my $file = $dir->file('notification.dat');

my $n = StatisticsCollector::Infrastructure::Notifier::File->new(
    file => $file,
);

ok !-f $file, 'message file initially empty';


on '2013-02-03 12:34:45' => sub {
    $n->notify('foo', 'blabla');
    
    is scalar $file->slurp,
        "[2013-02-03 12:34:45] foo: blabla\n",
        'one message notified';
};


on '2013-02-04 08:09:10' => sub {
    $n->notify('bar', 'blablubb');
    
    is scalar $file->slurp,
        "[2013-02-03 12:34:45] foo: blabla\n". 
            "[2013-02-04 08:09:10] bar: blablubb\n",
        'two messages notified';
};

done_testing;

