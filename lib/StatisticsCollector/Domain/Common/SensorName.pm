package StatisticsCollector::Domain::Common::SensorName;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Common::SensorName - Sensor name value object

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

subtype 'SensorName',
    as 'Str',
    where { m{\A \w+ / \w+ / \w+ \z}xms },
    message { "This name ($_) does not match x/y/z" };

=head2 name

=cut

has name => (
    is       => 'ro',
    isa      => 'SensorName',
    required => 1,
);

=head1 METHODS

=cut

=head2 matches_mask

verifies if the sensor name matches a given mask like '*/*/temperature'

=cut

sub matches_mask {
    my ($self, $mask) = @_;
    
    return if !$mask;
    
    $mask =~ s{\*}{\\w+}xmsg;
    
    $self->name =~ m{\A $mask \z}xms;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
