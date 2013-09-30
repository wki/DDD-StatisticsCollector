package MockSensorInfo;
use Moose;
extends 'DDD::Value';

has name => (is => 'ro', isa => 'Str');

1;
