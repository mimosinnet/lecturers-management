package GestioMaster::Controller::Moduls::Centres;
use Mojo::Base -base;
use GestioMaster::Obj::Centre;

# Hem de tenir una llista dels id ordenats per docent
has _id_ord	=> sub { GestioMaster::Obj::Centre->new->id_ord};

# array-ref d'objectes de centres
has centres => sub {
	my $self = shift;
	my $centres = [];
	while (my $id = $self->_id_ord->hash) {
  	push @$centres, GestioMaster::Obj::Centre->new( id => $id->{'id'} );
	}
	return $centres;
};

1;
