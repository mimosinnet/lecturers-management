package GestioMaster::Model::DB;
use Mojo::Base -base;
use DateTime;

has 'sqlite';

# Aquesta també huria de funcionar: 
# has sqlite =>  sub { Mojo::SQLite->new('sqlite:db/master.db')->db };

# centres {{{

sub db_centres {
	my $self = shift;
	return $self->sqlite->db->select('c_practic');
}

sub centre_id {
	my ($self, $id) = @_;
	return $self->sqlite->db->select('centres',undef,{ id => $id})->hash;
}

sub id_ord { 
	my $self = shift;
	return $self->sqlite->db->select('centres','id',undef,'docent');
}

sub centre_insert {
	my ($self, $centre) = @_;
  return $self->sqlite->db->insert('centres',$centre);
}

sub centre_update_id {
	my ($self, $centre, $id) = @_;
  return $self->sqlite->db->update('centres',$centre,{ id => $id});
}

sub centre_delete_id {
	my ($self, $id) = @_;
  return $self->sqlite->db->delete('centres',{ id => $id });
}

# }}}

# Sessio {{{

sub sessions { shift->sqlite->db->select('Sessio') }

sub sessio_from_id {
	my ($self, $id) = @_;
	return $self->sqlite->db->select('sessio',undef,{ id => $id})->hash;
}

sub sessio_from_dates {
	my ($self, $date_num, $inici, $fi) = @_;

	return $self->sqlite->db->select(
		'sessio',
		undef,
		{ 
			date_num =>	{ -between => [ $inici , $fi] } 
		},
		'date_num',
	);
}

sub sessio_modul {
	my ($self, $modul) = @_;
	return $self->sqlite->db->select('sessio',undef,{ modul => $modul	},'date_num');
}

sub sessio_docent_hores {
	my ($self, $docent) = @_;
	return $self->sqlite->db->query("SELECT sum(durada) AS hores FROM sessio WHERE docent = '$docent' ")->hash->{'hores'};
}

sub sessio_depart_hores {
	my ($self, $depart) = @_;
	return $self->sqlite->db->query("SELECT sum(durada) AS hores FROM sessio JOIN docents ON sessio.docent = docents.inicials WHERE depart = '$depart' ")->hash->{'hores'};
}

sub sessio_modul_hores {
	my ($self, $modul ) = @_;
	if 	( $modul eq 'M5d' ) { 
		return $self->sqlite->db->query("SELECT sum(M5d) AS estud FROM tfm ")->hash->{'estud'};
	} 
	elsif ( $modul eq 'M6' 	) { 
		return $self->sqlite->db->query("SELECT sum(M6)  AS estud FROM tfm ")->hash->{'estud'};
	} 
	else 											{ 
		return $self->sqlite->db->query("SELECT sum(durada) AS hores FROM sessio WHERE modul = '$modul' AND docent != 'A0' ")->hash->{'hores'};
	}
}


# Update, Insert, Delete {{{
sub sessio_update_id {
  my ($self, $sessio, $id) = @_;
  return $self->sqlite->db->update('sessio',$sessio,{ id => $id });
}

sub sessio_insert {
  my ($self, $sessio) = @_;
  return $self->sqlite->db->insert('sessio',$sessio);
}

sub sessio_delete_id {
  my ($self, $id) = @_;
	return $self->sqlite->db->delete('sessio',{ id => $id });
}
# }}}

# }}}

# moduls {{{

# tots els camps d'un modul
sub un_modul {
	my ($self, $modul) = @_;
	return $self->sqlite->db->select('moduls',undef,{ modul => $modul})->hash;
}

sub llista_mod {
	my $self = shift;
	return  $self->sqlite->db->select('moduls','modul');
}

# docents en el modul en forma de Hashref de docents{inicials}=nom docent
sub modul_docents {
	my ($self, $modul) = @_;
	my %docent;
	my $docents_modul;
	if 		( $modul eq 'M5d' ) { $docents_modul = $self->doc_tfm( 'M5d' )} 
	elsif ( $modul eq 'M6' 	) { $docents_modul = $self->doc_tfm( 'M6'  )} 
	else 											{ $docents_modul = $self->doc_m( $modul )}
	while ( my $set = $docents_modul->hash ) {
		my $doc_nom = $self->doc_nom( $set->{'docent'} );
		$docent{$set->{'docent'}} = $doc_nom;
	};
	return \%docent;
}

# docents en el modul
sub doc_m {
	my ($self, $modul) = @_;
	return $self->sqlite->db->select('sessio','docent',{ modul => $modul });
}

# docents en tfm
sub doc_tfm {
	my ($self, $modul) = @_;
	return $self->sqlite->db->select('tfm','docent',{ $modul => 1 });
}

