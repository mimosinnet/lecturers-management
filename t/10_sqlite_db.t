use Modern::Perl;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Mojo::SQLite;

my $db = Mojo::SQLite->new('sqlite:db/master.db')->db;
my $results = $db->select('docents','inicials',{ docent => { -like => '%pujol%' } })->hash;

is($results->{'inicials'},'JP','I have been found in the database');

done_testing();
