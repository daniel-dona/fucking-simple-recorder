import gi
import os
import signal
import subprocess
import datetime
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

process = 0

class MyWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="Fucking Simple Recorder")
        image = Gtk.Image(stock=Gtk.STOCK_MEDIA_RECORD)
        self.button = Gtk.ToggleButton(image=image, label="Start")
        self.button.connect("clicked", self.on_button_tog)
        self.add(self.button)

        
    def on_button_tog(self, button):
        global process
        if button.get_active():
            
            self.button.set_label("Stop")
            
            self.iconify() # Hide this window!
           
            format = "%d-%m-%Y.%H-%M-%S"
            today = datetime.datetime.today()
            s = today.strftime(format)

            
            
            comm = "bash rec.sh " + s + ".mp4"

            #comm = exe + " -loglevel panic -f pulse -ac 2 -i default -f x11grab -s 1366x768+0+0 -r 25 -i :0.0 -c:v libx264 -preset fast -c:a mp3 -f mp4 " + s + ".mp4"

            process = subprocess.Popen(comm.split())
            
        else:
            process.terminate()
            Gtk.main_quit()
            self.button.set_label("Start")

win = MyWindow()
win.connect("delete-event", Gtk.main_quit)
win.resize(300, 100)
win.show_all()
Gtk.main()
