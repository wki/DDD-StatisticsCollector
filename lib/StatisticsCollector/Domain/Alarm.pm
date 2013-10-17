package StatisticsCollector::Domain::Alarm;
use DDD::SubDomain;

aggregate 'alarm';

repository all_rules => (
    isa => 'AllRules::Fixed',
);

repository all_alarms => (
    isa => 'AllAlarms::File',
    dependencies => {
        dir => dep('/storage_dir'),
    },
);

factory 'alarm_creator';

service alarm_check => (
    dependencies => {
        all_rules     => dep('all_rules'),
        all_alarms    => dep('all_alarms'),
        alarm_creator => dep('alarm_creator'),
    },
);

1;
