package StatisticsCollector::Domain::Alarm::Rule;
use Moose;
use List::MoreUtils 'all';
use aliased 'StatisticsCollector::Domain::Alarm::Condition';
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Alarm::Rule - a rule consisting of conditions to
check

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 conditions

=cut

has conditions => (
    traits   => ['Array'],
    is       => 'ro',
    isa      => 'ArrayRef',    # of Conditions
    required => 1,
    handles  => {
        all_conditions => 'elements',
    },
);

=head2 name

=cut

has name => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

=head2 sensor_mask

=cut

has sensor_mask => (
    is      => 'ro',
    isa     => 'Str',
    default => '*/*/*',
);

=head1 METHODS

=cut

=head2 is_satisfied ( $measurement )

returns true if the rule is satisfied for a measurement. This is done by
checking all conditions of the rule.

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;
    
    ### FIXME: what happens if we have no conditions? pass?
    
    return all { $_->is_satisfied($measurement) } $self->all_conditions;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
