package GestioMaster::Obj::Tags;
use Mojo::Base -base;
# Object that makes database available
use GestioMaster::Obj::DB;

has _model				=> sub { GestioMaster::Obj::DB->new->model  };

has inicials		=> sub { shift->_model->inicials };

has llista_mod 	=> sub { shift->_model->llista_mod };

has tag_durada	=> sub {
	my $opcions_durada;
	foreach my $var ( 2, 1, 2, 3, 4, 5, 24 ) {
		$opcions_durada .= qq(<option value="$var">$var h</option>);
	}
	return $opcions_durada;
};

has tag_hora	=> sub {
	my $opcions_hora;
	foreach my $hora (qw/09 10 11 12 13 14 15 16 17 18 19 20/) {
		$opcions_hora .= qq(<option value="$hora">$hora:00</option>);
	}
	return $opcions_hora;
};

has tag_docent => sub {
	my $self = shift;
	my $options_docent = "";
	while (my $set = $self->inicials->hash) {
		my $inicials = $set->{'inicials'};
		my $docent	 = $self->_model->doc_nom( $inicials );
		$options_docent .= qq(<option value="$inicials">$docent</option>);
	}
	return $options_docent;
};

has tag_modul => sub {
	my $self = shift;
	my $options_modul = "";
	while (my $set = $self->llista_mod->hash) {
		my $modul = $set->{'modul'};
		$options_modul .= qq(<option value="$modul">$modul</option>);
	}
	return $options_modul;
};

1;
