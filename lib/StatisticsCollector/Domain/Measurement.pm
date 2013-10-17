package StatisticsCollector::Domain::Measurement;
use DDD::Domain; # FIXME: SubDomain

repository all_sensors => (
    isa          => 'AllSensors::File',
    dependencies => {
        dir => dep('/storage_dir'),
    },
);

factory sensor_creator => (
    # isa => 'SensorCreator',
);

1;
