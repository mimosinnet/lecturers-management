use Mojo::Base -strict;

use Test::More tests => 3;
use Test::Mojo;

my $t = Test::Mojo->new('GestioMaster');
$t->get_ok('/pub/centres')->status_is(200)->content_like(qr/Pujol/i);

done_testing();
