-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/puja/input.txt' AS (line:chararray);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words by word(MAP)
grpd = GROUP words BY word;
-- Count the number of words
totalCount = FOREACH grpd GENERATE $0, COUNT($1);
-- Remove the old results
rmf hdfs:///user/puja/PigOutput1;
-- Store the result in HDFS
STORE totalCount INTO 'hdfs:///user/puja/PigOutput1';