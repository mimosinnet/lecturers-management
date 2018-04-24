use Modern::Perl;
use Test::More tests => 2;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::TFM;
use Data::Printer;

# array-ref d'objectes de centre
my $tfm = GestioMaster::Controller::Moduls::TFM->new;

# p($tfm->tfm);
# p($tfm->h_tfm);

# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $centres };
# for my $centre ( @{ $centres } ) { say $centre->centre };

# ok(scalar @{ $centres } > 10, 'Tenim programats més de 10 mòduls');

# is($sessions->[0]->docent,'JF','La primera sessió M1 la fa en Joel');

ok(scalar  @{ $tfm->tfm } > 10, 'Hi ha més de 10 TFM');
ok(defined $tfm->h_tfm, 'Les hores de TFM de cada docent estan definides');

done_testing();
