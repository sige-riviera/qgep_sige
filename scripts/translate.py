#!/bin/python


import psycopg2, psycopg2.extras


pg_service = "pg_qgep"


layers = {'vw_qgep_wastewater_structure': 'chambre'}



# connect to db
conn = psycopg2.connect("service={0}".format(pg_service))
cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)


def get_field_translation(field):
	cur.execute("SELECT field_name_fr FROM qgep.is_dictionary_od_field WHERE field_name = '{0}' LIMIT 1".format(field))
	trans = cur.fetchone()
	if trans is None:
		return None
	else:
		return trans[0]


for layer in QgsMapLayerRegistry.instance().mapLayers().values():
	if layer.id() in layers.keys():
		layer.setName(layers[layer.id()])
		for idx,field in enumerate(layer.fields()):
			print(layer.name(),idx,field.name())
			# translation
			trans = get_field_translation(field.name())
			if trans is not None:
				layer.addAttributeAlias(idx, trans)
			else:
				print("Field {0} is not translated".format(field.name()))
			
			# update value relation value
			if layer.editFormConfig().widgetType(idx) == 'ValueRelation':
				cfg = layer.editFormConfig().widgetConfig(idx)
				if cfg["Value"] == "value_en":
					cfg["Value"] = "value_fr"
					layer.editFormConfig().setWidgetConfig(idx, cfg)
					print("set value relation")

		
		
		
		
