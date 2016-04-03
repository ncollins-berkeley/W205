#!/usr/bin/python


#histogram.py

#This script gets two integers k1,k2 and returns all the words that their 
#total number of occurrences in the stream is more or equal than k1 and 
#less or equal than k2. For example:

# $ python histogram.py 3,8 
# $ <word2>: 8
#   <word3>: 6 
#   <word1>: 3

import sys
import psycopg2

if len(sys.argv) <> 2: 
  print "One argument is required.  The argument must be two integers separated by a comma.  Please try again."
  sys.exit()

arguments = sys.argv[1].split(',')

if len(arguments) <> 2:
  print "The argument must be two integers separated by a comma.  Please try again."
  sys.exit()

try:
	arg1 = int(arguments[0])
	arg2 = int(arguments[1])
except:
	print "Please make sure the two values provided are integer values."
	sys.exit()

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

       
querystr = "SELECT word, count from Tweetwordcount where count between " + str(arg1) + " and " + str(arg2) + " order by word"


#print querystr

cur.execute(querystr)
records = cur.fetchall()
for rec in records:
	resultstring = "\""+rec[0]+"\": "+str(rec[1])
	print resultstring
conn.commit()

conn.close()
