package StatisticsCollector::Domain::Notification;
use DDD::Domain; # FIXME: SubDomain

service message_composer => (
    isa => 'MessageComposer',
    dependencies => {
        notifier => dep('/notifier'),
    },
);

1;
