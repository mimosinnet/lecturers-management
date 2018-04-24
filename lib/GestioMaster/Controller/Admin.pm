package GestioMaster::Controller::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use GestioMaster::Controller::Moduls::Modul;
use GestioMaster::Controller::Moduls::Centres;
use GestioMaster::Controller::Moduls::Sessions;
use GestioMaster::Controller::Moduls::TFM; 
use GestioMaster::Obj::Calendari;
use GestioMaster::Obj::Tags;

# els tags es fan servir sovint, els poso aquí. No posem els moduls, doncs els moduls s'actualitzen i els tags no.
state	$tags		= GestioMaster::Obj::Tags->new;

sub inici { shift->render( moduls => GestioMaster::Controller::Moduls::Modul->new->moduls ) }

# moduls - coord {{{1

# coords {{{
sub moduls {
	my $self = shift;

	$self->render (
		moduls 	=> GestioMaster::Controller::Moduls::Modul->new->moduls,
		tag 		=> $tags,
	);
}
# }}}

# set coord (modul_coord_update) {{{
sub set_coord {
	my $self = shift;
  $self->model->modul_coord_update( $self->param('modul'), $self->req->param('coord') );
	$self->redirect_to('/admin/moduls');
}
# }}}

# }}}

# Calendari {{{
sub calendari {
	my $self = shift;

	# Definim el calendari
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

		$calendari_curs->sessio($sessio)->definir_sessio_admin;
	}

	# Passem el hashref dels calendaris
	$self->render(
		calendar => $calendari_curs->calendar,
		moduls 	=> GestioMaster::Controller::Moduls::Modul->new->moduls,
	);
}
# }}}

# Gestió sessions {{{

# afegir_sessio calendari {{{
sub afegir_sessio {
	my $self = shift;
	my $date_num  = $self->stash('date_num');

	# Afaga data inici i final de config {{{
	my $data_inici = $self->app->plugin('Config')->{dates_curs}->{inici};
	my $data_final = $self->app->plugin('Config')->{dates_curs}->{final};
	# }}}

	# Tenir en compte que cada vegada que es va modificant l'objecte dt amb dt->add
	my $dt 		= DateTime->from_epoch( epoch => $date_num );
	my $inici = $dt->epoch;
	my $fi		= $dt->add( months => 1 )->epoch;

	# Sessions entre les dates 
	my $sessio_rs = $self->model->sessio_from_dates($date_num, $inici, $fi);

	# Array-ref de sessions
	my $sessions = [];
	while (my $set = $sessio_rs->hash ) {
		my $sessio = GestioMaster::Obj::Sessio->new( 	id	=> $set->{'id'} );
		push @$sessions, $sessio;
	};

	$self->render( 
		date_num => $date_num,
		fi			 => $dt->dmy,
		inici		 => $dt->subtract( months => 1)->dmy,
		inici_ymd => $dt->ymd,
		sessions => $sessions,
		tags		 => $tags,
		data_min => $data_inici,
		data_max => $data_final,
		moduls 	 => GestioMaster::Controller::Moduls::Modul->new->moduls,
	);
}
# }}}

# Anar sessio {{{
sub anar_sessio {
	my $self = shift;

	my $anar_data = $self->param('anar_data');
	my ($year, $month, $day ) = $anar_data =~ /(\d+)-(\d+)-(\d+)/;
	my $dt = DateTime->new(
		  year       => $year,
      month      => $month,
      day        => $day,
      hour       => 0,
      minute     => 0,
	);

	$self->redirect_to("/admin/afegir_sessio/" . $dt->epoch );
}
# }}}

# set_sessio: afegir sessio {{{
sub set_sessio {
	my $self = shift;

	my %sessio;
	my @post_param = qw( date festa hora durada modul docent tema);
	foreach my $param (@post_param) {
		$sessio{$param} = $self->param($param);
	}

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

	$self->model->sessio_insert(\%sessio);

	$self->redirect_to("/admin/afegir_sessio/$sessio{'date_num'}");
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

	$self->redirect_to($url);
}
# }}}

