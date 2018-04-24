package GestioMaster::Controller::Moduls::Docents;
use Mojo::Base -base;
use GestioMaster::Obj::DB;
use GestioMaster::Obj::Docent;

has _model	=> sub { GestioMaster::Obj::DB->new->model };

# array-ref d'objectes de docents
has docents => sub {
	my $self = shift;
	my $docents_rs = $self->_model->es_docent;
	my $docents = [];
	while ( my $set = $docents_rs->hash) {
		my $docent = GestioMaster::Obj::Docent->new( inicials => $set->{'inicials'} );
		push @$docents, $docent;
	}
	return $docents;
};

1;

