use strict;
use warnings;
use vars '$class';
use Path::Class;
use Test::More;
use Test::MockDateTime;

BEGIN { $class = 'StatisticsCollector::Infrastructure::Notifier::File' }

use ok $class;

my $dir  = Path::Class::tempdir(CLEANUP => 1);
my $file = $dir->file('notification.dat');

my $notifier = $class->new(
    file => $file,
);

ok !-f $file, 'message file initially empty';


on '2013-02-03 12:34:45' => sub {
    $notifier->notify('foo', 'blabla');
    
    is scalar $file->slurp,
        "[2013-02-03 12:34:45] foo: blabla\n",
        'one message notified';
};


on '2013-02-04 08:09:10' => sub {
    $notifier->notify('bar', 'blablubb');
    
    is scalar $file->slurp,
        "[2013-02-03 12:34:45] foo: blabla\n". 
            "[2013-02-04 08:09:10] bar: blablubb\n",
        'two messages notified';
};

done_testing;

