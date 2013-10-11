package StatisticsCollector::Domain::Condense::CondenseMeasures;
use DDD::Service;
use aliased 'StatisticsCollector::Domain::Condense::AllSummaries';
use aliased 'StatisticsCollector::Domain::Condense::SummariesCreator';

=head1 NAME

StatisticsCollector::Domain::Condense::CondenseMeasures - condense measures
service

=head1 SYNOPSIS

=head1 DESCRIPTION

TODO: write something

=head1 ATTRIBUTES

=cut

=head2 all_summaries

the summaries repository

=cut

has all_summaries => (
    is       => 'ro',
    isa      => AllSummaries,
    required => 1,
);

=head2 summaries_creator

the summaries factory

=cut

has summaries_creator => (
    is         => 'ro',
    isa        => SummariesCreator,
    lazy_build => 1,
);

sub _build_summaries_creator {
    my $self = shift;
    
    SummariesCreator->new(
        domain => $self->domain,
    );
}

=head1 EVENTS

=cut

=head2 MeasurementProvided

the condense service listens to MeasurementProvided and inserts the latest
measurement reported by this event into the summaries for this sensor.

=cut

on MeasurementProvided => sub {
    my ($self, $event) = @_;

    $self->add_measurement(
        $event->sensor_name->name,
        $event->measurement
    );
};

=head1 METHODS

=cut

=head2 add_measurement ( $sensor_name, $measurement )

add a given measurement to a sensor

=cut

sub add_measurement {
    my ($self, $sensor_name, $measurement) = @_;

    my $summaries = $self->all_summaries->for_sensor($sensor_name)
        // $self->summaries_creator->new_summaries($sensor_name);

    $summaries->add_measurement($measurement);

    $self->all_summaries->save($summaries);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
