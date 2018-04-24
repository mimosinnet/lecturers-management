use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::DB;
use Data::Printer;

my $model = GestioMaster::Obj::DB->new->model;

my $n_estud_abans = $model->un_modul( 'M1' )->{'n_estud'};
my $coord_abans   = $model->un_modul( 'M1' )->{'coord'};

ok($n_estud_abans > 20, "Tenim $n_estud_abans estudiants en el M1");
is($coord_abans, 'JF',  'Joen Feliu és el coordinador del M1');

$model->modul_estud_update( 'M1',   5 );
$model->modul_coord_update( 'M1', 'JP');
is($model->un_modul( 'M1' )->{'n_estud'}, 5,  'Hem canviat el número d\'estudiants a 5');
is($model->un_modul( 'M1' )->{'coord'}, 'JP', 'Hem canviat el coordinador a JP');

$model->modul_estud_update( 'M1', $n_estud_abans );
$model->modul_coord_update( 'M1', $coord_abans );
is($model->un_modul( 'M1' )->{'n_estud'},$n_estud_abans,"Hem tornat a posar el valor $n_estud_abans al nombre d\'estudiants");
is($model->un_modul( 'M1' )->{'coord'}  ,$coord_abans  ,"Hem tornat a posar el valor $coord_abans al coordinador de mòdul");

# p($model->model);
# p($database);
# Check database
# my $results = $database->select('docents','inicials',{ docent => { -like => '%pujol%' } })->hash;
# is($results->{'inicials'},'JP','I have been found in the database');

# Check model
# ok($model->doc_nom('JP') =~ /Pujol/, 'Troba el nom a partir de les inicials');
# is($model->un_modul('M1')->{'coord'}	, 'JF', 'Sap que el coordinador del M1  és en Joel');
# is($model->un_modul('M5d')->{'coord'}	, 'MM', 'Sap que el coordinador del M5d és la Perru');
# is($model->un_modul('M6')->{'coord'}	, 'JP', 'Sap que el coordinador del M6  és el Oso');
# ok($model->h_class('M1') > 10, 'Calcula les hores de classe assignades en el mòdul' );
# is($model->h_class('M1'), 45, 'S\'han programat correctament les hores docents del M1');
# say $model->h_class('M5d');
# say $model->h_class('M6');
# ok($model->h_class('M5d') > 10, 'Calcula hores M5d' );
# ok($model->h_class('M6')  > 10, 'Calcula hores M6'  );

done_testing();