# Borrar Sessio {{{
sub borrar_sessio {
	my $self = shift;
	my $id = $self->param('id');
	my $url = $self->param('url');

	$self->model->sessio_delete_id( $id );

	$self->redirect_to($url);
}
# }}}

# }}}

# centres {{{

# Mostrar centre {{{
sub centres {
	my $self = shift;

	my $centres = GestioMaster::Controller::Moduls::Centres->new->centres;

	$self->render(
		moduls 	 => GestioMaster::Controller::Moduls::Modul->new->moduls,
		centres => $centres,
		tag			=> $tags,
	);
}
# }}}

# centre_add: afegir centre {{{
sub centre_add {
	my $self = shift;

	my %centre;
	my @post_param = qw( places docent centre descrip );
	foreach my $param (@post_param) {
		$centre{$param} = $self->param($param);
	}

	$self->centre_insert(\%centre);

	$self->redirect_to('/admin/centres');
}
# }}}

# centre_udate {{{
sub centre_update {
	my $self = shift;

	my %centre;
	my @post_param = qw( id places docent centre descrip );
	foreach my $param (@post_param) {
		$centre{$param} = $self->param($param);
	}
	my $id = delete $centre{'id'};
	$self->model->centre_update_id(\%centre, $id);

	$self->redirect_to('/admin/centres');
}
# }}}

# centre_del {{{
sub centre_del {
	my $self = shift;
	$self->model->centre_delete_id( $self->param('id') );
	$self->redirect_to('/admin/centres');
}
# }}}


# }}}

# modul {{{1

# modul {{{
sub modul {
	my $self = shift;
	my $modul = $self->stash('modul');

	# Ojecte mòdul
	my $modul_obj = GestioMaster::Obj::Modul->new( modul => $modul);

	# $sessions: arrayref d'objectes de sessió en un mòdul
	my $sessions = GestioMaster::Controller::Moduls::Sessions->new( modul => $modul);

	$self->render( 
		sessions 	=> $sessions->sessions,
    h_docents => $sessions->h_docents,
		modul 		=> $modul,
		mod       => $modul_obj,
		tag				=> $tags,
		moduls 	  => GestioMaster::Controller::Moduls::Modul->new->moduls,
	);
}
# }}}

# /admin/estud/:modul: modify number of students in :modul {{{
sub estud {
	my $self = shift;
	my $modul = $self->stash('modul');
  my $n_estud = $self->param('n_estud');

  say $modul;
  say $n_estud;

  $self->model->modul_estud_update( $modul, $n_estud );

	$self->redirect_to("/admin/modul/$modul");
}
# }}}


# tfm {{{2

# tfm_show {{{3
sub tfm {
	my $self = shift;

	my $TFM    = GestioMaster::Controller::Moduls::TFM->new; 
	my $moduls = GestioMaster::Controller::Moduls::Modul->new->moduls;

	$self->render( 
		tfm 	 => $TFM->tfm,,
		h_tfm	 => $TFM->h_tfm,
		M5d 	 => $moduls->[11],
		M6 		 => $moduls->[12],
		tag		 => $tags,
		moduls => $moduls,
	);
}
# }}}

# tfm_add {{{3
sub tfm_add {
	my $self = shift;

	my %tfm;
	my @post_param = qw( M5d M6 docent estud titol observ );
	foreach my $param (@post_param) {
		$tfm{$param} = $self->param($param);
	}

  my $sqlite = GestioMaster::Obj::DB->new->sqlite;
	$self->model->tfm_insert(\%tfm);

	$self->redirect_to('/admin/tfm');
}
# }}}

# tfm_update {{{3
sub tfm_update {
	my $self = shift;

	my %tfm;
	my @post_param = qw( id M5d M6 docent estud titol observ );
	foreach my $param (@post_param) {
		$tfm{$param} = $self->param($param);
    # say "$param: $tfm{$param}";
	}

  my $id = delete $tfm{ 'id' }; 
  $self->model->tfm_update_id( \%tfm, $id );

	$self->redirect_to('/admin/tfm');
}

# }}}

# tfm_del {{{3
sub tfm_del {
	my $self = shift;
	$self->model->tfm_delete_id( $self->param('id') );
	$self->redirect_to('/admin/tfm');
}
# }}}

# 1}}}

# }}}

1;
