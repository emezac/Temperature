require 'rubygems'
require 'gtk2'

class SignalHandler
  def method_missing(method, *args)
    puts "#{method}: #{args}"
  end
end
sigmap = SignalHandler.new

Gtk.init
glade = GladeXML.new('temp.glade', nil, 'helloglade')
window = glade['main_window']
window.signal_connect("destroy") { Gtk.main_quit }
glade.signal_autoconnect_full do |source, target, signal, handler, data|
  source.signal_connect(signal) { sigmap.send(handler, data) }
end

window.show
Gtk.main

