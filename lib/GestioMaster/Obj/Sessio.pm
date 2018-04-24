package GestioMaster::Obj::Sessio;
use Mojo::Base -base;
use DateTime;
use GestioMaster::Obj::DB;

has _model		=> sub { GestioMaster::Obj::DB->new->model  };

has id			=> "";

has _sessio	=> sub {
	my $self  = shift;
	return $self->_model->sessio_from_id( $self->id );
};

has date_num => sub { shift->_sessio->{'date_num'} };
has durada 	 => sub { shift->_sessio->{'durada'}   };
has modul 	 => sub { shift->_sessio->{'modul'}    };
has docent	 => sub { shift->_sessio->{'docent'} 	};
has tema 		 => sub { shift->_sessio->{'tema'}			};
has festa 	 => sub { shift->_sessio->{'festa'}		};

has doc_nom	 => sub {
	my $self = shift;
	return $self->_model->doc_nom( $self->docent );
};

has sessio_dt => sub{
	my $self = shift;
	my $date_num = $self->date_num;
	return DateTime->from_epoch( epoch => $date_num );
};

has sessio_date => sub {
	my $self = shift;
	my $sessio_dt = $self->sessio_dt;
	return { 
		year 	=> $sessio_dt->year, 
		month => $sessio_dt->month, 
		day 	=> $sessio_dt->day, 
		hour 	=> $sessio_dt->hour,
		ymd		=> $sessio_dt->ymd,
	};
};

has sessio_hora => sub {
	my $self = shift;
	my $sessio_inici = $self->sessio_date->{'hour'};
	my $durada = $self->durada;
	return { inici => $sessio_inici, fi => $sessio_inici + $durada }
};

has contingut_sessio => sub {
	my $self = shift;
	my 	( $festa,				$tema, 			 $modul, 			 $sessio_hora) = 
			( $self->festa, $self->tema, $self->modul, $self->sessio_hora );

	my $contingut_sessio;
	if ( $festa ) {
 	  $contingut_sessio = "<b>$tema</b>";
	} elsif ( $modul eq "_ALT" ) {
 	  $contingut_sessio = "<b>$sessio_hora->{'inici'}-$sessio_hora->{'fi'} $tema</b>";
	} else {
		$contingut_sessio = "$sessio_hora->{'inici'}-$sessio_hora->{'fi'} $modul"
	}
	return $contingut_sessio;
};

sub year_month {
	my $self = shift;
	my $sessio_date = $self->sessio_date;
	my ( $year, $month) = ( $sessio_date->{'year'}, $sessio_date->{'month'} );
	return $year . sprintf("%02d",$month);
}

1;
