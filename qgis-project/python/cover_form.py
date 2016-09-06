#!/usr/bin/env python
# -*- coding: utf-8 -*-

from PyQt4.QtGui import QTabWidget, QComboBox


def cover_ws_type_changed(form, feature, layer):
	tabs = form.findChild(QTabWidget)
	ws_type_selector = form.findChild(QComboBox, 'ws_type')

	ws_type = ws_type_selector.property('EWV2Wrapper').value()

	disabledtabs = [u'Ouvrage special', 'Exutoire', 'Installation d\'infiltration', 'Couvercle']

	if 'manhole' == ws_type:
		disabledtabs.remove('Couvercle')
	elif 'special_structure' == ws_type:
		disabledtabs.remove('Ouvrage spécial')
	elif 'discharge_point' == ws_type:
		disabledtabs.remove('Exutoire')
	elif 'infiltration_installation' == ws_type:
		disabledtabs.remove('Installation d''infiltration')

	for tabidx in range(tabs.count()):
		if tabs.tabText(tabidx) in disabledtabs:
			tabs.setTabEnabled(tabidx, False)
		else:
			tabs.setTabEnabled(tabidx, True)

	# Needs to be done after every change as it triggers the recalculation of the tab offsets
	tabs.setStyleSheet('QTabBar::tab:disabled { width: 0; height: 0; margin: 0; padding: 0; border: none; }')


def vw_cover_open(form, layer, feature):
	ws_type_selector = form.findChild(QComboBox, 'ws_type')
	ws_type_selector.currentIndexChanged.connect(
		lambda: cover_ws_type_changed(form, feature, layer)
	)

	cover_ws_type_changed(form, feature, layer)
