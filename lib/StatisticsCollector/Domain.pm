package StatisticsCollector::Domain;
use DDD::Domain;

=head1 NAME

StatisticsCollector::Domain - StatisticsCollector business domain

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 INFRASTRUCTURE

=cut

=head2 EventPublisher / EventProcessor

=cut

has event_publisher => (
    is      => 'ro',
    isa     => 'DDD::EventPublisher',
    handles => [ qw(publish add_listener) ],
);

# Notifier
has notifier => (
    is         => 'ro',
    isa        => 'Object', # 'StatisticsCollector::Infrastruture::Notifier',
    lazy_build => 1,
);

# just a fallback. It is better to define a real notifier, however!
sub _build_notifier {
    require StatisticsCollector::Infrastructure::Notifier::Memory;
    
    StatisticsCollector::Infrastructure::Notifier::Memory->new
}

# Schema (in case of DBIx::Class)

# Filesystem/Root Directory (in case of File Storage)

=head1 SUBDOMAINS

=cut

=head2 measurement

the core comain -- handles the raw measurement results provided by sensors

=cut

subdomain measurement => (
    isa => 'StatisticsCollector::Domain::Measurement',
    dependencies => {
    },
);

=head2 condense

handles condensing single measurement results into larger time intervals
like hourly or daily periods

=cut

subdomain condense => (
    isa => 'StatisticsCollector::Domain::Condense',
    dependencies => {
    },
);

=head2 alarm

cares about discovery and clearing of alarm situations

=cut

subdomain alarm => (
    isa => 'StatisticsCollector::Domain::Alarm',
    dependencies => {
    },
);

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
