from __future__ import absolute_import, print_function, unicode_literals


from collections import Counter
from streamparse.bolt import Bolt
import psycopg2


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
     #   self.counts = Counter()
     #  self.redis = StrictRedis()
	self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
        self.cur = self.conn.cursor()

    def process(self, tup):

        word = tup.values[0]
	
	# protect from sql injection and prepare word for use in quoted string
	sqlstrword = word.replace("'","''").strip()

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.


	#Select
	self.cur.execute("SELECT word from Tweetwordcount where word = '"+
                    sqlstrword +"'")
	records = self.cur.fetchall()
	self.conn.commit()

	if len(records)==0:

		#Insert
		self.cur.execute("INSERT INTO Tweetwordcount (word,count) \
      		VALUES ('"+sqlstrword+"', 1)");
		self.conn.commit()
		#conn.close()

	else:

	 	#Update
                self.cur.execute("UPDATE Tweetwordcount SET count = count + 1 \
                WHERE word = '"+sqlstrword+"'");
                self.conn.commit()
                #conn.close()

        ## Increment the local count
        #self.counts[word] += 1
        #self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        #self.log('%s: %d' % (word, self.counts[word]))


        self.emit([word, 1])
        self.log('%s: %d' % (word, 1))
