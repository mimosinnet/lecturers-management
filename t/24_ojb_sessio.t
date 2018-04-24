use Modern::Perl;
use Test::More tests => 3;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::Sessio;
# use DateTime;
# se Data::Printer;

my $date = GestioMaster::Obj::Sessio->new( id => '168' );

# for my $info ( qw/ sessio date_num durada modul docent tema festa doc_nom sessio_dt sessio_date sessio_hora contingut_sessio year_month / ) {	p($date->$info) }

is($date->date_num,'1537200000','Dona el número de data');
is($date->durada,1,'Dona la durada');
is($date->docent,'JF','Dona el docent');


# p($modul->docents);

# is($modul->coord,'JF', 'Joel coordina M1');
# ok($modul->doc_nom =~ /Feliu/, 'JF es diu Feliu');
# ok(scalar keys %{ $modul->docents } > 0, 'Hi ha docents en el mòdul');

done_testing();
