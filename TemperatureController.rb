require "observer"
require 'rubygems'
require 'gtk2'

class TemperatureWatcher

  def initialize(t,g)
    t.add_listener(self)
    @gui = g
  end

  def celsius_changer(temp)
     @newc = temp
     @newf = @newc*9.0/5.0 + 32.0
     @gui.setDisplayF(@newf)
     @gui.setDisplayC(@newc)
     @gui.setTemp(@newc)
  end

  def faranheit_changer(temp)
     @newf = temp
     @newc = (@newf -32.0)*5.0/9.0
     @gui.setDisplayF(@newf)
     @gui.setDisplayC(@newc)
     @gui.setTemp(@newc)
  end

end

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


class TemperatureModel

   def initialize
    @listeners = []
   end

   def add_listener(listener)
    @listeners << listener
   end

   def upF(temp)
      @temp = temp
      @temp += 1
      @listeners.each {|l| l.faranheit_changer(@temp) }
   end

   def downF(temp)
      @temp = temp
      @temp -= 1
      @listeners.each {|l| l.faranheit_changer(@temp) }
   end

   def upC(temp)
      @temp = temp
      @temp += 1
      @listeners.each {|l| l.celsius_changer(@temp) }
   end

   def downC(temp)
      @temp = temp
      @temp -= 1
      @listeners.each {|l| l.celsius_changer(@temp) }
   end

   def newtC(temp)
      @temp = temp
      @listeners.each {|l| l.celsius_changer(@temp) }
   end

end


INICIALTEMP = 32.0

temperature = TemperatureModel.new
tgui        = TemperatureGUI.new(INICIALTEMP,temperature)
watcher     = TemperatureWatcher.new(temperature,tgui)

Gtk.init
Gtk.main

