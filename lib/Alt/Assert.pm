package Alt::Assert;

use strict;
use warnings;

our $VERSION = '0.04';

sub assert {
    my $self  = shift;
    my $mod   = shift || caller();

    my ($orig, $phrase) = $mod =~ /^Alt::(\w+(?:::\w+)*)::(\w+)$/
        or die "Bad syntax in alternate module name '$mod', should be ".
            "Alt::<Original::Module>::<phrase>\n";
    my $origf = $orig;
    $origf =~ s!::!/!g; $origf .= ".pm";
    require $origf; # if user hasn't loaded the module, load it for them

    defined(&{"$orig\::ALT"})
        or die "$orig does not define ALT, might not be from the same ".
            "distribution as $mod\n";

    my $alt = $orig->ALT;
    $alt eq $phrase
        or die "$orig has ALT set to '$alt' instead of '$phrase', ".
            "might not be from the same distribution as $mod\n";
}

sub import {
    my $self   = shift;
    my $caller = caller();

    # export assert()
    {
        no strict;
        *{"$caller\::assert"} = \&assert;
    }
    $self->assert($caller);
}

1;
__END__

=encoding utf8

=head1 NAME

Alt::Assert - Assert alternate module implementation

=head1 SYNOPSIS

Assuming there is a CPAN module Foo::Bar and mst wants to write an ALTernate
called Alt::Foo::Bar::MSTROUT.

In mst's Foo::Bar, there is the following line:

    use constant ALT => 'MSTROUT';

In the alt module:

    package Alt::Foo::Bar::MSTROUT;
    use Alt::Assert; # imports assert()
    1;

Users use mst's Foo::Bar as normal, just like they would use the original
Foo::Bar:

    use Foo::Bar -various => [qw(weird import)], {API=>'things'};

or:

    require Foo::Bar;

If they want to assert they have the mst version, they can:

    use Foo::Bar -various => [qw(weird import)], {API=>'things'};
    use Alt::Foo::Bar::MSTROUT;

or:

    require Foo::Bar;
    require Alt::Foo::Bar::MSTROUT;
    Alt::Foo::Bar::MSTROUT->assert;

=head1 DESCRIPTION

Alt::Assert can be used to assert that the loaded module is the wanted alternate
implementation. Using the Synopsis' example, there can be different Foo::Bar
installed, either from the original distribution, or from one of the alternate
ones. Each alternate might be slightly incompatible with the original. The
existence of Alt::Foo::Bar::MSTROUT in the installation does not necessarily
ensure that the installed Foo::Bar is from the same alternate distribution,
since an installer can replace Foo::Bar from another distribution. That is why
one might need to do this assertion.

=head1 SEE ALSO

L<Alt>

=cut
