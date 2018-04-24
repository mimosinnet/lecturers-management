package GestioMaster::Controller::Moduls::Calendari;
use Mojo::Base -base;
use GestioMaster::Objects::Calendari;

has inici => "";
has fi		=> "";
has inici_nadal => "";
has final_nadal => "";
has inici_santa => "";
has final_santa => "";

has calendari_curs => sub {
	my $self = shift;
	my $calendari_curs = GestioMaster::Objects::Calendari->new(
			inici => $self->inici,
			fi    => $self->final,
		);
};

1;
