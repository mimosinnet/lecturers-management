use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Mojo::SQLite;
use Data::Printer;

# Test per accedir directament a la base de dades, per resoldre problemes que teniem amb el test següent

my $sqlite = Mojo::SQLite->new('sqlite:db/master.db');

sub modul_estud_update {
  my ( $modul, $n_estud) = @_;
  return $sqlite->db->update('moduls',{ 'n_estud' => $n_estud},{ 'modul' => $modul });
}

sub un_modul {
  my $modul = shift;
  return $sqlite->db->select('moduls',undef,{ modul => $modul})->hash;
}

my $n_estud_abans = un_modul( 'M1' )->{'n_estud'};
ok($n_estud_abans > 20, "Tenim $n_estud_abans estudiants en el M1");

modul_estud_update( 'M1', 5 );
is(un_modul( 'M1' )->{'n_estud'}, 5, 'Hem canviat el número d\'estudiants a 5');

modul_estud_update( 'M1', $n_estud_abans );
is(un_modul( 'M1' )->{'n_estud'},$n_estud_abans,"Hem tornat a posar el valor $n_estud_abans al nombre d\'estudiants");

# p($database);
# p($model->depart_codi('DPS' ));

# ok($model->h_dept('DPS') > 200, 'El departament de Psicologia Social dona més de 200 hores');
# ok($model->depart_codi('DPS') =~ /Social/, 'Troba el departament de Psicologia Social');

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
