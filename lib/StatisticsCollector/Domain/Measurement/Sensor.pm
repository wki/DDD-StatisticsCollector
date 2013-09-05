package StatisticsCollector::Domain::Measurement::Sensor;
use Moose;
use aliased 'StatisticsCollector::Domain::Measurement::MeasureResultProvided';
use aliased 'StatisticsCollector::Domain::Measurement::SensorInfo';
use aliased 'StatisticsCollector::Domain::Common::Summary';
use aliased 'StatisticsCollector::Domain::Common::MeasurementResult';
use namespace::autoclean;

extends 'DDD::Aggregate';

=head1 NAME

StatisticsCollector::Domain::Measurement::Sensor - Aggregate root representing
a sensor

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 info

contains a SensorInfo value object with the latest measure result and possibly
an alarm

=cut

has info => (
    is => 'rw',
    isa => 'SensorInfo',
    required => 1,
);

=head2 hourly_results

=cut

has hourly_results => (
    # traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef[Summary]',
    default => sub { [] },
    # handles => {
    # },
);

=head2 daily_results

=cut

has daily_results => (
    # traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef[Summary]',
    default => sub { [] },
    # handles => {
    # },
);

=head1 METHODS

=cut

=head2 provide_result ( $result )

save the result provided by a sensor. $result may be either an integer value
or a MeasurementResult object.

=cut

sub provide_result {
    my ($self, $result) = @_;
    
    $self->info->result($result);
    $self->publish(MeasureResultProvided->new(result => $result));
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
