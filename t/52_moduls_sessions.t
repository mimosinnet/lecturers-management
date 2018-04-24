use Modern::Perl;
use Test::More tests => 2;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Controller::Moduls::Sessions;
use Data::Printer;

# array-ref d'objectes de centre
my $sessions =  GestioMaster::Controller::Moduls::Sessions->new( modul => 'M1' );

# p($sessions->h_docents);
# foreach my $centre ( @{ $centres->centres } ) { say $centre->centre . " - " . $centre->doc_nom; }

# say scalar @{ $centres };
# for my $centre ( @{ $centres } ) { say $centre->centre };

# ok(scalar @{ $centres } > 10, 'Tenim programats més de 10 mòduls');

is($sessions->sessions->[0]->docent,'JF','La primera sessió M1 la fa en Joel');
ok($sessions->h_docents =~ /JF/,'Calcula Hores Docents');

done_testing();
