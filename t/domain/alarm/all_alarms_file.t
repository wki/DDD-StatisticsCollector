use strict;
use warnings;
use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use aliased 'StatisticsCollector::Domain::Alarm::Alarm';
use Path::Class;
use Test::More;

BEGIN { $class = 'StatisticsCollector::Domain::Alarm::AllAlarms::File' }

my $dir = Path::Class::tempdir(CLEANUP => 1);

use ok $class;

my $d = MockDomain->new;
my $a = $class->new(
    domain => $d,
    dir    => $dir,
);

my $a_xyz = Alarm->new(
    id          => 'x/y/z',
    sensor_name => 'x/y/z',
);

my $a_abc = Alarm->new(
    id          => 'a/b/c',
    sensor_name => 'a/b/c',
);

note 'internal methods';
{
    is $a->_file_name('a/b/c'), 'a.b.c.alarm.json', 'file_name';
    
    is $a->_file('a/b/c')->stringify,
        $dir->file('a.b.c.alarm.json')->stringify,
        'file';
}

note 'saving';
{
    ok !-f $dir->file('x.y.z.alarm.json'), 'x.y.z.alarm.json not present before save';
    $a->save($a_xyz);
    ok -f $dir->file('x.y.z.alarm.json'), 'x.y.z.alarm.json present after save';
    
    # note scalar $dir->file('x.y.z.json')->slurp;
}

note 'loading';
{
    my $a_xyz = $a->for_sensor('x/y/z');
    
    is $a_xyz->sensor_name->name, 'x/y/z', 'alarm loaded';
}

done_testing;
