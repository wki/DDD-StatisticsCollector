package StatisticsCollector::App::ProvideMeasurement;
use Moose;
use MooseX::Types::Path::Class 'Dir';
use StatisticsCollector::Domain;
use aliased 'StatisticsCollector::Infrastructure::Notifier::Memory' => 'Notifier';
use namespace::autoclean;

with 'MooseX::Getopt::Strict';

=head1 NAME

StatisticsCollector::App::ProvideMeasurement - a commandline interface for
providing a measurement

=head1 SYNOPSIS

    provide_measurement.pl [options] --sensor rio/aussen/temperatur --result 42

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 storage_dir

the root directory for holding stored files

=cut

has storage_dir => (
    traits        => ['Getopt'],
    is            => 'ro',
    isa           => Dir,
    coerce        => 1,
    required      => 1,
    cmd_aliases   => 'd',
    documentation => 'directory for holding stored files (mandatory)',
);

=head2 sensor

=cut

has sensor => (
    traits        => ['Getopt'],
    is            => 'ro',
    isa           => 'Str',
    required      => 1,
    cmd_aliases   => 's',
    documentation => 'name of the sensor to provide a measurement result for (mandatory)',
);

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

=head2 domain

=cut

has domain => (
    is         => 'ro',
    isa        => 'StatisticsCollector::Domain',
    lazy_build => 1,
    handles    => [
        'app',
    ]
);

sub _build_domain {
    my $self = shift;

    StatisticsCollector::Domain->instance(
        _debug      => 'subscribe process',
        storage_dir => $self->storage_dir,
    );
}

# TODO: application attribute

=head1 METHODS

=cut

sub run {
    my $self = shift;

    $self->app->measurement
         ->provide_result($self->sensor, $self->result);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
