-- load input files into HDFS
salestable=LOAD 'hdfs:///user/puja/sales.csv' USING PigStorage (',') AS
(Product:chararray, Price:chararray, Payment_type:chararray, Name:chararray,
City:chararray, State:chararray, Country:chararray);
GroupByCountry=GROUP salestable by Country;
CountByCountry= FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':',(chararray)COUNT($1)));
STORE CountByCountry INTO 'hdfs:///user/puja/PigOutput2' USING PigStorage('\t');