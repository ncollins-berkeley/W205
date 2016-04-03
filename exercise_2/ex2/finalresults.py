#!/usr/bin/python

#finalresults.py
#This script gets a word as an argument and returns the 
#total number of word occurrences in the stream.

# example:
# $ python finalresults.py hello
# Total number of occurences of "hello": 10

#Running finalresults.py without an argument returns all the words in the 
#stream and their total count of occurrences, sorted alphabetically in an 
#ascending order, one word per line. For example:

# example:
# $ python finalresults.py
# $ (<word1>, 2), (<word2>, 8), (<word3>, 6), (<word4>, 1), ...

import sys
import psycopg2

if len(sys.argv) > 2: 
  print "No more than one argument is allowed.  Please try again."
  sys.exit()

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()



if len(sys.argv)==2:
       
        #protect from SQL injection by performing a replacment of single quotes

	querystr = "SELECT word, count from Tweetwordcount where word = " + "'" + sys.argv[1].replace("'","''").strip() + "'"
	# print querystr

	cur.execute(querystr)
	records = cur.fetchall()
	numoccurs = 0
	if len(records) <> 0:
		numoccurs = records[0][1]

	resultstring = "Total number of occurences of \"" + sys.argv[1].strip() + "\": " + str(numoccurs)   	

	print resultstring
	conn.commit()

else:

	cur.execute("SELECT word, count from Tweetwordcount order by word asc")
	records = cur.fetchall()
	for rec in records:
		resultstring = "(\""+rec[0]+"\", "+str(rec[1])+")"
   		print resultstring
	conn.commit()

conn.close()
