package GestioMaster::Controller::Moduls::Sessions;
use Mojo::Base -base;
use GestioMaster::Obj::DB;
use GestioMaster::Obj::Sessio;

has modul     => "";
has _model	  => sub { GestioMaster::Obj::DB->new->model };

has h_docents => sub {
	my $self = shift;
	my $sessions_rs = $self->_model->sessio_modul($self->modul);
	my %c_docent;
	while ( my $set = $sessions_rs->hash ) {
		$c_docent{ $set->{'docent'} } += $set->{'durada'};
	}
	my $h_docents;
	foreach my $docent ( sort keys %c_docent ) {
		$h_docents .= "$docent ($c_docent{$docent}), ";
	}
	return $h_docents;
};

# array-ref d'objectes de sessió
has sessions => sub {
	my $self = shift;
	my $sessio_rs = $self->_model->sessio_modul($self->modul);
	my $sessions = [];
	while (my $set = $sessio_rs->hash ) {
		my $sessio = GestioMaster::Obj::Sessio->new( id	=> $set->{'id'} );
		push @$sessions, $sessio;
	}
	return $sessions;
};

1;
