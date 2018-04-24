use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::Modul;
use Data::Printer;

my $modul = GestioMaster::Obj::Modul->new( modul => 'M1' );

p($modul->total);

is($modul->coord,'JF', 'Joel coordina M1');
ok($modul->doc_nom =~ /Feliu/, 'JF es diu Feliu');
ok(scalar keys %{ $modul->docents } > 0, 'Hi ha docents en el mòdul');
ok($modul->sessio_modul_hores > 30, 'Hi ha mes de 30 hores cobertes');
ok($modul->total > 300, 'El modul té més de 300 hores totals');

done_testing();
