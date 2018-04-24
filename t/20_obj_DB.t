use Modern::Perl;
use Test::More tests => 3;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Printer;
use GestioMaster::Obj::DB;

my $obj_db 	= GestioMaster::Obj::DB->new->sqlite;
my $model 	= GestioMaster::Obj::DB->new->model;

# p($obj_db);

# check database
my $results = $obj_db->db->select('docents','inicials',{ docent => { -like => '%pujol%' } })->hash;

is($results->{'inicials'},'JP','I have been found in the database');

# Check model
ok($model->doc_nom('JP') =~ /Pujol/, 'Troba el nom a partir de les inicials');
is($model->un_modul('M1')->{'coord'}, 'JF', 'Sap que el coordinador del M1 és en Joel');

done_testing();
