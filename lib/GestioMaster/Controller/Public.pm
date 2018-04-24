package GestioMaster::Controller::Public;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use GestioMaster::Controller::Moduls::Modul;
use GestioMaster::Controller::Moduls::Centres;
use GestioMaster::Controller::Moduls::Sessions;
use GestioMaster::Controller::Moduls::Docents;
use GestioMaster::Controller::Moduls::TFM; 
use GestioMaster::Controller::Moduls::Depart;
use GestioMaster::Obj::Calendari;
use GestioMaster::Obj::Tags;

# array-rey d'objectes de moduls. Està en el heading, comú a tots els mòduls
state $moduls = GestioMaster::Controller::Moduls::Modul->new->moduls;

# inici 
sub inici  { shift->render( moduls => $moduls ) }

# moduls 
sub moduls { shift->render( moduls => $moduls ) }

# carrega docent {{{
sub carrega_docent {
	my $self = shift;

	# arrayref d'objectes de docents 
	my $docents = GestioMaster::Controller::Moduls::Docents->new->docents;

	# arrayref d'objectes de departaments
  my $departs = GestioMaster::Controller::Moduls::Depart->new->departs;

	$self->render(
		docents => $docents,
		departs	=> $departs,
	);
}
# }}}

# calendari {{{ 
sub calendari {
	my $self = shift;

	# Agafem el calendari
	my $calendari_curs = GestioMaster::Obj::Calendari->new;

  # Afegim les sessions al calendari
	my $sessions_rs = $self->model->sessions;
 	while (my $set = $sessions_rs->hash) {
		my $sessio = GestioMaster::Obj::Sessio->new(  
			date_num 	=> $set->{'date_num'}, 
			durada		=> $set->{'durada'}, 
			modul			=> $set->{'modul'}, 
			festa 		=> $set->{'festa'}, 
			tema			=> $set->{'tema'},
		);
		my $year_month = $sessio->year_month;

		$calendari_curs->sessio($sessio)->definir_sessio_public;
	}

	# Passem el hashref dels calendaris
	$self->render(
		calendar => $calendari_curs->calendar,
	);
}
# }}}

# centres{{{
sub centres {
	my $self = shift;
	
	# arrayref d'objectes de centres
	my $centres = GestioMaster::Controller::Moduls::Centres->new->centres;

	$self->render(
		centres => $centres,
	);
}
# }}}

# modul {{{
sub modul {
	my $self = shift;
	my $modul = $self->stash('modul');

	# Objecte mòdul i array-ref de sessions
	my $modul_obj = GestioMaster::Obj::Modul->new( modul => $modul);
	my $modul_ses = GestioMaster::Controller::Moduls::Sessions->new( modul => $modul);
	my $sessions  = $modul_ses->sessions;
  my $h_docents = $modul_ses->h_docents;

	$self->render( 
		sessions 	=> $sessions,
		mod       => $modul_obj,
    h_docents => $h_docents,
	);
}
# }}}

# tfm {{{
sub tfm {
	my $self = shift;

	# Ojecte mòdul
	my $TFM = GestioMaster::Controller::Moduls::TFM->new; 

	$self->render( 
		tfm 	=> $TFM->tfm,
    h_tfm	=> $TFM->h_tfm,
    M5d 	=> $moduls->[11],
		M6 		=> $moduls->[12],
	);
}
# }}}

1;
