package UsePerl::Controller::Main;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Util qw(dumper);

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub index ($self) {
	$self->render( title => 'Use.perl.org archive');
	}

# about
sub about ($self) {
	$self->render;
	}

# stories?page=\d+
sub stories ($self) {
	my $page = $self->page;

	$self->render;
	}

# authors?page=\d+
sub authors ($self) {
	my $page = $self->page;

	$self->render;
	}

# journals?page=\d+
sub journals ($self) {
	my $page = $self->page;

	$self->render;
	}

# article.pl?sid=\d+
sub story ($self) {
	my( $sid ) = $self->req->query_params->param( 'sid' );

	$self->render(
		sid => $sid,
		);
	}

# ~author_name
# ~author_name/
sub author ($self) {
	my( $author ) = $self->param( 'author' );

	my $details = $self->author_model->details( $author );

	say STDERR "$author => " . dumper( $details );
	return $self->render( status => 404 ) unless defined $details;

	$self->render(
		author => $details->{handle}
		);
	}

# ~author_name/journal/\d+
sub journal ($self) {
	my( $author ) = $self->param( 'author' );
	my( $sid )    = $self->param( 'journal' );

	$self->render(
		sid    => $sid,
		author => $author
		);
	}


sub page ($self) {
	$self->req->query_params->param( 'page' ) // 1;
	}

1;
