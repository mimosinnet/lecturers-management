use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::TFM;
use GestioMaster::Obj::DB;
# use Data::Printer;

my $JP_tfm_id = GestioMaster::Obj::DB->new->model->tfm_docent('JP')->{'id'};


my $tfm = GestioMaster::Obj::TFM->new( id => $JP_tfm_id );

# p($tfm);

# for my $info ( qw/ id prac docent estud titol doc_nom / ) {	p($tfm->$info) }

is($tfm->docent,'JP',    'JP supervisa TFM');
ok(defined $tfm->M5d,    'M5d    definit');
ok(defined $tfm->M6,     'M6     definit');
ok(defined $tfm->docent, 'docent definit');
# ok($modul->doc_nom =~ /Feliu/, 'JF es diu Feliu');
# ok(scalar keys %{ $modul->docents } > 0, 'Hi ha docents en el mòdul');

done_testing();
