use Modern::Perl;
use Test::More tests => 2;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::Depart;
# use Data::Printer;

my $depart = GestioMaster::Obj::Depart->new( codi => 'DPS' );

# p($depart);
# p($depart->h_dept);

# for my $info ( qw/ docent correu depart hores moduls / ) {	p($depart->$info) }

#is($depart->docent,'JP', 'JP supervisa TFM');
ok($depart->depart =~ /Social/, 'Troba departament de psicologia social');
ok($depart->h_dept > 200, 'El deparament de social dona més de 200 hores');
# ok($depart->hores > 5, 'Dono més de 5 hores al màster');

done_testing();
