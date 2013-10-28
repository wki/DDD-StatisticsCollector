package StatisticsCollector::Domain::Role::FileStorage;
use Moose::Role;
use MooseX::Types::Path::Class 'Dir';

=head1 NAME

StatisticsCollector::Domain::Role::FileStorage - base directory and methods
for file storage

=head1 SYNOPSIS

=head1 DESCRIPTION

All files for sensors are saved inside one directory. Every file name starts
with the sensor name, "/" replaced with a dot ".". So Sensor C<x/y/z>
is stored in files prefixed with F<x.y.z>. After that, an optional suffix
is appended and the file extension ".json" is added.

For customization, the C<file_suffix> can be set using a builder method.

Example file names are F<x.y.z.json> or with a suffix of "alarm"
F<x.y.z.alarm.json>.

=head1 ATTRIBUTES

=cut

=head2 dir

a directory where all sensor files are saved to. The path for a sensor file
will get obtained by its name. Summaries for a sensor named "a/b/c" will be
saved in a file named "a-b-c.summaries.json"

=cut

has dir => (
    traits   => [ 'DoNotSerialize' ],
    is       => 'ro',
    isa      => Dir,
    coerce   => 1,
    required => 1,
);

has file_suffix => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

=head1 METHODS

=cut

# convert sensor_id to file_name
sub _file_name {
    my ($self, $sensor_id) = @_;

    join '.',
        grep { $_ }
        split('/', $sensor_id), $self->file_suffix, 'json';
}

# convert sensor_id to a file object
sub _file {
    my ($self, $sensor_id) = @_;

    return $self->dir->file($self->_file_name($sensor_id));
}

# return all sensor_id names
sub _all_sensor_ids {
    my $self = shift;
    
    my @sensor_ids;
    
    my $suffix = $self->file_suffix // '';
    
    foreach my $file ($self->dir->children) {
        next if !-f $file;
        
        my @parts = split qr{[.]}xms, $file->basename;
        next if pop @parts ne 'json';
        next if ($parts[3] // '') ne $suffix;
        
        push @sensor_ids, join '/', @parts[0..2];
    }
    
    # warn 'All sensor ids: ' . join ', ', @sensor_ids;
    
    return @sensor_ids;
}

1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
