package StatisticsCollector::Domain::Alarm::AlarmRaised;
use Moose;
use DateTime;
use aliased 'StatisticsCollector::Domain::Common::SensorName';
use aliased 'StatisticsCollector::Domain::Common::AlarmInfo';
use namespace::autoclean;

extends 'DDD::Event';

has raised_on => (
    is      => 'ro',
    isa     => 'DateTime',
    default => sub { $_[0]->_now },
);

has sensor_name => (
    is       => 'ro',
    isa      => 'SensorName', # the Moose Types
    coerce   => 1,
    required => 1,
);

has alarm_info => (
    is       => 'ro',
    isa      => 'AlarmInfo', # the Moose Type
    coerce   => 1,
    required => 1,
);

__PACKAGE__->meta->make_immutable;
1;
