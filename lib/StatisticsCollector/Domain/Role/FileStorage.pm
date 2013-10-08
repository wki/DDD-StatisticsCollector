package StatisticsCollector::Domain::Role::FileStorage;
use Moose::Role;
use MooseX::Types::Path::Class 'Dir';

=head1 NAME

StatisticsCollector::Domain::Role::FileStorage - base directory and methods
for file storage

=head1 SYNOPSIS

=head1 DESCRIPTION

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

# convert sensor_name to file_name
sub _file_name {
    my ($self, $sensor_name) = @_;
    
    $sensor_name =~ s{/}{.}xmsg;
    
    return sprintf '%s%s.json', $sensor_name, $self->file_suffix;
}

# convert sensor_name to a file object
sub _file {
    my ($self, $id) = @_;
    
    return $self->dir->file($self->_file_name($sensor_name));
}

1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
