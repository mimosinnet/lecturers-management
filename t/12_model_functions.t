use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::DB;
use Data::Printer;

my $model = GestioMaster::Obj::DB->new->model;

# moduls {{{

# modul_docents
ok( exists $model->modul_docents('M1')->{'JF'}, 'En JF dona classe al M1');
ok( exists $model->modul_docents('M6')->{'JP'}, 'En JP té estudiants al M6');

# }}}

# sessions {{{

# sessio_modul_hores 
ok($model->sessio_modul_hores('M5a') > 10, 'Tenims coberts més de 10 hores en el M5d');
ok($model->sessio_modul_hores('M5d') > 10, 'Tenims coberts més de 10 estudiants en el M5d');
ok($model->sessio_modul_hores('M6')  > 10, 'Tenims coberts més de 10 estudiants en el M6');
# }}}

ok($model->h_dept('DPS') > 200, 'El departament de Psicologia Social dona més de 200 hores');
ok($model->depart_codi('DPS') =~ /Social/, 'Troba el departament de Psicologia Social');

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
