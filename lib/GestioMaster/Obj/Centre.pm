package GestioMaster::Obj::Centre;
use Mojo::Base -base;
# Object that makes database available
use GestioMaster::Obj::DB;

has model    => sub { GestioMaster::Obj::DB->new->model };

has id       => "";

has centre_id => sub { 
  my $self = shift;
  return $self->model->centre_id( $self->id );
};

has centre   => sub { shift->centre_id->{'centre'}    };
has places   => sub { shift->centre_id->{'places'}    };
has any      => sub { shift->centre_id->{'any'};      };
has respons  => sub { shift->centre_id->{'respons'};  };
has contact1 => sub { shift->centre_id->{'contact1'}; };
has contact2 => sub { shift->centre_id->{'contact2'}; };
has docent   => sub { shift->centre_id->{'docent'};   };
has descrip  => sub { shift->centre_id->{'descrip'};  };

has doc_nom  => sub {
  my $self = shift;
  return $self->model->doc_nom( $self->docent );
};

# Llista de id ordenats per docent
has id_ord   => sub {
  my $self = shift;
  return $self->model->id_ord;
};

1;
