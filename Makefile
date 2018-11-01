
#LIBS=-lthr -lcuse4bsd -lfluidsynth
#LIBS=-lthr -lfluidsynth
LIBS=-lpthread -lfluidsynth


all:	ethermidi

ethermidi:	ethermidi.c
	cc -I /usr/local/include -L /usr/local/lib ${LIBS} -o ethermidi ethermidi.c

clean:
	rm ethermidi

