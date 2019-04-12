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

