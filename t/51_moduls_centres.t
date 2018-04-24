use Modern::Perl;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::Centres;
# use Data::Printer;

# array-ref d'objectes de centre
my $centres =  GestioMaster::Controller::Moduls::Centres->new->centres;

# p($centres);
# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $centres };
# for my $centre ( @{ $centres } ) { say $centre->centre };

ok(scalar @{ $centres } > 10, 'Tenim programats més de 10 mòduls');

done_testing();
