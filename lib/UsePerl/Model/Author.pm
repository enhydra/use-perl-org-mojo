package UsePerl::Model::Author;
use strict;
use warnings;

use feature qw(signatures);
no warnings qw(experimental::signatures);

my %authors = map { $_, { handle => $_ } } qw(brian_d_foy pudge);

sub new ( $class ) {
	bless {}, shift;
	}

sub exists ($self, $author) {
	return exists $authors{$author}
	}

sub details ($self, $author) {
	return unless $self->exists($author);

	return $authors{$author};
	}

1;
