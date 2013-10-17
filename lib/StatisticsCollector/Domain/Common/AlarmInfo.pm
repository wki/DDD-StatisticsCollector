package StatisticsCollector::Domain::Common::AlarmInfo;
use Moose;
use Moose::Util::TypeConstraints;
use DateTime;
use namespace::autoclean;

extends 'DDD::Value';

=head1 NAME

StatisticsCollector::Domain::Common::AlarmInfo - contains information
about a possible alarm

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TYPES

=cut

=head2 Measurement

=cut

class_type 'AlarmInfo',
    { class => __PACKAGE__ };

coerce 'AlarmInfo',
    from 'Str',
    via { __PACKAGE__->new( message => $_ ) };

=head1 ATTRIBUTES

=cut

=head2 raised_on

=cut

has raised_on => (
    is      => 'ro',
    isa     => 'DateTime',
    default => sub { $_[0]->_now },
);

=head2 cleared_on

=cut

has cleared_on => (
    is        => 'ro',
    isa       => 'DateTime',
    predicate => 'is_cleared',
);

=head2 message

=cut

has message => (
    is        => 'ro',
    isa       => 'Str',
    required  => 0,
    predicate => 'has_alarm',
);

=head1 METHODS

=cut

=head2 clear

factory method: returns a new AlarmInfo object being cleared

=cut

sub clear {
    my $self = shift;
    
    return __PACKAGE__->new(
        raised_on  => $self->raised_on,
        cleared_on => $self->_now,
        message    => $self->message,
    );
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHOR

Wolfgang Kinkeldei, E<lt>wolfgang@kinkeldei.deE<gt>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
