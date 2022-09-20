# Demanda_energetica_departamento_del_Vichada-Colombia_2019-2039
Estimación del consumo potencial de energía eléctrica mediante el uso de un modelo matemático para el departamento del vichada durante el periodo 2019-2039.

# INTRODUCCIÓN

El Plan de Energización Rural Sostenibles de la Orinoquia (PERS Orinoquía) es un plan que nace de reconocimiento de la problemática asociada a la falta de
expansión de la cobertura de la energía eléctrica en las zonas rurales apartadas y que, a partir de los elementos regionales más relevantes en términos de
condiciones socioeconómicas, de recurso, de oferta y demanda energética, busca identificar las fuentes locales aprovechables para el suministro de energía
mediante la estructuración y elaboración de proyectos integrales y sostenibles en el corto plazo y en un horizonte de mínimo 15 años, que además de generar
energía, apoyen el crecimiento y el desarrollo de las comunidades rurales de las regiones objetivos.

PERS Orinoquía será la formulación de una política pública energética que vaya en sintonía con el entorno y la visión de desarrollo regional con emprendimientos y productividad local, a partir de la generación de energía eléctrica que apoye el crecimiento y el mejoramiento de las condiciones de las comunidades locales en los departamentos de Arauca, Casanare, Meta y Vichada. 
Con este trabajo se busca aportar a PERS Orinoquía puesto que la estimación del consumo de energía eléctrica entre los años 2019 y 2039 permitirá que se
establezca, entre la política pública, la formulación de proyectos de energización en donde se haga uso de energías alternativas a partir de la realidad del
departamento del Vichada. Estos proyectos permitirán que la población del departamento del Vichada tenga acceso a los fondos de apoyo financiero, que
brinda el gobierno.


# METODOLOGÍA

- ENFOQUE METODOLÓGICO

El trabajo se sustentó bajo un enfoque cuantitativo, pues buscó establecer el tipo de correlación entre distintas variables, tales como, la población total, el número de hogares que tienen acceso a energía eléctrica y el tiempo en el que tienen acceso a esa energía con la variable consumo de energía eléctrica en el periodo 2005-2018.

- ESTRATEGIA DE INVESTIGACIÓ

Se usó el estudio de caso como estrategia de investigación. Se analizó la información existente sobre la población y el consumo de energía eléctrica del
departamento de Vichada en las bases de datos del DANE y del Sistema único de información de servicios públicos (SUI), junto con el consumo de energía eléctrica del 2018 del Departamento de Vichada establecido por PERS Orinoquía.

El departamento de Vichada está situado en el extremo oriental de Colombia, localizado entre los 06º19’34’’ y 02º53’58’’ de latitud norte y 67º25’1’’ y 71º7’10’’ de longitud oeste. Cuenta con una superficie de 98.970 km2 lo que representa el 8.6 % del territorio nacional. Limita por el Norte con el río Meta que lo separa de los departamentos de Casanare, Arauca y la República de Venezuela; por el Este con el río Orinoco que lo separa de la República de Venezuela, por el Sur con el río Guaviare que lo separa de los departamentos de Guainía y Guaviare y por el Oeste con los departamentos de Meta y Casanare. Este departamento se encuentra conformado por los municipios de Cumaribo al sur del departamento, La primavera al norte, Puerto Carreño al noreste y Santa Rosalía al norte.

El alcance de este estudio fue correlacional ya que se tuvo como hipótesis las existencias de correlación entre cada una de las siguientes variables a saber, la población total, el número de hogares que tienen acceso a energía eléctrica y el tiempo con el que cuentan con energía eléctrica estos hogares con la variable consumo de energía eléctrica, pero se buscó establecer qué tipo de correlación existe entre estas variable ya establecida con el consumo de energía eléctrica, si esta responde a un modelo lineal, exponencial, logístico, entre otros o una combinación de algunos de ellos.

Como herramientas estadísticas se utilizó los modelos de regresión, como el lineal simple, el múltiple, el exponencial y el poblacional logístico, el ANOVA, el cálculo del coeficiente de determinación y determinación ajustado y el análisis de residuales.

Como herramienta tecnológica se usó el software de uso libre R Project. Se creó un script (ver anexos) en un archivo “.R” para cada modelo de regresión y sus
respectivos ANOVA, cálculo del coeficiente de determinación o determinación ajustado, según fue el caso y el análisis de residuales.

- TÉCNICAS DE RECOLECCIÓN DE INFORMACIÓN.

Para establecer qué tipo de correlación existente entre la población total, se recopiló información de documentación de mediciones del DANE, SUI y PERS
Orinoquia de la siguientes forma, la información correspondiente al número de 36 habitantes, la cantidad de hogares o personas, en promedio, por vivienda en la base de datos del DANE, el número de viviendas que tienen acceso a energía eléctrica, el tiempo en el que tienen acceso a esa energía y el consumo de energía eléctrica en las bases de datos del SUI, junto con el consumo de energía eléctrica del 2018 del Departamento de Vichada establecido por PERS Orinoquía.

- ANÁLISIS Y SISTEMATIZACIÓN

Luego de tener la información recopilada, se creó y aplicó un script de R Project, por cada modelo a los datos de la población de los censos 1985, 1993, 2005 y 2018 y con estos modelos ajustados se estimó la población correspondiente a cada uno de los cuatro censos ya nombrados. Estos valores estimados se usaron
realizar el análisis de varianza (ANOVA), el cálculo del coeficiente de determinación o determinación ajustado y el análisis de residuales. A partir de los
resultados de estos análisis se determinó el modelo que mejor se ajusta a los datos de los censos del DANE. Con el modelo seleccionado se estimó la población
del departamento en el periodo 2003-2016.

Teniendo la información completa de cada una de las variables, se creó un script de R Project por cada modelo. Con los modelos de regresión se estimó los
consumos de energía eléctrica en el periodo del 2003 al 2018 en el departamento. Estos valores estimados se usaron para los análisis de varianza (ANOVA), del
coeficiente de determinación o determinación ajustado y de residuales. Estos análisis se utilizaron para determinar el modelo que mejor se ajusta a los datos del Sistema único de información (SUI).

Luego se determinó el modelo más adecuado y se procedió a estimar los consumos de energía eléctrica para tres escenarios futuros (pesimista, optimista y
transicional), para el periodo 2019-2039 del departamento del Vichada. El escenario pesimista corresponde al consumo que tendría el departamento si se
mantiene estable el porcentaje de la población que tiene acceso al servicio de energía eléctrica. El escenario optimista corresponde al consumo que tendría el departamento si el 100 % de la población llega a tener acceso al servicio de energía en los primeros años del periodo 2019-2039. El escenario transicional
corresponde al consumo si el porcentaje de la población que tiene acceso al servicio de energía eléctrica va incrementando gradualmente hasta llegar al 100 %
para el año 2039.
