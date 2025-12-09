# 📌 Análisis Exploratorio y Visualización del Desempeño ICFES (EVTD)

> ⚠️ Estado: **EN DESARROLLO** — Versión académica

Proyecto que realiza el análisis exploratorio de datos (EDA) y visualización sobre el dataset ICFES (icfes_20201.csv). Incluye limpieza y filtrado de datos, análisis univariado y bivariado, estudio de correlaciones y generación de reportes en HTML/PDF para apoyar la interpretación del desempeño académico.

---

## 👥 Autores

- SARA CAMILA APONTE TORRES → [sara.aponte-t@mail.escuelaing.edu.co](mailto:sara.aponte-t@mail.escuelaing.edu.co)  
- JUAN ESTEBAN ROA BENITO → [juan.roa-b@mail.escuelaing.edu.co](mailto:juan.roa-b@mail.escuelaing.edu.co)  
- [JUAN SEBASTIÁN GUAYAZÁN CLAVIJO](https://github.com/JuanGuayazanC) → [juan.guayazan-c@mail.escuelaing.edu.co](mailto:juan.guayazan-c@mail.escuelaing.edu.co)  

Aprendizaje estadístico 2 (MATE APE2-1 LEC (1682))      
Coordinación Ingeniería Estadística     
Ingeniería Estadística     
Escuela Colombiana de Ingeniería Julio Garavito     
2025-2 

---

## 🧠 Índice

- 📌 [Nombre del Proyecto](#-análisis-exploratorio-y-visualización-del-desempeño-icfes-evtd)
- 👥 [Autores](#-autores)
- 🚀 [Características](#-características)
- ⚙️ [Tecnologías](#️-tecnologías)
- 📦 [Instalación y Requisitos](#-instalación-y-requisitos)
- ▶️ [Uso / Cómo reproducir los análisis](#-uso--cómo-reproducir-los-análisis)
- 🧪 [Pruebas / Reproducibilidad](#-pruebas--reproducibilidad)
- 📁 [Estructura del Proyecto](#-estructura-del-proyecto)
- 📌 [TODOs / Funcionalidades Futuras](#-todos--funcionalidades-futuras)
- 📊 [Estadísticas del Repositorio](#-estadísticas-del-repositorio)
- 📄 [Licencia](#-licencia)

---

## 🚀 Características

- Limpieza e importación reproducible del dataset ICFES (icfes_20201.csv).  
- Análisis univariado y bivariado (RMarkdown + HTML).  
- Estudio de correlaciones entre variables de interés.  
- Generación de reportes reproducibles (HTML/PDF).  
- Scripts reutilizables para filtrado y visualización (R).

---

## ⚙️ Tecnologías

- Lenguaje principal: R (RMarkdown para los reportes)
- Entorno recomendado: RStudio / R >= 4.0
- Paquetes (no exhaustivo): tidyverse (dplyr, ggplot2, readr), rmarkdown, knitr, dataMaid
- Archivos de reporte: .Rmd y .html

---

## 📦 Instalación y Requisitos

### Clonar el repositorio
```bash
git clone https://github.com/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD.git
cd Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD
```

### Requisitos
* R >= 4.0
* RStudio (recomendado)
* Espacio en disco suficiente para los archivos HTML/PDF y el CSV (~13 MB para icfes_20201.csv)

### Instalar paquetes R recomendados
En la consola de R o RStudio:
```r
install.packages(c("tidyverse","rmarkdown","knitr","dataMaid","readr"))
```

---

## ▶️ Uso / Cómo reproducir los análisis

Opciones recomendadas:

1. Abrir el proyecto en RStudio usando `Proyecto-EVTD.Rproj`.
2. Correr el script de importación para cargar y transformar los datos:
   - Ejecutar `importacionDataset.R` (contiene la lectura de icfes_20201.csv y pasos iniciales).
3. Para regenerar reportes RMarkdown:
```r
# Desde la carpeta raíz del repo
rmarkdown::render("AnalisisUnivariado.Rmd")
rmarkdown::render("AnalisisUnivariadoInteres.Rmd")
rmarkdown::render("AnalisisBivariadoInteres.Rmd")
rmarkdown::render("Correlación.Rmd")
```
4. Alternativamente, abrir los archivos HTML ya generados en el navegador:
   - AnalisisUnivariado.html
   - AnalisisUnivariadoInteres.html
   - AnalisisBivariadoInteres.html
   - Correlación.html
   - report.html

Notas:
- Si modifica los scripts, vuelva a renderizar los .Rmd para actualizar los reportes.
- Los scripts auxiliares (filtrarDatos.R, graficos.R, reportes.R) contienen funciones reutilizables para filtrado y visualización.

---

## 🧪 Pruebas / Reproducibilidad

Actualmente no hay tests automatizados en el repo. Para reproducir manualmente:
- Asegúrese de instalar los paquetes listados.
- Ejecutar los scripts de importación y luego renderizar los RMarkdown.
- Para producir la versión PDF del dataMaid: abrir `dataMaid_icfes_20201.Rmd` y renderizarlo a PDF/HTML (requiere LaTeX para PDF).

---

## 📁 Estructura del Proyecto

Raíz del repositorio (resumen):

```bash
📦 Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD
 ┣ 📜 icfes_20201.csv                 # Dataset principal (~12.6 MB)
 ┣ 📜 Proyecto-EVTD.Rproj             # Proyecto RStudio
 ┣ 📜 importacionDataset.R            # Script de carga y preprocesamiento
 ┣ 📜 filtrarDatos.R                  # Funciones para filtrar el dataset
 ┣ 📜 graficos.R                      # Funciones/ejemplos de visualización
 ┣ 📜 reportes.R                      # Utilidades para generar reportes
 ┣ 📜 report.html                     # Reporte principal en HTML
 ┣ 📜 AnalisisUnivariado.Rmd          # Análisis univariado (RMarkdown)
 ┣ 📜 AnalisisUnivariado.html
 ┣ 📜 AnalisisUnivariadoInteres.Rmd
 ┣ 📜 AnalisisUnivariadoInteres.html
 ┣ 📜 AnalisisBivariadoInteres.Rmd
 ┣ 📜 Correlación.Rmd
 ┣ 📜 Correlación.html
 ┣ 📜 dataMaid_icfes_20201.Rmd        # Reporte dataMaid (análisis de calidad)
 ┣ 📜 dataMaid_icfes_20201.pdf
 ┗ 📜 README.md
```

Breve descripción de archivos clave:
- icfes_20201.csv: dataset crudo utilizado para todos los análisis.
- importacionDataset.R: lectura y transformaciones iniciales.
- *.Rmd / *.html: notebooks & reportes con análisis y visualizaciones.
- dataMaid_icfes_20201.*: reporte de calidad / descripción automática del dataset.

---

## 📌 TODOs / Funcionalidades Futuras

* [ ] Añadir un archivo LICENSE (actualmente no hay licencia explícita).
* [ ] Crear un entorno reproducible (renv / Docker).
* [ ] Añadir tests automatizados y validación de pipelines.
* [ ] Implementar un dashboard interactivo (Shiny) para explorar resultados.
* [ ] Documentar funciones en los scripts (roxygen2 o similar).
* [ ] Optimizar y documentar pasos de preprocesamiento para variables categóricas/missing.

---

## 📊 Estadísticas del Repositorio

![Lenguaje principal](https://img.shields.io/github/languages/top/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD?style=flat-square)
![Tamaño del repositorio](https://img.shields.io/github/repo-size/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD?style=flat-square)
![Stars](https://img.shields.io/github/stars/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD?style=flat-square)
![Forks](https://img.shields.io/github/forks/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD?style=flat-square)
![Issues abiertas](https://img.shields.io/github/issues/JuanGuayazanC/Analisis-Exploratorio-y-Visualizacion-del-Desempeno-ICFES-EVTD?style=flat-square)

---

## 📄 Licencia

Actualmente no se encontró un archivo LICENSE en el repositorio. El contenido se distribuye con fines académicos y educativos según comunicado de los autores. Si desea usar o redistribuir el material, por favor contacte a los autores para acordar términos o añadir una licencia explícita al repositorio.
