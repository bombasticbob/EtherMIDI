
all:	ethermidi

ethermidi:	ethermidi.c
	gcc -I /usr/local/include -L /usr/local/lib -lthr -lcuse4bsd -lfluidsynth -o ethermidi ethermidi.c

clean:
	rm ethermidi

