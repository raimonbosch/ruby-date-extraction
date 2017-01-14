#!/bin/env ruby
# encoding: utf-8

require 'test/unit'
require 'date_extraction'

class DateExtractionTest < Test::Unit::TestCase

  def test_parse_date
    dtparser = DateExtraction.new()
    dates_nomonth_to_test = {
      "Viernes 28 1:30h." => "2012-09-28 01:30:00",
      "S\341bado&nbsp;29 &nbsp;- 21:30h.<br>" => "2012-09-29 01:30:00"
    }
    dates_to_test = {
        #English tests
        "Wed, 19 Sep 2012 23:55:46 +0200" => "2012-09-19 23:55:00",
        "Saturday 03 March 2012 a las 20:30" => "2012-03-03 20:30",
        "Sunday 23 February 2011, 21:00h" => "2011-02-23 21:00:00",
        "30 June 21:30h" => "2011-02-23 21:00:00",
        "Next Friday" => "2011-02-23 21:00:00",
        "21/07/2011 00:30h" => "2011-02-23 21:00:00",
        "01/09/2011 00:00h" => "2011-02-23 21:00:00",
        "18.07.2011 | 00.30 h - 05.00 h" => "2011-02-23 21:00:00",
        "19.07.2011 | 00.30 h - 06.00 h" => "2011-02-23 21:00:00",
        "22.07.2011 | 22.00 h - 00.30 h" => "2011-02-23 21:00:00",
        #Spanish tests
        "Martes 01 de Enero, de 00.00h a cierre" => "2013-01-01 00:00:00",
        "SOUNDAYS MOTORCYCLE - 2011-07-17" => "2011-02-23 21:00:00",
        "JUEVES" => "2011-02-23 21:00:00",
        "VIERNES & SABADO" => "2011-02-23 21:00:00",
        "Domingo 24 Junio 00:00h" => "2011-02-23 21:00:00",
        "Dia: 19 de julio Hora: 22 h" => "2011-02-23 21:00:00",
        "Viernes 22 Julio 2011 | 20:30" => "2011-02-23 21:00:00",
        "Sábado 23 Julio 2011 | 01:00" => "2011-02-23 21:00:00",
        "Lunes 11/07" => "2011-02-23 21:00:00",
        "Viernes 08 Julio Apertura de puertas: 20:00" => "2011-02-23 21:00:00",
        "Sabado 30 Julio Apertura de puertas: 19:00" => "2011-02-23 21:00:00",
        "Fecha: 27/11/2011 Hora: Puertas 19:30h, Artista invitado: 19:45h, Show 20:30h" => "2011-02-23 21:00:00",
        "HOY Sábado 05 Noviembre 2011 | 21:30 | 15€ ant. - 18€ Taq." => "2011-02-23 21:00:00",
        #Catalan tests
        "Dimecres, 14 desembre de 2011 21h" => "2011-02-23 21:00:00",
        "DIUMENGE 17 DE JULIOL 2011 A LES 00:30 h." => "2011-02-23 21:00:00",
        "DISSABTE 23 DE JULIOL 2011 A LES 20:00 h." => "2011-02-23 21:00:00",
        "Dj  11/11/11  21:00" => "2011-02-23 21:00:00",
        "Dc  20/10/11  21:30" => "2011-02-23 21:00:00",
        "Ds  02/10/11  21:00" => "2011-02-23 21:00:00",
        "Els Dimecres a Barcelona tenen una cita ineludible: Sala." => "2011-02-23 21:00:00",
        "Dimarts 19 de Juliol 21:00h | 23:00h" => "2011-02-23 21:00:00",
        "Dissabte 23 de Juliol 22:00h" => "2011-02-23 21:00:00",
        "Diumenge 17 de Juliol 0:00h" => "2011-02-23 21:00:00",
        "Dia: 21 de juliol Hora:18 h" => "2011-02-23 21:00:00",
        "
                                        Dissabte, 11 febrer 2012
                                        Horari pendent de confirmar                             " => "2011-02-23 21:00:00",
      
    }

#    dtparser.debug=(true)
#    dtparser.parse_date("Martes 01 de Enero, de 00.00h a cierre")
#    exit 1

    dates_nomonth_to_test.each do |date, result|
      dtparser.debug=(true)
      dtparser.options=({:nomonth => true})
      dtparser.parse_date(date.dup)
    end

    dates_to_test.each do |date, result|
      dtparser.debug=(false)
      dtparser.options=({})
      dtparser.parse_date(date.dup)
    end

    assert true
  end
end
