mkdir -p refined_files

tail -n +2 Hospital\ General\ Information.csv > refined_files/hospitals.csv
tail -n +2 Measure\ Dates.csv > refined_files/measures.csv
tail -n +2 hvbp_hcahps_05_28_2015.csv> refined_files/survey_responses.csv
tail -n +2 Outpatient\ Imaging\ Efficiency\ -\ Hospital.csv > refined_files/imaging_procedures.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ Hospital.csv > refined_files/general_procedures.csv

hdfs dfs -mkdir -p /user/w205/hospital_compare/raw
hdfs dfs -mkdir -p /user/w205/hospital_compare/raw/general_procedures
hdfs dfs -mkdir -p /user/w205/hospital_compare/raw/measures
hdfs dfs -mkdir -p /user/w205/hospital_compare/raw/survey_responses
hdfs dfs -mkdir -p /user/w205/hospital_compare/raw/hospitals
hdfs dfs -mkdir -p /user/w205/hospital_compare/raw/imaging_procedures

hdfs dfs -put -f ./refined_files/general_procedures.csv /user/w205/hospital_compare/raw/general_procedures/.
hdfs dfs -put -f ./refined_files/measures.csv /user/w205/hospital_compare/raw/measures/.
hdfs dfs -put -f ./refined_files/survey_responses.csv /user/w205/hospital_compare/raw/survey_responses/.
hdfs dfs -put -f ./refined_files/hospitals.csv /user/w205/hospital_compare/raw/hospitals/.
hdfs dfs -put -f ./refined_files/imaging_procedures.csv /user/w205/hospital_compare/raw/imaging_procedures/.

