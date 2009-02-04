use strict;
use warnings;
use Test::More tests => 6;
use Env::Sanctify;

$ENV{SANCTIFY_REGEX_TEST} = 'Sanctify this';
$ENV{SANCTIFY_RESTORE_TEST} = 'moocow';
delete $ENV{SANCTIFY_NO_VAR};

my $sanctify = Env::Sanctify->sanctify( 
		sanctify => [ 'REGEX\_TEST' ], 
		env => { SANCTIFY_RESTORE_TEST => 'pigdog',
			 SANCTIFY_NO_VAR => 'nothing to see',
	        },
);

is( $ENV{SANCTIFY_NO_VAR}, 'nothing to see', 'Nothing to see' );
is( $ENV{SANCTIFY_RESTORE_TEST}, 'pigdog', 'Sanctified to pigdog' );
ok( !$ENV{SANCTIFY_REGEX_TEST}, 'Okay, no SANCTIFY_REGEX_TEST' );

$sanctify->restore();

is( $ENV{SANCTIFY_RESTORE_TEST}, 'moocow', 'It is a cow again' );
is( $ENV{SANCTIFY_REGEX_TEST}, 'Sanctify this', 'Yes sanctification worked' );
ok( !$ENV{SANCTIFY_NO_VAR}, 'Nothing to see there' );
