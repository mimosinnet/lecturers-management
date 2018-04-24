package GestioMaster::Controller::Ges;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use GestioMaster::Controller::Moduls::Modul;
use GestioMaster::Controller::Moduls::Sessions;
use GestioMaster::Controller::Moduls::TFM; 
use GestioMaster::Obj::Tags;

sub inici { shift->render( moduls =>  GestioMaster::Controller::Moduls::Modul->new->moduls ) }

# modul {{{
sub modul {
	my $self  = shift;
	my $modul = $self->stash('modul');

	# Objecte amb els tags
  my $tags	= GestioMaster::Obj::Tags->new;

	# Ojecte mòdul
	my $modul_obj = GestioMaster::Obj::Modul->new( modul => $modul);
  # $sessions: arrayref d'objectes de sessió en un mòdul + hores docents
	my $sessions = GestioMaster::Controller::Moduls::Sessions->new( modul => $modul);

	$self->render( 
   	sessions 	=> $sessions->sessions,
    h_docents => $sessions->h_docents,
		modul_obj => $modul_obj,
		tag				=> $tags,
    moduls    => GestioMaster::Controller::Moduls::Modul->new->moduls,
	);
}
# }}}

# update_sessio {{{
sub update_sessio {
	my $self = shift;

	my %sessio;
	my @post_param = qw( id date festa hora durada modul docent tema url);
	foreach my $param (@post_param) {
		$sessio{$param} = $self->param($param);
	}

  my $id	 = delete $sessio{'id'};
	my $url  = delete $sessio{'url'};
	my $date = delete $sessio{'date'};
	my ($year, $month, $day ) = $date =~ /(\d+)-(\d+)-(\d+)/;
	my $dt = DateTime->new(
		  year       => $year,
      month      => $month,
      day        => $day,
      hour       => delete $sessio{'hora'},
      minute     => 0,
	);

	$sessio{'date_num'} = $dt->epoch;

  $self->model->sessio_update_id(\%sessio, $id);

	$self->redirect_to( '/ges/modul/' . $self->param('modul') );
}
# }}}

# tfm {{{
sub tfm {
	my $self = shift;

	# Ojecte mòdul
	my $TFM = GestioMaster::Controller::Moduls::TFM->new; 
  my $moduls = GestioMaster::Controller::Moduls::Modul->new->moduls;


	$self->render( 
		tfm 	 => $TFM->tfm,
    h_tfm	 => $TFM->h_tfm,
    M5d 	 => $moduls->[11],
		M6 		 => $moduls->[12],
    moduls => $moduls,
	);
}
# }}}


1;
