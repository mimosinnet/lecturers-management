use Mojo::Base -strict;
use Test::More tests => 16;
use Test::Mojo;

my $t = Test::Mojo->new('GestioMaster');
$t->get_ok('/admin/inici')->status_is(200);
$t->get_ok('/admin/moduls')->status_is(200);
$t->get_ok('/admin/calendari')->status_is(200);
$t->get_ok('/admin/centres')->status_is(200);
$t->get_ok('/admin/modul/M1')->status_is(200);
$t->get_ok('/admin/modul/M5d')->status_is(200);
$t->get_ok('/admin/modul/M6')->status_is(200);
$t->get_ok('/admin/tfm')->status_is(200);

done_testing();
