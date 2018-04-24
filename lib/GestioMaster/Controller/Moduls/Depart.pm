package GestioMaster::Controller::Moduls::Depart;
use Mojo::Base -base;
use GestioMaster::Obj::DB;
use GestioMaster::Obj::Depart;

has _depart_rs => sub {  GestioMaster::Obj::DB->new->model->depart_all };

# array-ref d'objectes de depart
has departs => sub {
	my $self = shift;
	my @departs;
  while ( my $rs = $self->_depart_rs->hash ) {
		push @departs, GestioMaster::Obj::Depart->new( codi => $rs->{'codi'} );
	}
	return \@departs;
};

1;
