package StatisticsCollector::Domain::Alarm::Condition;
use Moose;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Alarm::Condition - condition base class

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 value

=cut

has value => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

=head2 name

=cut

has name => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

=head1 METHODS

=cut

=head2 is_satisfied ( $measurement )

check if a given condition is satisfied for a given measurement

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;
    
    die 'abstract class';
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
