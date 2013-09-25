package StatisticsCollector::Domain;
use DDD::Domain;

# EventPublisher / EventProcessor

# Notifier

# Schema (in case of DBIx::Class)

# Filesystem/Root Directory (in case of File Storage)

subdomain measurement => (
    isa => 'StatisticsCollector::Domain::Measurement',
    dependencies => {
    },
);

subdomain condense => (
    isa => 'StatisticsCollector::Domain::Condense',
    dependencies => {
    },
);

subdomain alarm => (
    isa => 'StatisticsCollector::Domain::Alarm',
    dependencies => {
    },
);

1;
