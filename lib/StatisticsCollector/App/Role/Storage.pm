package StatisticsCollector::App::Role::Storage;
use Moose::Role;
use MooseX::Types::Path::Class 'Dir';

with 'MooseX::Getopt::Strict';

=head1 NAME

StatisticsCollector::App::Role::Storage - blabla

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=cut

=head2 storage_dir

the root directory for holding stored files

=cut

has storage_dir => (
    traits        => ['Getopt'],
    is            => 'ro',
    isa           => Dir,
    coerce        => 1,
    default       => 'root/storage',
    cmd_aliases   => 'd',
    documentation => 'directory for holding stored files (default: root/storage)',
);

1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
