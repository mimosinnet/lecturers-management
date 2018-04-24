use Modern::Perl;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::Modul;
use Data::Printer;

# array-ref d'objectes de centre
my $moduls =  GestioMaster::Controller::Moduls::Modul->new->moduls;

# p($moduls);
# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $moduls };
# for my $modul ( @{ $moduls } ) { say $modul->modul };

is(scalar @{ $moduls }, 13, 'Tenim programats 13 mòduls');

done_testing();
