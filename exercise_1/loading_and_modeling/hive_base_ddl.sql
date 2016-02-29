DROP TABLE `measures`;
CREATE EXTERNAL TABLE `measures`(
  `measurename` string, 
  `measureid` string, 
  `measurestartquarter` string, 
  `measurestartdate` string, --timestamp 
  `measureendquarter` string, 
  `measureenddate` string) --timestamp
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES(
  "separatorChar" = ',',
  "quoteChar" = '"',
  "escapeChar" = '\\'
  )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/raw/measures';


DROP TABLE `hospitals`;
CREATE EXTERNAL TABLE `hospitals`(
  `providerid` string, 
  `hospitalname` string, 
  `address` string, 
  `city` string, 
  `state` string, 
  `zipcode` string, 
  `countyname` string, 
  `phonenumber` string, 
  `hospitaltype` string, 
  `hospitalownership` string, 
  `emergencyservices` string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES(
  "separatorChar" = ',',
  "quoteChar" = '"',
  "escapeChar" = '\\'
  )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/raw/hospitals';


DROP TABLE `survey_responses`;
CREATE EXTERNAL TABLE `survey_responses`(
  `providernumber` string, 
  `hospitalname` string, 
  `address` string, 
  `city` string, 
  `state` string, 
  `zipcode` string, 
  `countyname` string, 
  `communicationwithnursesachievementpoints` string, 
  `communicationwithnursesimprovementpoints` string, 
  `communicationwithnursesdimensionscore` string, 
  `communicationwithdoctorsachievementpoints` string, 
  `communicationwithdoctorsimprovementpoints` string, 
  `communicationwithdoctorsdimensionscore` string, 
  `responsivenessofhospitalstaffachievementpoints` string, 
  `responsivenessofhospitalstaffimprovementpoints` string, 
  `responsivenessofhospitalstaffdimensionscore` string, 
  `painmanagementachievementpoints` string, 
  `painmanagementimprovementpoints` string, 
  `painmanagementdimensionscore` string, 
  `communicationaboutmedicinesachievementpoints` string, 
  `communicationaboutmedicinesimprovementpoints` string, 
  `communicationaboutmedicinesdimensionscore` string, 
  `cleanlinessandquietnessofhospitalenvironmentachievementpoints` string, 
  `cleanlinessandquietnessofhospitalenvironmentimprovementpoints` string, 
  `cleanlinessandquietnessofhospitalenvironmentdimensionscore` string, 
  `dischargeinformationachievementpoints` string, 
  `dischargeinformationimprovementpoints` string, 
  `dischargeinformationdimensionscore` string, 
  `overallratingofhospitalachievementpoints` string, 
  `overallratingofhospitalimprovementpoints` string, 
  `overallratingofhospitaldimensionscore` string, 
  `hcahpsbasescore` string,  --tinyint 
  `hcahpsconsistencyscore` string)  --tinyint
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES(
  "separatorChar" = ',',
  "quoteChar" = '"',
  "escapeChar" = '\\'
  )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/raw/survey_responses';


DROP TABLE `imaging_procedures`;
CREATE EXTERNAL TABLE `imaging_procedures`(
  `providerid` string, 
  `hospitalname` string, 
  `address` string, 
  `city` string, 
  `state` string, 
  `zipcode` string, 
  `countyname` string, 
  `phonenumber` string, 
  `measureid` string, 
  `measurename` string, 
  `score` string,  --float 
  `footnote` string, 
  `measurestartdate` string, --timestamp 
  `measureenddate` string) --timestamp
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
  "separatorChar" = ',',
  "quoteChar" = '"',
  "escapeChar" = '\\'
  )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/raw/imaging_procedures';



DROP TABLE `general_procedures`;
CREATE EXTERNAL TABLE `general_procedures`(
  `providerid` string, 
  `hospitalname` string, 
  `address` string, 
  `city` string, 
  `state` string, 
  `zipcode` string, 
  `countyname` string, 
  `phonenumber` string, 
  `condition` string, 
  `measureid` string, 
  `measurename` string, 
  `score` string,  --tinyint 
  `sample` string,  --smallint 
  `footnote` string, 
  `measurestartdate` string, --timestamp 
  `measureenddate` string) --timestamp
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
  "separatorChar" = ',',
  "quoteChar" = '"',
  "escapeChar" = '\\'
  )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/raw/general_procedures';


