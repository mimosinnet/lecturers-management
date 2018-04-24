package GestioMaster;
use Mojo::Base 'Mojolicious';
use GestioMaster::Obj::DB;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

	# database model availabe as $self->model {{{
  $self->helper( model => sub { 
			state $model = GestioMaster::Obj::DB->new->model;
		}
	);
	# }}}

  # Router
  my $r = $self->routes;

	# Mode Normal {{{
  $r->get('/')->to('public#inici');
  $r->get('/pub/inici')->to('public#inici');
	$r->get('/pub/moduls')->to('public#moduls');
	$r->get('/pub/carrega_docent')->to('public#carrega_docent');
  $r->get('/pub/calendari')->to('public#calendari');
	$r->get('/pub/centres')->to('public#centres');
	$r->get('/pub/modul/M5d')->to('public#tfm');
	$r->get('/pub/modul/M6')->to('public#tfm');
	$r->get('/pub/modul/:modul')->to('public#modul');
	$r->get('/pub/tfm')->to('public#tfm');
	# }}}

	# Mode Gestio {{{
	$r->get('/ges/inici')->to('ges#inici');
	$r->get('/ges/modul/M5d')->to('ges#tfm');
	$r->get('/ges/modul/M6')->to('ges#tfm');
	$r->get('/ges/modul/:modul')->to('ges#modul');
	$r->post('/ges/update_sessio')->to('ges#update_sessio');
	$r->get('/ges/update_docents')->to('ges#update_docents');
	$r->get('/ges/tfm')->to('ges#tfm');
	# }}}
	
	# Mode Admin {{{
	# -- Inici
	$r->get('/admin/inici')->to('admin#inici');
	# -- Moduls
	$r->get('/admin/moduls')->to('admin#moduls');
	$r->get('admin/set_coord')->to('admin#set_coord');
	# -- Calendari
	$r->get('/admin/calendari')->to('admin#calendari');
	$r->get('/admin/afegir_sessio/:date_num')->to('admin#afegir_sessio');
	$r->post('/admin/set_sessio')->to('admin#set_sessio');
	$r->post('/admin/update_sessio')->to('admin#update_sessio');
	$r->post('/admin/anar_sessio')->to('admin#anar_sessio');
	$r->get('/admin/borrar_sessio')->to('admin#borrar_sessio');
	# -- Centres
	$r->get('/admin/centres')->to('admin#centres');
	$r->post('/admin/centre_add')->to('admin#centre_add');
	$r->post('/admin/centre_update')->to('admin#centre_update');
	$r->get('/admin/centre_del')->to('admin#centre_del');
	# -- Modul
	$r->get('/admin/modul/M5d')->to('admin#tfm');
	$r->get('/admin/modul/M6')->to('admin#tfm');
	$r->get('/admin/modul/:modul')->to('admin#modul');
  $r->get('/admin/estud/:modul')->to('admin#estud');

	$r->get('/admin/tfm')->to('admin#tfm');
	$r->post('/admin/tfm_add')->to('admin#tfm_add');
	$r->post('/admin/tfm_update')->to('admin#tfm_update');
	$r->get('/admin/tfm_del')->to('admin#tfm_del');

	# }}}

}

1;
