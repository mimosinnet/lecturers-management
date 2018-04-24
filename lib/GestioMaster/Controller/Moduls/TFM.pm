package GestioMaster::Controller::Moduls::TFM;
use Mojo::Base -base;
use GestioMaster::Obj::DB;
use GestioMaster::Obj::TFM;

has _model	=> sub { GestioMaster::Obj::DB->new->model };

# array-ref d'objectes de tfm ordenats per docent
has tfm	=> sub {
	my $self = shift;
	my $tfm = [];
	my $tfm_rs = $self->_model->tfm_all;
	while (my $set = $tfm_rs->hash ) {
		my $sessio = GestioMaster::Obj::TFM->new( id => $set->{'id'} );
		push @$tfm, $sessio;
	}
	return $tfm;
};

# Càlcul Càrrega Docent
has h_tfm => sub {
	my $self = shift;
	my %c_docent;
	my %c_docent_inv;
	my %c_docent_int;
	my $tfm_rs = $self->_model->tfm_all;
	while ( my $set = $tfm_rs->hash ) {
		$c_docent{ $set->{'docent'} } += 1;
		if      ( $set->{'M5d'} ) { 
			$c_docent_int{ $set->{'docent'} } += 1;
		}	elsif ( $set->{'M6'} ) { 
			$c_docent_inv{ $set->{'docent'} } += 1;
		}
	}

	my $h_tfm = "<b>Docent</b> (inter/inves): ";
	foreach my $docent ( sort keys %c_docent ) {
		my $c_doc = $c_docent{$docent} // 0;
		my $c_doc_int = $c_docent_int{$docent} // 0;
		my $c_doc_inv = $c_docent_inv{$docent} // 0;
		$h_tfm .= "$docent $c_doc ($c_doc_int/$c_doc_inv), ";
	}
	return $h_tfm;
};

1;
