package GestioMaster::Obj::Depart;
use Mojo::Base -base;
# Object that makes database available
use GestioMaster::Obj::DB;

has model   => sub { GestioMaster::Obj::DB->new->model };

has codi    => "";

has depart  => sub { 
  my $self = shift;
  return $self->model->depart_codi( $self->codi );
};

has h_dept  => sub {
  my $self = shift;
	return $self->model->sessio_depart_hores( $self->codi );
};

1;
