use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Printer;
use GestioMaster::Model::DB;
use Mojo::SQLite;

# say "-> Find me in the database";

my $database = GestioMaster::Model::DB->new( sqlite =>  Mojo::SQLite->new('sqlite:db/master.db')->db )->sqlite;
my $model = GestioMaster::Model::DB->new( sqlite =>  Mojo::SQLite->new('sqlite:db/master.db') );

# p($database);
# p($model);

# Check database
my $results = $database->select('docents','inicials',{ docent => { -like => '%pujol%' } })->hash;
is($results->{'inicials'},'JP','I have been found in the database');

# Check model
ok($model->doc_nom('JP') =~ /Pujol/, 'Troba el nom a partir de les inicials');
is($model->un_modul('M1')->{'coord'}	, 'JF', 'Sap que el coordinador del M1  és en Joel');
is($model->un_modul('M5d')->{'coord'}	, 'MM', 'Sap que el coordinador del M5d és la Perru');
ok($model->h_class('M1') > 10, 'Calcula les hores de classe assignades en el mòdul' );
is($model->h_class('M1'), 45, 'S\'han programat correctament les hores docents del M1');
# say $model->h_class('M5d');
# say $model->h_class('M6');
ok($model->h_class('M5d') > 10, 'Calcula hores M5d' );
ok($model->h_class('M6')  > 10, 'Calcula hores M6'  );

done_testing();
