use Modern::Perl;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::Docents;
use Data::Printer;

# array-ref d'objectes de centre
my $docents =  GestioMaster::Controller::Moduls::Docents->new->docents;

# p($docents);
# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $centres };
# for my $centre ( @{ $centres } ) { say $centre->centre };

ok(scalar @{ $docents } > 20, 'Tenim més de 20 docents');

# is($docents->[0]->docent,'JF','La primera sessió M1 la fa en Joel');

done_testing();
