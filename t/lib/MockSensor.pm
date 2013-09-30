package MockSensor;
use Moose;
extends 'DDD::Aggregate';

has info => (is => 'rw', isa => 'MockSensorInfo');

1;
