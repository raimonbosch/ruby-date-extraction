# ruby-date-extraction

Simple solution to convert raw strings into dates. 

The code is using regular grammars to extract the dates in a efficent way.

    require 'date_extraction'
    dtparser = DateExtraction.new()
    date = dtparser.parse_date "Monday 27 October, 2011 11:30h"

    p date
    //It will print: 2011-10-27 11:30:00

