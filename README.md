# EtherMIDI
Ethernet to MIDI bridge using libfluidsynth

The EtherMIDI project is in a BETA state.  It is functional as-is, but
I have only 'minimally' tested it on FreeBSD and Linux.  However, I've had
some really good success with it so far, so long as the CPU can handle the
load of rendering the sound fonts and effects.

I may add additional features that specify more parameter for libfluidsynth,
as appropriate.  For now, it uses whatever the defaults are, with the synth
gain set to 0.5 .


This program uses libfluidsynth to generate MIDI output based on UDP packets
received on a listening interface (default * on port 9000, IPv4 and IPv6).

The MIDI packets are in a format as generated by the 'EthernetMIDI' application,
written by Benno Senoner - http://linuxsampler.org/ethernetmidi/

The intent is to allow a Linux or BSD computer to act as a soundfont synth
without additional MIDI cables, from a windows computer using an application
like 'Cakewalk' that requires Windows.

To make this work, you have to be able to run the 'EthernetMIDI' application
on the windows computer, using a 'midi loopback' device (similar to LoopBE;
for more information on LoopBE see http://www.nerds.de/en/loopbe30.html )

Other windows midi loopback driver software also exists.

Additional links:
* http://www.copperlan.org/index.php/download
* https://www.tobias-erichsen.de/software/loopmidi.html
* http://www.midiox.com/myoke.htm

Then, the MIDI application (let's say cakewalk) will be configured to use
the MIDI loopback device, which will then cause 'EthernetMIDI' to send UDP
packets to a Linux or FreeBSD machine running this program.  Then, the
'EtherMIDI' application (this one) invokes fluidsynth to play the MIDI content.



COMPILING
=========

There are no binaries available.  You will need to build it from source.

On a Linux system, you'll need all developer libraries and headers associated
with 'libfluidsynth'.  Typically, you can do something like this:

<pre>
  apt-get install libfluidsynth-dev
</pre>

On a FreeBSD system, you should install the 'fluidsynth' package, which will
install developer files in addition to the fluidsynth application.

Once dependency packages have been installed, you should be able to build it
using the 'make' command.  The Makefile should be compatible between gnu make
and 'BSD' make.


RUNNING
=======

To run the application, enter a command line similar to the following:

<pre>
  ethermidi -F wavetable.sf2
</pre>

where 'wavetable.sf2' is the (required) sound font file.

The '-d' option will 'daemonize' the application (stderr remains attached for
any error messages).

The default output device is 'oss' for FreeBSD, or 'pulseaudio' for Linux.

To choose a different output device, use the '-o' option.

For general help, use the '-h' option.  It will print a display similar to
the following:

<pre>
  Usage:  ethermidi [-d][-Fwavetable.sf2][-o output] [[ip][:port]]
  where   '-F' specifies a wavetable that immediately follows '-F'
   and    '-d' runs the application as a daemon
   and    '-o' specifies the output device [default is oss]
   and    'ip:port specifies an optional ip address and/or port to listen on
          the default port is 9000; specifying blank IP listens on all.
          NOTE:  IPv6 addresses should be expressed as '[ip:ad:dr:es:s]:port'
</pre>


LEGACY CODE
===========

The source file 'ethermidi.c' contains a lot of legacy code for other things
that I tried, from using a 'cuse4bsd' (userland) device for a MIDI port, to
invoking the 'fluidsynth' application via a FIFO.  Neither one of those worked
very well.  But I left the code within '#ifdef' blocks.  At some point I might
remove it, or not.  But it's there as a reference if anyone wants to play with
it, maybe implement something else.  BSD license and/or GPL applies of course,
as appropriate (your choice which one).

