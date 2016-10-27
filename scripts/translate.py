#!/usr/bin/env python
# -*- coding: utf-8 -*-


import psycopg2, psycopg2.extras


pg_service = "pg_qgep"


layers = {
    'vw_qgep_wastewater_structure': 
        {'name': 'chambre',
         'tabs': {'General': u'Général',
                  'Cover': 'Couvercle',
                  'Wastewater Structure': 'Ouvrage',
                  'Manhole': 'Chambre',
                  'Special Structure': u'Ouvrage spécial',
                  'Discharge Point': 'Exutoir',
                  'Infiltration Installation': 'Installation d''infiltration',
                  'Wastewater Node': 'Noeud',
                  'Covers': 'Couvercles',
                  'Structure Parts': u'Elément d''ouvrage',
                  'Maintenance': 'Maintenance',
                  'Wastewater Nodes': 'Noeuds',
                  'Files': 'Fichiers'},
         'additional_translations': {'manhole_function': 'fonction'}
        },
    'vw_qgep_reach':
        {'name': u'tronçon',
         'tabs': {'General': 'Général',
                  'Reach': 'Tronçon',
                  'Wastewater Networkelement': u'Element du réseau',
                  'Channel': 'Canalisation',
                  'Wastewater Structure': 'Ouvrage',
                  'Reach Points': 'Point de tronçon',
                  'Maintenance': 'Maintenance'},
         'additional_translations': {}
        }
    }



# connect to db
conn = psycopg2.connect("service={0}".format(pg_service))
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


def get_field_translation(field):
	cur.execute("SELECT field_name_fr FROM qgep.is_dictionary_od_field WHERE field_name = '{0}' LIMIT 1".format(field))
	trans = cur.fetchone()
	if trans is None:
		return None
	else:
		return trans[0].lower()

def get_table_translation(table):
	cur.execute("SELECT name_fr FROM qgep.is_dictionary_od_table WHERE tablename LIKE '%{0}' LIMIT 1".format(table))
	trans = cur.fetchone()
	if trans is None:
		return None
	else:
		return trans[0].lower()


for layer in QgsMapLayerRegistry.instance().mapLayers().values():
	if layer.id() in layers.keys():
		layer.setName(layers[layer.id()]['name'])
		tabs = layer.editFormConfig().tabs()
		# tabs
		for tab in layer.editFormConfig().tabs():
			if tab.name() in layers[layer.id()]['tabs']:
				tab.setName(layers[layer.id()]['tabs'][tab.name()])
			else:
				print("Tab {0} not translated".format(tab.name()))
		# fields
		for idx,field in enumerate(layer.fields()):
			#print(layer.name(),idx,field.name())
			# translation
			trans = get_field_translation(field.name())
			if field.name() in layers[layer.id()]['additional_translations']:
				layer.addAttributeAlias(idx, layers[layer.id()]['additional_translations'][field.name()])
			elif trans is not None:
				layer.addAttributeAlias(idx, trans)
			else:
				print("Field {0} is not translated".format(field.name()))
			
			# update value relation value
			if layer.editFormConfig().widgetType(idx) == 'ValueRelation':
				cfg = layer.editFormConfig().widgetConfig(idx)
				if cfg["Value"] == "value_en":
					cfg["Value"] = "value_fr"
					layer.editFormConfig().setWidgetConfig(idx, cfg)
			
			# value maps
			if layer.editFormConfig().widgetType(idx) == 'ValueMap':
				cfg = layer.editFormConfig().widgetConfig(idx)
				for key in cfg.keys():
					trans = get_table_translation(cfg[key])
					if trans:
						cfg[trans] = cfg[key]
						del cfg[key]
				layer.editFormConfig().setWidgetConfig(idx, cfg)