# moduls on imparteix docència un docent
sub moduls_docent {
	my ($self, $docent) = @_;
	return $self->sqlite->db->query("SELECT DISTINCT modul FROM sessio WHERE docent = '$docent' ORDER BY modul");
}

# modul_estud_update: update number of students in module
sub modul_estud_update {
	my ($self, $modul, $n_estud) = @_;
  return $self->sqlite->db->update('moduls',{ 'n_estud' => $n_estud},{ 'modul' => $modul });
}

# modul_coord_update: update module coordinator
sub modul_coord_update {
	my ($self, $modul, $coord) = @_;
  return $self->sqlite->db->update('moduls',{ 'coord' => $coord},{ 'modul' => $modul });
}

# }}}

# TFM {{{

sub tfm_all {
	my $self = shift;
	return $self->sqlite->db->select('tfm',undef,undef,'docent');
}

sub tfm_id {
	my ($self, $id) = @_;
	return $self->sqlite->db->select('tfm',undef,{ id => $id  })->hash;
}

sub tfm_docent {
	my ($self, $docent) = @_;
	return $self->sqlite->db->select('tfm',undef,{ docent => $docent  })->hash;
}

sub tfm_insert {
  my ($self, $tfm) = @_;
  return $self->sqlite->db->insert('tfm',$tfm);
}
sub tfm_update_id {
  my ($self, $tfm, $id) = @_;
  return $self->sqlite->db->update('tfm',$tfm,{ id => $id });
}
sub tfm_delete_id {
  my ($self, $id) = @_;
  return $self->sqlite->db->delete('tfm',{ id => $id });
}

# }}}

# depart {{{

sub depart_all { shift->sqlite->db->select('depart') }

sub depart_codi {
	my ($self, $codi) = @_;
	return $self->sqlite->db->select('depart','depart',{ codi => $codi })->hash->{'depart'};
}

# }}}

# Docents {{{

# El nom d'un docent a partir de les inicials
sub doc_nom {
	my ($self, $inicials ) = @_;
	return $self->sqlite->db->select('docents','docent',{ inicials => $inicials })->hash->{'docent'} 
}

# Registre docent a partir de les inicials
sub docent {
	my ($self, $inicials ) = @_;
	return $self->sqlite->db->select('docents',undef,{ inicials => $inicials })->hash;
}

# Llista d'inicials de noms de docent
sub inicials {
	my $self = shift;
	return $self->sqlite->db->select('docents','inicials');
}

# llista dels registres de docents
sub es_docent {
	my $self = shift;
	return $self->sqlite->db->select('docents',undef,{ es_docent => 1},'docent');
}
# }}}

# Hores {{{

# No el fem servir, doncs hauríem d'actualitzar aquesta taula. 

# hores cobertes pels docents
sub h_class {
	my ($self, $modul) = @_;
	if 		( $modul eq 'M5d' ) { 
		return $self->sqlite->db->query("SELECT sum(M5d) AS M5d FROM tfm ")->hash->{'M5d'};
	} 
	elsif ( $modul eq 'M6' 	) { 
		return $self->sqlite->db->query("SELECT sum(M6)  AS M6  FROM tfm ")->hash->{'M6'};
	} 
	else 											{ 
		return $self->sqlite->db->query("SELECT sum(h_class)	FROM hora WHERE modul = '$modul' ")->hash->{'sum(h_class)'};
	}
}

sub hores_docent {
	my ($self, $docent) = @_;
	return $self->sqlite->db->query("SELECT sum(h_class) FROM hora WHERE docent = '$docent' ")->hash->{'sum(h_class)'};
}

sub h_dept {
	my ($self, $depart) = @_;
  return $self->sqlite->db->query("SELECT sum(hora.h_class) AS hores FROM hora JOIN docents ON hora.docent = docents.inicials WHERE depart = '$depart' ")->hash->{'hores'};
}

# Hores Depart {{{
# A FER: Mirar com fer un joint
sub hores_depart {
	my ($self, $depart) = @_;
	return $self->db->resultset('Docent')->search_rs(
		{ depart => $depart },
		{	join => 'sessios',
				'+select'	=>	['sessios.durada'],
				'+as'			=>	['durada']
		}
	)->get_column('durada')->sum;
}
# }}}

sub hores_modul_docent {
	my ($self, $modul, $docent) = @_;
	return $self->db->resultset('Sessio')->search_rs({ modul => $modul, docent => $docent })->get_column('durada')->sum;
}

sub hores_modul_cobertes {
	my ($self, $modul) = @_;
	return $self->db->resultset('Sessio')->search_rs({ 
			modul => $modul, 
			docent => { '>=' => 'AA' },
		})->get_column('durada')->sum;
}

# }}}

1;
