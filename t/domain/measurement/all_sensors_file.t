use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use MockSensorInfo;
use MockSensor;

use Path::Class;
use Test::More;

my $dir = Path::Class::tempdir(CLEANUP => 1);

use ok 'StatisticsCollector::Domain::Measurement::AllSensors::File';

my $d = MockDomain->new;
my $s = StatisticsCollector::Domain::Measurement::AllSensors::File->new(
    domain => $d,
    dir    => $dir,
);

note 'internal methods';
{
    is $s->_file_name('a/b/c'), 'a.b.c.json', 'file_name';
    
    is $s->_file('a/b/c')->stringify,
        $dir->file('a.b.c.json')->stringify,
        'file';
}

note 'saving';
{
    my $s_xyz = MockSensor->new(domain => $d, info => MockSensorInfo->new(sensor => 'x/y/z'));
    
    ok !-f $dir->file('x.y.z.json'), 'x.y.z.json not present before save';
    $s->save($s_xyz);
    ok -f $dir->file('x.y.z.json'), 'x.y.z.json present after save';
    
    note scalar $dir->file('x.y.z.json')->slurp;
}

note 'loading';
{
    my $s_xyz = $s->by_name('x/y/z');
    
    is $s_xyz->info->sensor, 'x/y/z', 'sensor loaded';
}

done_testing;
