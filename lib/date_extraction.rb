#!/bin/env ruby
# encoding: utf-8

require 'base/query_encoder'
require 'base/my_out'

class DateExtraction
  attr_accessor :debug, :grammars, :numbers, :week_days, :year_months,
                :num_months, :myout, :country

  def initialize(debug = false, options = {})
    @debug = debug
    @options = options
    @myout = MyOut.new(debug);
    @country = @options[:country].nil? ? "es" : @options[:country]

    @grammars = {}
    
    @grammars["es"] = {
        "lNFYN" => ["l", "d", "F", "Y", "H"],
        "lNFYNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lFNYN" => ["l", "F", "d", "Y", "H"],
        "lFNYNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lNFY" => ["l", "d", "F", "Y"],
        "lNF" => ["l", "d", "F"],
        "NFYN" => ["d", "F", "Y", "H"],
        "NFYNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYlN" => ["d", "F", "Y", "l", "H"],
        "NFYlNN" => ["d", "F", "Y", "l", "H", "i"],
        "NFlYN" => ["d", "F", "l", "Y", "H"],
        "NFlYNN" => ["d", "F", "l", "Y", "H", "i"],
        "NFlYNNN" => ["d", "F", "l", "Y", "H", "i"],
        "NFlYNNNN" => ["d", "F", "l", "Y", "H", "i"],
        "NFNN" => ["d", "F", "H", "i"],
        "NFNNNN" => ["d", "F", "H", "i"],
        "NNN" => ["d", "m", "H"],
        "NNNN" => ["d", "m", "H", "i"],
        "NNNNN" => ["d", "m", "y", "H", "i"],
        "NNNNNN" => ["d", "m", "y", "H", "i"],
        "NNNNNNN" => ["d", "m", "y", "H", "i"],
        "lNNYNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNYNNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNYNNNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNYN" => ["l", "d", "m", "Y", "H"],
        "lNN" => ["l", "d", "m"],
        "FNFNN" => ["l", "d", "F", "H", "i"],
        "lNFNN" => ["l", "d", "F", "H", "i"],
        "lNFNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFN" => ["l", "d", "F", "H"],
        "lFNN" => ["l", "F", "d", "H"],
        "FNNN" => ["F", "d", "H", "i"],
        "lFNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNN" => ["l", "F", "d", "H", "i"],
        "YNN" => ["Y", "m", "d"],
        "NNYNN" => ["d", "m", "Y", "H", "i"],
        "NNYNNN" => ["d", "m", "Y", "H", "i"],
        "NNYNNNN" => ["d", "m", "Y", "H", "i"],
        "NNYNNNNN" => ["d", "m", "Y", "H", "i"],
        "NNYNNNNNN" => ["d", "m", "Y", "H", "i"],
        "YNNNN" => ["Y", "m", "d", "H", "i"],
        "YNNNNN" => ["Y", "m", "d", "H", "i"],
        "F" => ["F"],
        "FF" => ["F"],
        "FFF" => ["F"],
        "FFFF" => ["F"],
        "NFN" => ["d", "F", "H"],
        "NF" => ["d", "F"],
        "NNYN" => ["d", "m", "Y", "H"],
        "FNYN" => ["F", "d", "Y", "H"],
        "FNYNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNNN" => ["F", "d", "Y", "H", "i"],
        "NFNNN" => ["d", "F", "H", "i"],
        "lNNNN" => ["l", "d", "m", "H", "i"],
        "lNNNNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNNNNNN" => ["l", "d", "m", "Y", "H", "i"],
        "NNYlN" => ["d", "m", "Y", "l", "H"],
        "NNYlNN" => ["d", "m", "Y", "l", "H", "i"],
        "NNYlNNN" => ["d", "m", "Y", "l", "H", "i"],
        "NNYlNNNN" => ["d", "m", "Y", "l", "H", "i"],
        "NNlNN" => ["d", "m", "l", "H", "i"]
    }

    @grammars["us"] = {
        "lNFYN" => ["l", "d", "F", "Y", "H"],
        "lNFYNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lFNYN" => ["l", "F", "d", "Y", "H"],
        "lFNYNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lNFY" => ["l", "d", "F", "Y"],
        "lNF" => ["l", "d", "F"],
        "NFYN" => ["d", "F", "Y", "H"],
        "NFYNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNN" => ["d", "F", "Y", "H", "i"],
        "NFNN" => ["d", "F", "H", "i"],
        "NNN" => ["m", "d", "H"],
        "NNNN" => ["m", "d", "H", "i"],
        "NNNNN" => ["m", "d", "H", "i"],
        "NNNNNN" => ["m", "d", "H", "i"],
        "NNNNNNN" => ["m", "d", "H", "i"],
        "NNNNNNNN" => ["m", "d", "H", "i"],
        "lNNYNN" => ["l", "m", "d", "Y", "H", "i"],
        "lNNYN" => ["l", "m", "d", "Y", "H"],
        "lNN" => ["l", "d", "m"],
        "lNFNN" => ["l", "d", "F", "H", "i"],
        "lNFNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFN" => ["l", "d", "F", "H"],
        "FNN" => ["F", "d", "H"],
        "FNNN" => ["F", "d", "H", "i"],
        "FNNNN" => ["F", "d", "H", "i"],
        "FNNNNN" => ["F", "d", "H", "i"],
        "lFN" => ["l", "F", "d"],
        "lFNN" => ["l", "F", "d", "H"],
        "lFNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNNNN" => ["l", "F", "d", "H", "i"],
        "YNN" => ["Y", "m", "d"],
        "NNYNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNNNN" => ["m", "d", "Y", "H", "i"],
        "YNNN" => ["Y", "m", "d", "H"],
        "YNNNN" => ["Y", "m", "d", "H", "i"],
        "YNNNNN" => ["Y", "m", "d", "H", "i"],
        "F" => ["F"],
        "FF" => ["F"],
        "FFF" => ["F"],
        "FFFF" => ["F"],
        "NFN" => ["d", "F", "H"],
        "NF" => ["d", "F"],
        "NNYN" => ["m", "d", "Y", "H"],
        "FNYN" => ["F", "d", "Y", "H"],
        "FNYNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNNN" => ["F", "d", "Y", "H", "i"],
        "FYlNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FYlNNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FYlNNNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FNlN" => ["F", "d", "l", "H"],
        "FNlNN" => ["F", "d", "l", "H", "i"],
        "FNYlN" => ["F", "d", "Y", "l", "H"],
        "FNYlNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "NFNNN" => ["d", "F", "H", "i"],
        "lNNNN" => ["l", "m", "d", "H", "i"],
        "lNNNNN" => ["l", "m", "d", "Y", "H", "i"],
        "lNNNNNN" => ["l", "m", "d", "H", "i"],
        "lNNNNNNN" => ["l", "m", "d", "Y", "H", "i"],
        "NNlNN" => ["m", "d", "l", "H", "i"]
    }

    @grammars["uk"] = {
        "lNFYN" => ["l", "d", "F", "Y", "H"],
        "lNFYNN" => ["l", "d", "F", "Y", "H", "i"],
        "NFlNN" => ["d", "F", "l", "H", "i"],
        "lNFYNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lNFYNNNNNN" => ["l", "d", "F", "Y", "H", "i"],
        "lFNYN" => ["l", "F", "d", "Y", "H"],
        "lFNYNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "lFNYNNNNNN" => ["l", "F", "d", "Y", "H", "i"],
        "NlFYNN" => ["d", "l", "F", "Y", "H", "i"],
        "lNFY" => ["l", "d", "F", "Y"],
        "lNF" => ["l", "d", "F"],
        "NFYN" => ["d", "F", "Y", "H"],
        "NFYNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYNNNNNN" => ["d", "F", "Y", "H", "i"],
        "NFYlNN" => ["d", "F", "Y", "l", "H", "i"],
        "NFNN" => ["d", "F", "H", "i"],
        "NNN" => ["d", "m", "H"],
        "NNNN" => ["d", "m", "y", "H"],
        "NNNNN" => ["d", "m", "y", "H", "i"],
        "NNNNNN" => ["d", "m", "y", "H", "i"],
        "NNNNNNN" => ["d", "m", "y", "H", "i"],
        "NNNNNNNN" => ["d", "m", "y", "H", "i"],
        "lNNYNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNYN" => ["l", "d", "m", "Y", "H"],
        "lNN" => ["l", "d", "m"],
        "lNFNN" => ["l", "d", "F", "H", "i"],
        "lNFNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNN" => ["l", "d", "F", "H", "i"],
        "lNFNNNNNN" => ["l", "d", "F", "H", "i"],
        "lNFN" => ["l", "d", "F", "H"],
        "FNN" => ["F", "d", "H"],
        "FNNN" => ["F", "d", "H", "i"],
        "FNNNN" => ["F", "d", "H", "i"],
        "FNNNNN" => ["F", "d", "H", "i"],
        "lFN" => ["l", "F", "d"],
        "lFNN" => ["l", "F", "d", "H"],
        "lFNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNNN" => ["l", "F", "d", "H", "i"],
        "lFNNNNNNN" => ["l", "F", "d", "H", "i"],
        "YNN" => ["Y", "m", "d"],
        "NNYNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNNN" => ["m", "d", "Y", "H", "i"],
        "NNYNNNNNN" => ["m", "d", "Y", "H", "i"],
        "YNNN" => ["Y", "m", "d", "H"],
        "YNNNN" => ["Y", "m", "d", "H", "i"],
        "YNNNNN" => ["Y", "m", "d", "H", "i"],
        "F" => ["F"],
        "FF" => ["F"],
        "FFF" => ["F"],
        "FFFF" => ["F"],
        "NFN" => ["d", "F", "H"],
        "NF" => ["d", "F"],
        "NNYN" => ["d", "m", "Y", "H"],
        "FNYN" => ["F", "d", "Y", "H"],
        "FNYNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNN" => ["F", "d", "Y", "H", "i"],
        "FNYNNNN" => ["F", "d", "Y", "H", "i"],
        "FYlNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FYlNNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FYlNNNNN" => ["F", "Y", "l", "d", "H", "i"],
        "FNlN" => ["F", "d", "l", "H"],
        "FNlNN" => ["F", "d", "l", "H", "i"],
        "FNYlN" => ["F", "d", "Y", "l", "H"],
        "FNYlNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "FNYlNNNNNN" => ["F", "d", "Y", "l", "H", "i"],
        "NFNNN" => ["d", "F", "H", "i"],
        "lNNNN" => ["l", "d", "m", "H", "i"],
        "lNNNNN" => ["l", "d", "m", "Y", "H", "i"],
        "lNNNNNN" => ["l", "d", "m", "H", "i"],
        "lNNNNNNN" => ["l", "d", "m", "Y", "H", "i"],
        "NNlNN" => ["d", "m", "l", "H", "i"]
    }

    @grammars_nomonth = {}

    @grammars_nomonth["es"] = {
      "lNNN" => ["l", "d", "H", "i"],
      "lNNNN" => ["l", "d", "H", "i"],
      "lNNNNN" => ["l", "d", "H", "i"],
      "lNNNNNN" => ["l", "d", "H", "i"],
      "lNNNNNNN" => ["l", "d", "H", "i"],
      "lNN" => ["l", "d", "H"]
    }

    @grammars_nomonth["us"] = {
      "lNNN" => ["l", "d", "H", "i"],
      "lNNNN" => ["l", "d", "H", "i"],
      "lNNNNN" => ["l", "d", "H", "i"],
      "lNN" => ["l", "d", "H"]
    }

    @grammars_nomonth["uk"] = {
      "lNNN" => ["l", "d", "H", "i"],
      "lNNNN" => ["l", "d", "H", "i"],
      "lNNNNN" => ["l", "d", "H", "i"],
      "lNN" => ["l", "d", "H"]
    }

    @grammars_onlyday = {}

    @grammars_onlyday["es"] = {
      "l" => ["l"],
      "lN" => ["l", "H"],
      "lNN" => ["l", "H", "i"]
    }

    @grammars_onlyday["us"] = {
      "l" => ["l"],
      "lN" => ["l", "H"],
      "lNN" => ["l", "H", "i"]
    }

    @grammars_onlyday["uk"] = {
      "l" => ["l"],
      "lN" => ["l", "H"],
      "lNN" => ["l", "H", "i"],
      "lNNNN" => ["l", "H", "i"]
    }
    
    @numbers = {
        "0" => true,
        "1" => true,
        "2" => true,
        "3" => true,
        "4" => true,
        "5" => true,
        "6" => true,
        "7" => true,
        "8" => true,
        "9" => true
    }

    @week_days = {
        "en" => {
            "monday" => "monday", "mondays" => "monday",
            "tuesday" => "tuesday", "tuesdays" => "tuesday",
            "wednesday" => "wednesday", "wednesdays" => "wednesday",
            "thursday" => "thursday", "thursdays" => "thursday",
            "friday" => "friday", "fridays" => "friday",
            "saturday" => "saturday", "saturdays" => "saturday",
            "sunday" => "sunday", "sundays" => "sunday",
            "mon" => "monday", "tue" => "tuesday",
            "wed" => "wednesday", "thu" => "thursday",
            "fri" => "friday", "sat" => "saturday",
            "sun" => "sunday",
        },
        "es" => {
            "lunes" => "monday", "martes" => "tuesday",
            "miércoles" => "wednesday", "miercoles" => "wednesday", 
            "miérc" => "wednesday", "jueves" => "thursday", 
            "viernes" => "friday", "sábado" => "saturday", 
            "sábados" => "saturday", "sabado" => "saturday", 
            "sabados" => "saturday", "domingo" => "sunday", 
            "domingos" => "sunday",

            "lun" => "monday", "mie" => "wednesday",
            "jue" => "thursday", "vie" => "friday",
            "sab" => "saturday", "dom" => "sunday"
        },
        "ca" =>{
            "dilluns" => "monday", "dimarts" => "tuesday",
            "dimecres" => "wednesday", "dijous" => "thursday",
            "divendres" => "friday", "dissabte" => "saturday",
            "dissabtes" => "saturday", "diumenge" => "sunday",
            "diumenges" => "sunday"
        }
    }

    @year_months = {
        "en" => {
            "january" => "january", "february" => "february",
            "march" => "march", "april" => "april",
            "may" => "may", "june" => "june",
            "july" => "july", "august" => "august",
            "september" => "september", "october" => "october",
            "november" => "november", "december" => "december",
            "jan" => "january", "feb" => "february",
            "mar" => "march", "apr" => "april",
            "jun" => "june", "jul" => "july", "aug" => "august",
            "sep" => "september", "sept" => "september", "oct" => "october",
            "nov" => "november", "dec" => "december"},
        "es" => {
            "enero" => "january", "febrero" => "february", "febr" => "february",
            "marzo" => "march", "abril" => "april",
            "mayo" => "may", "junio" => "june",
            "julio" => "july", "agosto" => "august",
            "septiembre" => "september", "octubre" => "october",
            "noviembre" => "november", "diciembre" => "december", 
            "dicimbre" => "december", "diceimbre" => "december",
            "ene" => "january", "feb" => "february", "mar" => "march",
            "abr" => "april", "jun" => "june", "jul" => "july",
            "ago" => "august", "sep" => "september", "sept" => "september", "oct" => "october",
            "nov" => "november", "dic" => "december"},
        "ca" => {
            "gener" => "january", "febrer" => "february",
            "març" => "march", "mar\303\207" => "march", "abril" => "april",
            "maig" => "may", "juny" => "june",
            "juliol" => "july", "agost" => "august",
            "setembre" => "september", "octubre" => "october",
            "novembre" => "november", "desembre" => "december",
            "des" => "december", "gen" => "january", "set" => "september",
            "mai" => "may"}
    }

    @num_months = {
        "january" => 1,
        "february" => 2,
        "march" => 3,
        "april" => 4,
        "may" => 5,
        "june" => 6,
        "july" => 7,
        "august" => 8,
        "september" => 9,
        "october" => 10,
        "november" => 11,
        "december" => 12
    }

    @months_to = {
      "es" =>{
        "january" => "enero",
        "february" => "febrero",
        "march" => "marzo",
        "april" => "abril",
        "may" => "mayo",
        "june" => "junio",
        "july" => "julio",
        "august" => "agosto",
        "september" => "septiembre",
        "october" => "octubre",
        "november" => "noviembre",
        "december" => "diciembre"
      },
      "ca" =>{
        "january" => "gener",
        "february" => "febrer",
        "march" => "març",
        "april" => "abril",
        "may" => "maig",
        "june" => "juny",
        "july" => "juliol",
        "august" => "agost",
        "september" => "setembre",
        "october" => "octubre",
        "november" => "novembre",
        "december" => "desembre"
      }
    }
  end

  def debug=(debug)
    @debug = debug
    @myout.debug=(debug)
  end

  def country=(country)
    @country = country
  end

  def options=(options)
    @options = options
  end
  
  def options
    @options
  end

  def is_number(word)
    w = word.gsub(/(h|H|th|nd|st|rd|pm|am|hr)$/, "")
    @myout.debug "word:#{w}"
    return [false, w] if w == ""
    w.each_char do |c|
      @myout.debug "c:#{c} => @numbers[#{c}] => #{@numbers[c]}'"
      if @numbers[c].nil?
        @myout.debug "false!"
        return [false, w]
      end
    end

    @myout.debug "true!"
    [true,w]
  end

  def categorize_word(word)
    @week_days.each do |language, days|
      return [days[word], "l"] if days[word]
    end

    @year_months.each do |language, months|
      return [months[word], "F"] if months[word]
    end

    [word, false]
  end

  def predict_year(month)
    t = Time.now
    y = t.year
    m = t.month

    if m >= 7 #Starting July we can accept dates from next year (only 6 months time)
      if m == 7 && month.to_i <= 1
        y = y + 1;
      elsif m == 8 && month.to_i <= 2
        y = y + 1;
      elsif m == 9 && month.to_i <= 3
        y = y + 1;
      elsif m == 10 && month.to_i <= 4
        y = y + 1;
      elsif m == 11 && month.to_i <= 5
        y = y + 1;
      elsif m == 12 && month.to_i <= 6
        y = y + 1;
      end
    end

    if m <= 4 #We do not predict the same year at the beginning of year
      if m == 1 && month.to_i >= 9
        return 1970
      elsif m == 2 && month.to_i >= 10
        return 1970
      elsif m == 3 && month.to_i >= 11
        return 1970
      elsif m == 4 && month.to_i >= 12
        return 1970
      end
    end

    y
  end

  def get_time(words)
    data = {}
    data['day_of_week'] = 0
    words.each do |info|
      case info['state']
      when "Y"
        data['year'] = info['word']
      when "y"
        data['year'] = "20" + info['word']
      when "d"
        data['day'] = info['word']
      when "l"
        data['day_of_week'] = info['word']
      when "H"
        data['hour'] = info['word']
        data['hour'] = 0 if data['hour'] && data['hour'].to_s == "24"
      when "i"
        data['minute'] = info['word']
      when "F"
        data['month'] = @num_months[info['word']]
      when "m"
        data['month'] = info['word']
      end
    end

    @myout.debug "data:#{data.inspect.to_s}"
      
    if data['day'] && data['month'] && data['year'] && data['hour'] && data['minute']
      return Time.mktime(data['year'], data['month'], data['day'], data['hour'], data['minute'], 0)
    elsif data['day'] && data['month'] && data['year'] && data['hour']
      return Time.mktime(data['year'], data['month'], data['day'], data['hour'], 0, 0)
    elsif data['day'] && data['month'] && data['hour'] && data['minute']
      data['minute'] = 0 if data['minute'].to_i > 59
      return Time.mktime( predict_year(data['month']), data['month'], data['day'], data['hour'], data['minute'], 0)
    elsif data['day'] && data['month'] && data['hour']
      return Time.mktime( predict_year(data['month']), data['month'], data['day'], data['hour'], 0, 0 )
    elsif data['day'] && data['month']
      return Time.mktime(predict_year(data['month']), data['month'], data['day'], 0, 0, 0)
    elsif data['day_of_week'] && data['day'] && data['hour'] && data['minute']
      y,m,d = predict_month_year(data['day_of_week'], data['day'])
      return Time.mktime(y, m, d, data['hour'], data['minute'], 0) if !m.nil?
    elsif data['day_of_week'] && data['day'] && data['hour']
      y,m,d = predict_month_year(data['day_of_week'], data['day'])
      return Time.mktime(y, m, d, data['hour'], 0, 0) if !m.nil?
    elsif data['day_of_week'] != 0 && data['hour'] && data['minute']
      y,m,d = predict_day(data['day_of_week'])
      return Time.mktime(y, m, d, data['hour'], data['minute'], 0)
    elsif data['day_of_week'] != 0 && data['hour']
      y,m,d = predict_day(data['day_of_week'])
      return Time.mktime(y, m, d, data['hour'], 0, 0)
    elsif data['day_of_week'] != 0
      y,m,d = predict_day(data['day_of_week'])
      return Time.mktime(y, m, d, 0, 0, 0)
    end

    return 0;
  end

  def predict_day(day_of_week)
    if day_is_today?(day_of_week)
      y, m, d = Time.now.strftime("%Y-%m-%d").split("-")
    else
      y, m, d = next_day(day_of_week)
    end

    [y, m, d]
  end

  def next_day(day_name)
    today = Time.now
    (1..7).each do |d|
      t = Time.at(today + d*24*60*60)
      y, m, d = t.strftime("%Y-%m-%d").split("-")
      return [y, m, d] if t.strftime("%A").downcase == day_name.downcase
    end
  end

  def day_is_today?(day_name)
    today = Time.now
    today.strftime("%A").downcase == day_name.downcase
  end

  def predict_month_year(day_of_week, day)
    day_of_week = day_of_week.downcase
    day = day.to_i
    today = Time.now
    #we only try 60 days ahead (except in february)
    days_ahead = today.strftime("%m") == "02" ?
      28-today.strftime("%d").to_i : 60
    (0..days_ahead).each do |d| 
      t = Time.at(today + d*24*60*60)
      a = t.strftime("%A").downcase
      d = t.strftime("%d").downcase.to_i
      #p "'#{a} #{d}' == '#{day_of_week} #{day}' => #{t.strftime("%Y %m %d")}"
      if a == day_of_week && d == day
        return t.strftime("%Y %m %d").split(' ')
      end
    end

    [nil,nil,nil]
  end

  def parse_date_internal(text, format = "%Y-%m-%d %H:%M:%S")
    date = text.dup
    date.gsub!(/[\n\r\t]+/, " ")
    date.gsub!("&Aacute;", "a")
    date.gsub!("&aacute;", "a")
    date.gsub!("&eacute;", "e")
    date.gsub!("&Eacute;", "e")
    date.gsub!("\341","a")
    date.gsub!("\351","e") #para que s&aacute;bado y mi&eacute;rcoles no den problemas
    date.gsub!("\303\201","A")
    date.gsub!("\303\211","E")
    words = QueryEncoder.arregla_caracteres_raros(date).split(' ');

    states = [];
    code = "";
    words.each do |w|
      isN, word_fixed = is_number(w)
      @myout.debug "is_number( #{w} ) => (#{isN},#{word_fixed})"

      if isN.eql?(false)
        word_e, type_w = categorize_word(w)
        @myout.debug "categorize_word(#{w})? => ('#{word_e}','#{type_w}')"

        if type_w != false
          states += [{"word" => word_e, "state" => type_w}]
          code += type_w
        end
      elsif isN.eql?(true)
        #s = (word_fixed.length == 4 && word_fixed[0..0] == "2") ? "Y" : "N"
        s = (word_fixed.length == 4) ? "Y" : "N"
        @myout.debug "type_number(#{word_fixed}) => (#{s})"
        states += [{"word" => word_fixed, "state" => s}]
        code += s
      end
    end

    @myout.debug "states(in):#{states.inspect.to_s}"
    @myout.debug "code:#{code}"

    if @options[:nomonth] && @grammars_nomonth[@country][code]
      match = @grammars_nomonth[@country][code]
      @myout.debug "match_nomonth(#{code}):#{match.inspect.to_s}"
      match.each_with_index do |s,i|
        states[i]["state"] = s
      end
    elsif @options[:onlyday] && @grammars_onlyday[@country][code]
      match = @grammars_onlyday[@country][code]
      @myout.debug "match_onlyday(#{code}):#{match.inspect.to_s}"
      match.each_with_index do |s,i|
        states[i]["state"] = s
      end
    elsif @grammars[@country][code]
      match = @grammars[@country][code]
      @myout.debug "match(#{code}):#{match.inspect.to_s}"
      match.each_with_index do |s,i|
        states[i]["state"] = s
      end
    else
      states = states.clear
    end

    @myout.debug "states(out):#{states.inspect.to_s}"

    ts = get_time(states)
    date_out = Time.at(ts)
    @myout.info "<DateExtraction/parse_date('#{text}') = '#{date_out.to_s}'"

    if format.eql? false
      return ts.to_i
    end

    if text.downcase.include?("pm") || text.downcase.include?("p.m")
      return shift_date_12(date_out.strftime(format))
    elsif text.downcase.include?("am") || text.downcase.include?("a.m")
      return shift_date_am_12(date_out.strftime(format))
    else
      return date_out.strftime(format)
    end
  end

  def parse_date(text, format = "%Y-%m-%d %H:%M:%S")
    begin
      parse_date_internal(text, format)
    rescue Exception => e  
      p e.message  
      p e.backtrace.inspect  
      p "ERROR: Exception parsing date = '#{text}'"
      return "1970-01-01 00:00:00"
    end
  end

  def strtotime date
    @options=({:nomonth => false})
    parse_date(date, false)
  end

  def today
    @options=({:nomonth => false})
    parse_date(Time.now.strftime("%Y-%m-%d 00:00:00"), false)
  end

  def months_to
    @months_to
  end

  def get_hour(date)
    _, hourinfo = date.split(' ')
    hour, minute, _ = hourinfo.split(':')
    [hour.to_i, minute.to_i]
  end

  def get_day(date)
    day, _ = date.split(' ')
    day
  end

  def shift_date_12(date)
    hour, _ = get_hour(date)
    if hour < 12
      date.gsub!(/ [0-9]{2}\:/, " #{(hour+12).to_s}:")
    end
    date
  end

  def shift_date_am_12(date)
    hour, _ = get_hour(date)
    if hour == 12
      date.gsub!(/ [0-9]{2}\:/, " 00:")
    end
    date
  end

  def shift12h(date)
    shift_date_12(date)
  end
end