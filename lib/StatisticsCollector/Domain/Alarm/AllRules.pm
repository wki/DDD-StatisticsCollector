package StatisticsCollector::Domain::Alarm::AllRules;
use Moose;
use aliased 'StatisticsCollector::Domain::Alarm::Rule';
use namespace::autoclean;

extends 'DDD::Repository';

=head1 NAME

StatisticsCollector::Domain::Alarm::AllRules - a repository allowing to load
rules

=head1 SYNOPSIS

=head1 DESCRIPTION

currently the storage is static for sake of simple implementation

### TODO: maybe have a special NULL rule without condition.

=head1 ATTRIBUTES

=cut

has rules => (
    traits     => [ 'Array' ],
    is         => 'ro',
    isa        => 'ArrayRef',
    lazy_build => 1,
    handles    => {
        all_rules => 'elements',
    },
);

sub _build_rules {
    my $self = shift;
    
    local $/ = undef;
    my @rules = eval <DATA>;
    
    return \@rules;
}

=head1 METHODS

=cut

=head2 for_sensor ( $sensor_name )

load the best rule matching a sensor mask

=cut

sub for_sensor {
    my ($self, $sensor_name) = @_;
    
    # loop thru all_rules, filter out matching ones
    # sort by specificity, take best
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# have some rules here:
__DATA__
{
    __CLASS__   => 'StatisticsCollector::Domain::Alarm::Rule',
    name        => '',
    sensor_mask => '',
    conditions  => [
        {
            __CLASS__ => 'StatisticsCollector::Domain::Alarm::Condition::Age',
            name      => '1 hour age',
            value     => 60,
        },
    ]
},
