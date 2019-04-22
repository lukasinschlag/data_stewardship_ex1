
# Data stewardship: FAIR Data Science

**Experiment Overview**

This experiment is used to show the correlation between the yearly climate values and the used energy resources, in the years 1992-2016. The idea is that the climate has an impact on the amount of energy needed. The input data for this experiments is taken for the climate values from data.gv [1] and for the energy resources from Statistik Austria [2].

**Run the experiment**

To reprocude this experiment the following requirements have to be fullfilled:

 -  RStudio Desktop 1.2.1335
 -  RStudio requires R 3.0.1+

To run the experiment just run the `experiment.R` file in RStudio.
Make sure that the working directory is properly configured, by setting in the RStudio menu:

    Session\Set working directory\To source file location

Afterwards, the code can be executed, which transforms the input data, genereates the output data and plots the graphs automatically.


**Input data credits**

Climate data
> [https://www.data.gv.at/katalog/dataset/e6d471ec-f983-4e9a-b435-957cfc1bb48c](https://www.data.gv.at/katalog/dataset/e6d471ec-f983-4e9a-b435-957cfc1bb48c)  
> Creative Commons Namensnennung 4.0 International  
> Datenquelle: Stadt Wien – https://data.wien.gv.at  

Energy resources

> [http://statcube.at/statcube/opendatabase?id=deebilanz](http://statcube.at/statcube/opendatabase?id=deebilanz)  
> STATcube - Statistische Datenbank von STATISTIK AUSTRIA  
> [http://statcube.at/statistik.at/ext/statcube/jsf/terms.xhtml](http://statcube.at/statistik.at/ext/statcube/jsf/terms.xhtml)  


<meta name='keywords' content='fair data science, austria, climate data, energy resources'>
