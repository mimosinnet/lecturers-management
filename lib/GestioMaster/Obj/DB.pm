package GestioMaster::Obj::DB;
use Mojo::Base -base;

use Mojo::SQLite;
use GestioMaster::Model::DB;

has sqlite => sub { Mojo::SQLite->new('sqlite:db/master.db') };

has model  => sub {
	my $self = shift;
	return GestioMaster::Model::DB->new( sqlite =>  $self->sqlite );
};

1;
