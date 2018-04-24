package GestioMaster::Controller::Moduls::Modul;
use Mojo::Base -base;
use GestioMaster::Obj::Modul;

# array-ref d'objectes de modul (confiem en l'ordre dels mòduls)
has moduls => sub {
	my $self = shift;
	my @moduls = qw/M1 M2a M2b M3a M3b M3d M3e M4 M5a M5b M5c M5d M6/;
	my $mod_obj = [];
	foreach my $mod ( @moduls  ) {
		push @{$mod_obj}, GestioMaster::Obj::Modul->new( modul => $mod );
	}
	return $mod_obj;
};

1;
