use Modern::Perl;
use Test::More tests => 1;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::Depart;
use Data::Printer;

# array-ref d'objectes de centre
my $depart =  GestioMaster::Controller::Moduls::Depart->new->departs;

# p($depart);
# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $centres };
# for my $centre ( @{ $centres } ) { say $centre->centre };

ok(scalar @{ $depart } eq 3, 'Hi participen 3 departaments');

# is($depart->[0]->docent,'JF','La primera sessió M1 la fa en Joel');

done_testing();
