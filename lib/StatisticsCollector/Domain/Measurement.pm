package StatisticsCollector::Domain::Measurement;
use DDD::Domain;

repository all_sensors => (
    isa          => 'AllSensors::Memory',
    
    # dependencies => {
    #     # later for DBIC we will need:
    #     # schema => dep('/schema'),
    # },
);

1;
