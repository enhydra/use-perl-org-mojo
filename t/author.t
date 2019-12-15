use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('UsePerl');

subtest index => sub {
	$t
		->get_ok('/')
		->status_is(200)
	};

my @users = qw( brian_d_foy pudge );

foreach my $user ( @users ) {
	subtest $user => sub {
		$t
			->get_ok("/~$user")
			->status_is(200)
			->content_like( qr/$user/i );

		$t
			->get_ok("/~$user/")
			->status_is(200)
			->content_like( qr/$user/i );
		};
	}

subtest bad_users => sub {
	$t
		->get_ok('/~not_there')
		->status_is(404)
		;
	$t
		->get_ok('/~not_there/')
		->status_is(404)
		;
	};

done_testing();
