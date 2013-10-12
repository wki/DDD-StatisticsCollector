package Watcher;
use Moose;

# ABSTRACT: a simple event watcher capturing all events caught

has caught_events => (
    traits  => ['Array'],
    is      => 'rw',
    isa     => 'ArrayRef',
    default => sub { [] },
    handles => {
        all_caught_events => 'elements',
        catch_event       => 'push',
        clear             => 'clear',
    },
);

sub all_caught_event_classes {
    my $self = shift;

    return [
        map { my $class = ref $_; $class =~ s{\A .* ::}{}xms; $class }
        $self->all_caught_events
    ]
}

__PACKAGE__->meta->make_immutable;
1;
