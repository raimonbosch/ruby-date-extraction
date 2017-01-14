#!/bin/env ruby
# encoding: utf-8

class MyOut
  attr_accessor :buf, :debug

  def initialize(debug = false)
    @debug = debug
    @buf = nil
    @buf = ""
  end

  def date
    Time.now.strftime("%Y-%m-%d %H:%M:%S").to_s
  end

  def info(message)
    p "[#{date}] - INFO - #{message}"
    @buf += "[#{date}] - INFO - #{message}"
  end

  def append(message)
    p message
    @buf += message
  end

  def error(message)
    p "[#{date}] - ERROR - #{message}"
    @buf += "[#{date}] - ERROR - #{message}"
  end

  def warn(message)
    p "[#{date}] - WARN - #{message}"
    @buf += "[#{date}] - WARN - #{message}"
  end

  def warning(message)
    warn(message)
  end

  def debug(message)
    if @debug
      p "[#{date}] - DEBUG - #{message}"
      @buf += "[#{date}] - DEBUG - #{message}"
    end
  end

  def clean
    @buf = nil
    @buf = ""
  end

  def debug=(debug)
    @debug = debug
  end

end