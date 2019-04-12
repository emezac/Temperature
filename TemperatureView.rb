#!/usr/bin/ruby

require 'rubygems'
require 'gtk2'


class TemperatureGUI

  def initialize(temp,temperature)
    @temp, @temperature = temp,temperature
    @builder = Gtk::Builder.new.add_from_file("temp.ui")
    @builder.connect_signals{|handler| method(handler)}
    @entryF = @builder["entry1"]
    @entryC = @builder["entry2"]
    @vscale = @builder["vscale1"]
    @entryF.set_text(@temp.to_s)
    @entryC.set_text(((5.0/9.0)*(@temp-32.0)).to_s)
    @vscale.set_value((5.0/9.0)*(@temp-32.0))
    f_up_button = @builder["button1"]
    f_down_button = @builder["button2"]
    c_up_button = @builder["button3"]
    c_down_button = @builder["button4"]
  end

  def setDisplayF(newF)
    @newF = newF
    @entryF.set_text("#{@newF}")
  end

  def setDisplayC(newC)
    @newC = newC
    @entryC.set_text("#{@newC}")
  end

  def getDisplayF
    @entryF.text.to_f
  end

  def getDisplayC
    @entryC.text.to_f
  end

  def procScale
      @v = @vscale.value
      @temperature.newtC(@v)
  end

  def procEntryC
      @v = getDisplayC
      @temperature.newtC(@v)
  end

  def procEntryF
      @nv = getDisplayF
      @v = (5.0/9.0)*(@nv-32.0)
      @temperature.newtC(@v)
  end

  def upF
      @temp =  getDisplayF
      @temperature.upF(@temp)
  end

  def downF
      @temp =  getDisplayF
      @temperature.downF(@temp)
  end

  def upC
      @temp =  getDisplayC
      @temperature.upC(@temp)
  end

  def downC
      @temp =  getDisplayC
      @temperature.downC(@temp)
  end

  def setTemp(t)
    @t = t 
    @vscale.set_value(@t)
  end

  def quit
    Gtk.main_quit
  end
 
end

