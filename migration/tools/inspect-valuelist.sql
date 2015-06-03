select distinct id_funktion_hierarch, value
from sa.aw_haltung a
left join sa.aw_haltung_fkt_hierar_tbd b on a.id_funktion_hierarch = b.id