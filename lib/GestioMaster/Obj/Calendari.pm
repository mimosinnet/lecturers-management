package GestioMaster::Obj::Calendari;
use Mojo::Base -base;
use DateTime;
use HTML::CalendarMonthSimple;
use GestioMaster::Obj::Sessio;

has inici 	=> '2018-09-15',
has fi	  	=> '2019-09-15',
has i_nadal	=> '2018-12-24',
has f_nadal => '2019-01-06',
has i_santa => '2019-04-13',
has f_santa => '2019-04-22',

has sessio => "",

# Crear Calendari {{{
# Anonymous hash of month calendars
has calendar => sub {
	my $self 	= shift;
	my $inici = $self->inici;
	my $fi		= $self->fi;
	
	my $calendar = {};
	my ($year, $month, $day ) = $inici =~ /(\d+)-(\d+)-(\d+)/;
	my $dt = DateTime->new( year => $year, month => $month, day => $day);
	my $inici_cal = $dt->epoch;
	($year, $month, $day ) = $fi =~ /(\d+)-(\d+)-(\d+)/;
	my $fi_cal = DateTime->new( year => $year, month => $month, day => $day)->epoch;

	# Crear Calendari {{{
	while ( $inici_cal < $fi_cal ) {
		my ( $year, $month ) = ( $dt->year, $dt->month); 
	 	my $cal = HTML::CalendarMonthSimple->new('month' => $month, 'year' => $year);
	 	$cal->weekendcellclass('calendar-weekend');
	 	$cal->tableclass('calendar-table');
		$cal->weekstartsonmonday(1);
		$cal->weekdays('Dilluns','Dimarts','Dimecres','Dijous','Divendres');
	 	$cal->saturday('Dissabte');
	 	$cal->sunday('Diumenge');
	 	$cal->border(1);
	 	my $year_month = $dt->year . sprintf("%02d",$dt->month);
	 	$calendar->{$year_month} = $cal;
	 	$dt->add( months => 1);
	 	$inici_cal = $dt->epoch;
	}

	# Afegir Festes
	_definir_festa( $self->i_nadal, $self->f_nadal, $calendar);
	_definir_festa( $self->i_santa, $self->f_santa, $calendar);

	return $calendar;
};
# }}}

# Això és una subrutina interna que defineix les festes{{{
sub _definir_festa {
	my ($inici, $fi, $calendar) = @_;

	my ($year, $month, $day ) = $inici =~ /(\d+)-(\d+)-(\d+)/;
	my $inici_dt = DateTime->new( year => $year, month => $month, day => $day);
	my $inici_date = $inici_dt->epoch;

	($year, $month, $day ) = $fi =~ /(\d+)-(\d+)-(\d+)/;
	my $fi_date	  = DateTime->new( year => $year, month => $month, day => $day)->epoch;

	while ( $inici_date <= $fi_date ) {
		my ( $year, $month, $day ) = ( $inici_dt->year, $inici_dt->month, $inici_dt->day); 
		my $year_month = $year . sprintf("%02d",$month);
		$calendar->{$year_month}->datecellclass($day, 'calendar-cell-festa');
		$inici_dt->add( days => 1);
		$inici_date = $inici_dt->epoch;
	}
}
# }}}

sub definir_sessio_admin {
	my $self = shift;
	my ($sessio, $calendar) = ($self->sessio, $self->calendar);
	my ($date_num, $day, $contingut_sessio, $festa, $year_month) = 
		($sessio->date_num, $sessio->sessio_date->{'day'}, $sessio->contingut_sessio, $sessio->festa, $sessio->year_month);

 $calendar->{$year_month}->addcontent($day, "$contingut_sessio<br>");
 $calendar->{$year_month}->setdatehref( $day, "/admin/afegir_sessio/$date_num" );
 $calendar->{$year_month}->datecellclass($day, 'calendar-cell-festa') if $festa;

}

sub definir_sessio_public {
	my $self = shift;
	my ($sessio, $calendar) = ($self->sessio, $self->calendar);
	my ($date_num, $day, $contingut_sessio, $festa, $year_month) = 
		($sessio->date_num, $sessio->sessio_date->{'day'}, $sessio->contingut_sessio, $sessio->festa, $sessio->year_month);

 $calendar->{$year_month}->addcontent($day, "$contingut_sessio<br>");
 $calendar->{$year_month}->datecellclass($day, 'calendar-cell-festa') if $festa;

}


1;
