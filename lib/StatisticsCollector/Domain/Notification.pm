package StatisticsCollector::Domain::Notification;
use DDD::SubDomain;

service message_composer => (
    dependencies => {
        notifier => dep('/notifier'),
    },
);

1;
