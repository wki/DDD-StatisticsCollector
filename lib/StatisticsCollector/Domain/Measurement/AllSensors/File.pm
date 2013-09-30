package StatisticsCollector::Domain::Measurement::AllSensors::File;
use Moose;
use MooseX::Types::Path::Class 'Dir';
use aliased 'StatisticsCollector::Domain::Measurement::Sensor';
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Measurement::AllSensors';

=head1 NAME

StatisticsCollector::Domain::Measurement::AllSensors::File - file
implementation of a sensors repository

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 dir

a directory where all sensor files are saved to. The path for a sensor file
will get obtained by its name. A sensor named "a/b/c" will be saved in a file
named "a-b-c.json"

=cut

has dir => (
    is       => 'ro',
    isa      => Dir,
    coerce   => 1,
    required => 1,
);

=head1 METHODS

=cut

=head2 filtered ( $filter )

returns a list of L<SensorInfo> objects matched by a given filter.

=cut

sub filtered {
    my ($self, $filter) = @_;
    
    # TODO
    my @filtered;
    
    return wantarray ? @filtered : \@filtered;
}

=head2 by_name ( $sensor_name )

give back a senor uniquely identified by a given name. If no sensor can be
found with the requested name, C<undef> is returned

=cut

sub by_name {
    my ($self, $sensor_name) = @_;

    return Sensor->load($self->_file($sensor_name));
}

=head2 save ( $sensor )

writes a sensor to its storage

=cut

sub save {
    my ($self, $sensor) = @_;
    
    $self->store($self->_file($sensor->info->sensor));
}

# convert sensor_name to file_name
sub _file_name {
    my ($self, $sensor_name) = @_;
    
    $sensor_name =~ s{/}{.}xmsg;
    
    return "$sensor_name.json";
}

# concvert sensor_name to a file object
sub _file {
    my ($self, $sensor_name) = @_;
    
    return $self->dir->file($self->_file_name($sensor_name));
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
