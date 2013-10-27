package StatisticsCollector::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    ConfigLoader
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in statisticscollector_web.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'StatisticsCollector::Web',
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    
    'Model::Domain' => {
        domain_class => 'StatisticsCollector::Domain',
        storage_dir  => sub { StatisticsCollector::Web->path_to('root/storage') },
    },
);

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

StatisticsCollector::Web - Catalyst based application

=head1 SYNOPSIS

    script/statisticscollector_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<StatisticsCollector::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Wolfgang Kinkeldei

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
