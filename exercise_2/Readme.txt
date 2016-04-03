DEPENDENCIES

To run the application, you will need to install Storm (Streamparse), Python (2.7.3), and PostgreSQL (8.4.20).  Other versions of these products may still work, though they have not been tested.  Tweepy and Psycopyg python libraries are required as well.


SETUP

Place the credentials for your twitter application in the tweets.py file in the /src/spouts directory.Place the credentials for connecting to the PostgreSQL database in the wordcount.py file in the /src/bolts directory.You will need to create the tcount database in PostgreSQL, and run the create table code as shown in the psycog-sample.py file.EXECUTIONTo execute the app, you will need to call “sparse run” from the command line in the directory ex2/Tweetwordcount/.

The execution will continue until manually broken by the user or otherwise interrupted by the system.
QUERYThe python script finalresults.py takes a word as an argument and returns the number of occurrences of that word.  If no argument is provided, it will return the number of occurrences of all words in alphabetical order.The python script histogram.py takes the argument of two integers separated by a comma.  It will return the words that have a number of occurrences between those two integers (inclusively).ADDITIONAL

Please see documentation and screenshots for additional information.