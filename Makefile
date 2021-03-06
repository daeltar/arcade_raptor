CC=g++
CFLAGS=-Wall -O2 
SPEED= -ffast-math
SOURCES=main.cpp game.cpp game_object.cpp ship.cpp player_ship.cpp enemy_ship.cpp projectile.cpp bonus.cpp
HEADERS=*.h
LIBS=
EXECUTABLE=raptor
OSTYPE=osx

ifeq "$(OSTYPE)" "osx"
SOURCES+=SDLMain.m
CFLAGS+=$(SPEED)
FRAMEWORKS=-framework SDL -framework SDL_image -framework SDL_ttf -framework Cocoa 
LIBS= -I./osx/Frameworks/SDL.framework/Headers \
      -I./osx/Frameworks/SDL_image.framework/Headers \
      -I./osx/Frameworks/SDL_ttf.framework/Headers 
endif
ifeq "$(OSTYPE)" "linux"
LIBS= -L/usr/lib -I/usr/include/SDL -lSDL -lSDL_image -lSDL_ttf -lpthread
FRAMEWORKS=
endif

raptor: $(SOURCES) $(HEADERS)
	$(CC) $(CFLAGS) $(SOURCES) $(LIBS) $(FRAMEWORKS) -o $(EXECUTABLE) 
	
Raptor.app: raptor data/Info.plist
	rm -rf Raptor.app
	-mkdir Raptor.app    
	-mkdir Raptor.app/Contents
	-mkdir Raptor.app/Contents/MacOS
	-mkdir Raptor.app/Contents/Resources
	-mkdir Raptor.app/Contents/Resources/data	
	-mkdir Raptor.app/Contents/Resources/English.lproj
	-mkdir Raptor.app/Contents/Frameworks
	echo -n 'APPL????' > Raptor.app/Contents/PkgInfo
	cp data/Info.plist Raptor.app/Contents/
	cp data/Raptor.icns Raptor.app/Contents/Resources/
	cp data/*.{png,jpg,ttf} Raptor.app/Contents/Resources/data
	cp raptor Raptor.app/Contents/MacOS/Raptor
	cp -R osx/Frameworks/* Raptor.app/Contents/Frameworks
	
dmg: Raptor.app
	hdiutil create Raptor.dmg -volname "Arcade Raptor" -fs HFS+ -srcfolder "Raptor.app"
	
apidoc: $(SOURCES) $(HEADERS)
	doxygen doc/cnf
	
clean:
	rm raptor
	rm -rf Raptor.app
	rm -rf Raptor.dmg
	rm -rf doc/html