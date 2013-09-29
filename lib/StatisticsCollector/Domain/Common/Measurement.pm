package StatisticsCollector::Domain::Common::Measurement;
use Moose;
use Moose::Util::TypeConstraints;
use DateTime;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Common::Measurement - a measured value

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TYPES

=cut

=head2 Measurement

=cut

class_type 'Measurement',
    { class => __PACKAGE__ };

coerce 'Measurement',
    from 'Int',
    via { __PACKAGE__->new( result => $_ ) };

=head1 ATTRIBUTES

=cut

has measured_on => (
    is       => 'ro',
    isa      => 'DateTime',
    default  => sub { DateTime->now( time_zone => 'local' ) },
);

has result => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

=head1 METHODS

=cut

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
