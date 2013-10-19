package StatisticsCollector::App::ProvideMeasurement;
use Moose;
# use aliased 'StatisticsCollector::Infrastructure::Notifier::Memory'
#     => 'Notifier';
use namespace::autoclean;

with 'MooseX::Getopt::Strict',
     'StatisticsCollector::App::Role::Domain',
     'StatisticsCollector::App::Role::Storage',
     'StatisticsCollector::App::Role::Sensor';

=head1 NAME

StatisticsCollector::App::ProvideMeasurement - a commandline interface for
providing a measurement

=head1 SYNOPSIS

    provide_measurement.pl [options] --sensor rio/aussen/temperatur --result 42

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 result

=cut

has result => (
    traits        => ['Getopt'],
    is            => 'ro',
    isa           => 'Int',
    required      => 1,
    cmd_aliases   => 'r',
    documentation => 'measurement result provided (mandatory)',
);

=head1 METHODS

=cut

sub run {
    my $self = shift;

    $self->app->measurement
         ->provide_result($self->sensor_id, $self->result);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
