use FindBin;
use vars '$class';
use lib "$FindBin::Bin/../../lib";
use MockDomain;
use Test::Most;
use Test::MockDateTime;

use aliased 'StatisticsCollector::Domain::Common::SensorId';
use aliased 'StatisticsCollector::Domain::Common::AlarmInfo';
use aliased 'StatisticsCollector::Infrastructure::Notifier::Memory'
    => 'Notifier';

BEGIN { $class = 'StatisticsCollector::Domain::Notification::MessageComposer' }

use ok $class;

my $domain           = MockDomain->new;
my $notifier         = Notifier->new;
my $message_composer = $class->new(
    domain   => $domain,
    notifier => $notifier,
);

my $sensor_id = SensorId->new(
    name => 'a/bb/ccc',
);

my $alarm_info; # also needed for second test group

note 'alarm raised message';
on '2013-10-10 23:45:44' => sub {
    $alarm_info = AlarmInfo->new(
        message => 'Foo failed',
    );
    
    is_deeply $notifier->messages, [], 'no raise message yet';
    
    $message_composer->notify_alarm_raised_message($sensor_id, $alarm_info);
    
    is_deeply $notifier->messages,
        ["[2013-10-10 23:45:44] Problem: Sensor 'a/bb/ccc' raised alarm 'Foo failed'"],
        'raised-alarm notification';
    
    $notifier->clear;
};

note 'alarm cleared message';
on '2013-10-11 00:45:44' => sub {
    my $cleared_alarm_info = $alarm_info->clear;
    
    is_deeply $notifier->messages, [], 'no clear message yet';
    
    $message_composer->notify_alarm_cleared_message($sensor_id, $cleared_alarm_info);
    
    is_deeply $notifier->messages,
        ["[2013-10-11 00:45:44] Recovery: Sensor 'a/bb/ccc' cleared alarm 'Foo failed' raised on 2013-10-10 23:45:44"],
        'cleared-alarm notification';
};

done_testing;
