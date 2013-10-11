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

    # scalar context: just answer a boolean value
    if ($rule->is_satisfied($measurement)) { ... }
    
    # list context: return (boolean, 'name of failing rule')
    my ($status, $failing_condition) = $rule->is_satisfied($measurement);
    if ($status) {
        # rule is satisfied
    } else {
        # rule is not satisfied
    }

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
        all_conditions    => 'elements',
        has_no_conditions => 'is_empty',
        has_conditions    => 'count',
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

In List context, returns a boolean C<is_satisfied> status and the name of
the rule that caused the false condition.

=cut

sub is_satisfied {
    my ($self, $measurement) = @_;
    
    my @result = (1, '');
    
    # return all { $_->is_satisfied($measurement) } $self->all_conditions;
    foreach my $condition ($self->all_conditions) {
        # warn "testing '${\$condition->name}'...";
        if (!$condition->is_satisfied($measurement)) {
            @result = (0, $condition->name);
            last;
        }
    }
    
    return wantarray ? @result : $result[0];
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
