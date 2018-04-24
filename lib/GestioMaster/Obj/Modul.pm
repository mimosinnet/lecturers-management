package GestioMaster::Obj::Modul;
use Mojo::Base -base;
# Object that makes database available
use GestioMaster::Obj::DB;

has _model		=> sub { GestioMaster::Obj::DB->new->model  };
has modul 		=> "";

has un_modul 	=> sub { 
	my $self = shift;
	return $self->_model->un_modul( $self->modul );
};

has ident 		=> sub { shift->un_modul->{'ident'} };
has coord			=> sub { shift->un_modul->{'coord'} };
has nom_modul => sub { shift->un_modul->{'nom_modul'}; };
has tipus 		=> sub { shift->un_modul->{'tipus'} };
has credits 	=> sub { shift->un_modul->{'credits'} };
has semestre 	=> sub { shift->un_modul->{'semestre'} };
has n_estud 	=> sub { shift->un_modul->{'n_estud'} };
has hores 		=> sub { shift->un_modul->{'hores'} };
has horesp 		=> sub { shift->un_modul->{'horesp'} };
has sat 			=> sub { shift->un_modul->{'sat'} };
has total 		=> sub { sprintf("%.2f", shift->un_modul->{'total'}) };
has R 				=> sub { shift->un_modul->{'R'} };
has S 				=> sub { shift->un_modul->{'S'} };
has T 				=> sub { shift->un_modul->{'T'} };

has doc_nom		=> sub {
	my $self = shift;
	return $self->_model->doc_nom( $self->coord );
};

# Hashref de docents{inicials}=nom docent
has docents 	=> sub {
	my $self = shift;
	return $self->_model->modul_docents( $self->modul );
};

# Hores classe cobertes / estudiants coberts en el cas M5d/M6
has sessio_modul_hores => sub {
	my $self = shift;
	return $self->_model->sessio_modul_hores( $self->modul );
};

1;
