package StatisticsCollector::Domain;
use DDD::Domain;

subdomain measurement => (
    isa => 'StatisticsCollector::Domain::Measurement',
    dependencies => {
    },
);

1;
