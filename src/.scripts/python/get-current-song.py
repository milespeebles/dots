#!/usr/bin/env python3
import mpd, os, time

def format(seconds):
    return time.strftime('%-M:%S', time.gmtime(float(seconds)))

client = mpd.MPDClient(use_unicode=True)
client.connect('localhost', 6600)
status = client.status()
song = client.currentsong()


elapsed = float(status['elapsed'])
duration = float(song['time'])
artist = song['artist']
album = song['album']
title = song['title']
remaining = format(duration - elapsed)

a = '#[bg=#ff5555] %s ' % artist
b = '#[bg=#ffb86c] %s ' % album
c = '#[bg=#f1fa8c] %s (%s) ' % (title, remaining)

print('#[fg=#272936]' + a + b + c)
