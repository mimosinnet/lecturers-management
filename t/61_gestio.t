use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('GestioMaster');
$t->get_ok('/ges/inici')->status_is(200);
for my $modul ( qw/ M1 M2a M2b M3a M3b M3d M3d M4 M5a M5b M5c M5d M6 / ) {
  $t->get_ok("/ges/modul/$modul")->status_is(200);
}
$t->get_ok('/ges/tfm')->status_is(200);

done_testing();
