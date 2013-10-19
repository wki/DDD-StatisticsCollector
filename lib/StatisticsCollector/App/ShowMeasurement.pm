package StatisticsCollector::App::ShowMeasurement;
use 5.010;
use Moose;
use Text::Table::Tiny;
use namespace::autoclean;

with 'MooseX::Getopt::Strict',
     'StatisticsCollector::App::Role::Domain',
     'StatisticsCollector::App::Role::Storage',
     'StatisticsCollector::App::Role::Sensor';

=head1 NAME

StatisticsCollector::App::ShowMeasurement - a commandline interface for
displaying various things for a sensor

=head1 SYNOPSIS

    show_measurement.pl [options] --sensor rio/aussen/temperatur

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

has with_hourly_summaries => (
    traits      => ['Getopt'],
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
    cmd_aliases => 'hours'
);

has with_daily_summaries => (
    traits      => ['Getopt'],
    is          => 'ro',
    isa         => 'Bool',
    default     => 0,
    cmd_aliases => 'days'
);

=head1 METHODS

=cut

sub run {
    my $self = shift;

    $self->show_latest_measurement;
    $self->show_summaries;
}

=head2 show_latest_measurement ( $sensor )

=cut

sub show_latest_measurement {
    my $self = shift;

    my $sensor = $self->app->measurement
         ->sensor_by_name($self->sensor_id);

    if (!$sensor) {
        say "No data available for sensor '${\$self->sensor_id}";
        return 1;
    }

    my @rows = (
        [ 'Sensor Name'           => $self->sensor_id ],
        [ 'Latest Measure Result' => $sensor->latest_measurement->result ],
        [ 'Latest Measure From'   => $sensor->latest_measurement->measured_on->strftime('%Y-%m-%d %H:%M') ],
    );

    say Text::Table::Tiny::table(
        rows => \@rows,
    );
    say '';
}

=head2 show_summaries


=cut

sub show_summaries {
    my $self = shift;

    return if !$self->with_hourly_summaries
           && !$self->with_daily_summaries;

    my $summaries = $self->app->measurement
        ->summaries_for_sensor($self->sensor_id);

    return if !$summaries;

    $self->show_x_summaries('Hourly', $summaries->hourly_summaries) if $self->with_hourly_summaries;
    $self->show_x_summaries('Daily', $summaries->daily_summaries)   if $self->with_daily_summaries;
}

=head2 show_x_summaries

=cut

sub show_x_summaries{
    my ($self, $title, $x_summaries) = @_;

    return if !scalar @$x_summaries;

    my @rows = (
        [$title, 'Min', 'Avg', 'Max'],

        map {
            [ $_->from->strftime('%Y-%m-%d %H:%M'), $_->min, $_->avg, $_->max ]
        } reverse @$x_summaries
    );

    say Text::Table::Tiny::table(
        header_row => 1,
        rows       => \@rows,
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
