package Alt;

$VERSION = '0.03';

__END__

=encoding utf8

=head1 NAME

Alt - Alternate Module Implementations

=head1 SYNOPSIS

    cpanm Alt::IO::All::crackfueled

=head1 DESCRIPTION

C<Alt::> is the namespace for alternate implementations of CPAN modules.

The purpose of the L<Alt> module is to provide documentation explaining the
Alt concept, how it works, and guidelines for using it well.

=head1 THE PROBLEM

For a given piece of software, CPAN only allows for one implementation of a
given module/distribution name.

GitHub on the other hand, is not limited this way. Any author can make a fork,
since GitHub repos are namespaced by author id.

On CPAN, even the author(s) of the module in question is limited by this, as
they cannot release newer or older forks of their code, without introducing a
new name.

=head1 THE SOLUTION

A module C<Foo::Bar> is distributed on CPAN as C<Foo-Bar>. It may have
submodules like C<Foo::Bar::Baz>.

To make an alternate CPAN version, leave everything exactly the same, except
distribute the new version as C<Alt-Foo-Bar-AltIdentifier>.

When a user installs your module like so:

    cpanm Alt::Foo::Bar::better

they will get your version of the Foo::Bar framework (Foo::Bar,
Foo::Bar::Baz).

Obviously, this completely overlays the old Foo::Bar install, but that's the
whole idea. The user isn't surprised by this because they just asked for an
B<Alt>ernate implementation. If they don't like it, they can simply reinstall
the original Foo-Bar, or try some other alternate.

=head1 WHENCE ALT?

The Alt- concept was thought up by Ingy as he tried to figure out how to
revamp the somewhat popular IO::All and YAML.pm modules. Alternates can now be
released and alpha/beta tested, while the originals remain stable.

When Alt-IO-All-new is "community approved" it can replace IO-All. If
people want the old code, they can can install Alt-IO-All-old.

=head1 GUIDELINES

This idea is new, and the details should be sorted out through proper
discussions. Pull requests welcome.

Here are the basic guidelines for using the Alt namespace:

=over

=item Name Creation

Names for alternate modules should be minted like this:

    "Alt-$Original_Dist_Name-$phrase"

For instance, if MSTROUT wants to make an alternate IO-All distribution to
make it even more crack fueled, he might call it:

    Alt-IO-All-crackfueled

He might also just call it:

    Alt-IO-All-MSTROUT

By having 'Alt' at the start, it guarantees that it does not mess with future
IO::All development. The "phrase" at the end can be anything unique to CPAN,
but should describe the spirit of the alternate. If the alternate is meant to
be short-lived, it can just be the author's CPAN id.

=item Module for CPAN Indexing

You will need to provide a module like C<Alt::IO::All::MSTROUT> so that CPAN
will index something that can cause your distribution to get installed by
people:

    cpanm Alt::IO::All::MSTROUT

Since you are adding this module, you should add some doc to it explaining
your Alternate version's improvements.

=item Versioning

It's not yet clear what kinds of versioning issues will come into play.

=item Other Concerns

If you have em, I(ngy) would like to know them. Discuss on #toolchain on
irc.perl.org for now.

=back

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2012. Ingy döt Net.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
