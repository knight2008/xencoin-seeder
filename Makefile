CXXFLAGS = -O3 -g0 -march=native
LDFLAGS = $(CXXFLAGS)

xenseed-exec: dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o 
	g++ -pthread $(LDFLAGS) -o xenseed-exec dns.o bitcoin.o netbase.o protocol.o db.o main.o util.o -lcrypto
	chmod 0777 ./xenseedd

%.o: %.cpp bitcoin.h netbase.h protocol.h db.h serialize.h uint256.h util.h 
	g++ -DUSE_IPV6 -pthread $(CXXFLAGS) -Wno-invalid-offsetof -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -c -o dns.o

%.o: %.cpp

clean:
	rm -rf xenseed-exec
	rm -rf *.o
	chmod 0666 ./xenseedd
	rm -rf *.dump
	rm -rf *.log
	rm -rf *.dat
