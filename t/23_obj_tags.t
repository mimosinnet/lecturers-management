use Modern::Perl;
use Test::More tests => 2;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use GestioMaster::Obj::Tags;
# use Data::Printer;

my $tags = GestioMaster::Obj::Tags->new;

# p($tags->tag_modul);

ok($tags->tag_docent =~ /option value="JP"/	, 'Té tags definits docent');
ok($tags->tag_modul  =~ /<option value="M1"/, 'Té tags definits mòdul');

done_testing();
