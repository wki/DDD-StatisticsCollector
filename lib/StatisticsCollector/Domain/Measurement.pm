package StatisticsCollector::Domain::Measurement;
use DDD::SubDomain;

aggregate 'sensor';

repository all_sensors => (
    isa          => 'AllSensors::File',
    dependencies => {
        dir => dep('/storage_dir'),
    },
);

factory 'sensor_creator';

1;
