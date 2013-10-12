package StatisticsCollector::Domain::Alarm::AllRules::Fixed;
use Moose;
use Module::Load;
use aliased 'StatisticsCollector::Domain::Common::SensorId';
use aliased 'StatisticsCollector::Domain::Alarm::Rule';
use namespace::autoclean;

extends 'StatisticsCollector::Domain::Alarm::AllRules';

=head1 NAME

StatisticsCollector::Domain::Alarm::AllRules::Fixed - a repository knowing a
fixed set of rules

=head1 SYNOPSIS

=head1 DESCRIPTION

currently the storage is static for sake of simple implementation

=head1 ATTRIBUTES

=cut

has rules => (
    traits     => [ 'Array' ],
    is         => 'ro',
    isa        => 'ArrayRef',
    lazy_build => 1,
    handles    => {
        all_rules => 'elements',
        nr_rules  => 'count',
    },
);

sub _build_rules {
    my $self = shift;
    
    local $/ = undef;
    my @rule_data = eval <DATA>;
    
    # ensure we have all condition classes loaded
    # unfortulately unpack does not load.
    foreach my $rule_info (@rule_data) {
        load $_
            for map { $_->{__CLASS__} }
                @{$rule_info->{conditions}};
    }
    
    return [ map { Rule->unpack($_) } @rule_data ];
}

=head1 METHODS

=cut

=head2 for_sensor ( $name )

load the best rule matching a sensor mask

=cut

sub for_sensor {
    my ($self, $name) = @_;
    
    my $sensor_id = SensorId->new( name => $name );
    
    foreach my $rule ($self->all_rules) {
        return $rule if $sensor_id->matches_mask($rule->sensor_mask);
    }
    
    return; # or die?
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


############################################################
#                                                          #
#   below are our rules.                                   #
#   The rules are sorted in the order they are tested in   #
#                                                          #
############################################################

__DATA__
{
    __CLASS__   => 'StatisticsCollector::Domain::Alarm::Rule',
    name        => 'heating health',
    sensor_mask => '*/heizung/temperatur',
    conditions  => [
        {
            __CLASS__ => 'StatisticsCollector::Domain::Alarm::Condition::Age',
            name      => '1 hour age',
            value     => 60,
        },
        {
            __CLASS__ => 'StatisticsCollector::Domain::Alarm::Condition::Min',
            name      => 'above 10 degrees',
            value     => 10,
        },
    ]
},
{
    __CLASS__   => 'StatisticsCollector::Domain::Alarm::Rule',
    name        => 'temperature age',
    sensor_mask => '*/*/temperatur',
    conditions  => [
        {
            __CLASS__ => 'StatisticsCollector::Domain::Alarm::Condition::Age',
            name      => '1 hour age',
            value     => 60,
        },
    ]
},
{
    __CLASS__   => 'StatisticsCollector::Domain::Alarm::Rule',
    name        => 'null rule',
    sensor_mask => '*/*/*',
    conditions  => [ ]
},
