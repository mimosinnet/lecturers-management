package GestioMaster::Obj::TFM;
use Mojo::Base -base;
use GestioMaster::Obj::DB;

has _model => sub { GestioMaster::Obj::DB->new->model };

has id => "";

has _tfm => sub {
	my $self = shift;
	return $self->_model->tfm_id( $self->id );
};

has M5d    => sub { shift->_tfm->{'M5d'   } };
has M6     => sub { shift->_tfm->{'M6'    } };
has docent => sub { shift->_tfm->{'docent'} };
has estud  => sub { shift->_tfm->{'estud' } };
has titol  => sub { shift->_tfm->{'titol' } };
has observ => sub { shift->_tfm->{'observ'} };

has doc_nom => sub {
	my $self = shift;
	return $self->_model->doc_nom( $self->docent );
};

1;
