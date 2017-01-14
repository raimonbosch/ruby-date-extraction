#!/bin/env ruby
# encoding: utf-8

require 'ext/htmlentities'

class QueryEncoder

  @@HTML_ENTITIES = HTMLEntities.new

  @@ACCENTS = { 
    ['á','à','â','ä','ã','Ã','Ä','Â','À', "\303\200", "\303\201", "\303\240", "\303\241"] => 'a',
    ['é','è','ê','ë','Ë','É','È','Ê', "\303\210", "\303\211", "\303\251", "\303\250"] => 'e',
    ['í','ì','î','ï','I','Î','Ì', "\303\215", "\303\255"] => 'i',
    ['ó','ò','ô','ö','õ','Õ','Ö','Ô','Ò', "\303\222", "\303\223", "\303\262", "\303\263"] => 'o',
    ['ú','ù','û','ü','U','Û','Ù', "\303\232", "\303\272"] => 'u',
    ['ñ', "\303\221", "\303\261"] => 'n',
    ['ç', "\\u00e7", "\303\207", "\303\267"] => 'c',
    ['œ'] => 'oe',
    ['ß'] => 'ss'
  }

  def self.arregla_caracteres_raros(str)
    #input_str = str
    replace = ["&nbsp;", "&amp;","¡", "!", "\\", "/", "\"", "#", "$", "%",
               "'", "(", ")", "*", "+", ",", "-", "/", ":", ";", ",", "<",
               "=", ">", "¿", "?", "@", "^", "_", "´", "`", "Ž", "{", "|",
               "}", "~", "[", "]", "¨", "”", "“", "’", "&", ".",
               " " #%C2%A0 (special space)
              ]

    replace.each { |w| str.gsub!(w, " ")  }

    #pasamos a minusculas
    str.downcase!

    str.gsub!(/[ ]+/, " ") #TODO: Implement collapse_spaces
    str.strip!

    str
  end

  def self.clean_query(query)
    query = html_entities.decode(query)
    query = QueryEncoder.arregla_caracteres_raros(query)
    QueryEncoder.rmvacc(query.downcase)
  end

  def self.rmvacc( str )
    if str.nil? || str == ""
      return ""
    end

    accents.each do |ac,rep|
      ac.each do |s|
        str.gsub!(s, rep)
      end
    end
    
    return str
  end

  def self.html_entities
    @@HTML_ENTITIES
  end

  def self.accents
    @@ACCENTS
  end

end