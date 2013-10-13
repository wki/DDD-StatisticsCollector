package StatisticsCollector::Domain;
use DDD::Domain;
use Path::Class;

=head1 NAME

StatisticsCollector::Domain - StatisticsCollector business domain

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 INFRASTRUCTURE

=cut

=head2 notifier

an instance of Infrastructure::Notifier responsible for sending out
notifications triggered by raised or cleared alarms

=cut

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

=head2 storage_dir

a directory acting as the root directory for file based storage

=cut

has storage_dir => (
    is  => 'ro',
    isa => 'Path::Class::Dir',
);

=head1 SUBDOMAINS

=cut

=head2 measurement

the core comain -- handles the raw measurement results provided by sensors

=cut

subdomain measurement => (
    isa => 'Measurement',
);

=head2 condense

handles condensing single measurement results into larger time intervals
like hourly or daily periods

=cut

subdomain condense => (
    isa => 'Condense',
);

=head2 alarm

cares about discovery and clearing of alarm situations

=cut

subdomain alarm => (
    isa => 'Alarm',
);

=head2 notification

notifies people when alarms are raised or cleared

=cut

subdomain notification => (
    isa => 'Notification',
);

=head2 application

the application currently modelled as a subdomain

### FIXME: create a keyword, usage like:

    application (
        isa => 'Application',
    );
    
    application;

=cut

subdomain application => (
    isa => 'Application',
);

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
