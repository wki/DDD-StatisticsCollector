package MockSensorInfo;
use Moose;
extends 'DDD::Value';

has sensor => (is => 'ro', isa => 'Str');

1;
