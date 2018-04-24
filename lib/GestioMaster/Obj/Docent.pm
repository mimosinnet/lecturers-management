package GestioMaster::Obj::Docent;
use Mojo::Base -base;
# Object that makes database available
use GestioMaster::Obj::DB;

has _model		=> sub { GestioMaster::Obj::DB->new->model  };

has inicials 	=> "";

has _docent		=> sub {
	my $self = shift;
	return $self->_model->docent( $self->inicials );
};

has docent		=> sub { shift->_docent->{'docent'} 	};
has correu		=> sub { shift->_docent->{'correu'} 	};
has depart		=> sub { shift->_docent->{'depart'} 	};

# Teaching hours from sessions
has hores 		=> sub {
	my $self = shift;
  return $self->_model->sessio_docent_hores( $self->inicials );
};

has moduls		=> sub { 
	my $self = shift;
	my $mods = $self->_model->moduls_docent( $self->inicials );
	my $moduls;
	while ( my $set = $mods->hash ) {
		$moduls .= "$set->{'modul'} ";
	}
	return $moduls;
};

1;
