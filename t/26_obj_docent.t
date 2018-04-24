use Modern::Perl;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::Docent;
use Data::Printer;

my $docent = GestioMaster::Obj::Docent->new( inicials => 'JP' );

# p($docent);
# p($docent->docent);

# for my $info ( qw/ docent correu depart hores moduls / ) {	p($docent->$info) }

#is($docent->docent,'JP', 'JP supervisa TFM');
ok($docent->docent =~ /Pujol/, 'Troba el meu nom');
ok($docent->moduls =~ /M3b/, 'Dono classes al M3b');
ok($docent->hores > 5, 'Dono més de 5 hores al màster');

done_testing();
