use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('GestioMaster');
$t->get_ok('/')->status_is(200);
$t->get_ok('/pub/inici')->status_is(200);
$t->get_ok('/pub/calendari')->status_is(200);
$t->get_ok('/pub/moduls')->status_is(200);
$t->get_ok('/pub/carrega_docent')->status_is(200);
$t->get_ok('/pub/centres')->status_is(200);
$t->get_ok('/pub/modul/M1')->status_is(200);
$t->get_ok('/pub/modul/M5d')->status_is(200);
$t->get_ok('/pub/modul/M6')->status_is(200);
$t->get_ok('/pub/tfm')->status_is(200);

done_testing();
