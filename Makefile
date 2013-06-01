MAIN = diffuse
CC = g++
INCDIRS = -I/home/ego/libs/berkelium/include/ -I/home/ego/projects/personal/gliby/include/
CXXFLAGS = $(COMPILERFLAGS) -O3 -march=native -pipe -std=c++0x -Wall -g $(INCDIRS)
CFLAGS = -g $(INCDIRS)
LIBS = -L/home/ego/libs/berkelium/ -lGL -lGLU -lGLEW -lglfw -lboost_system -lboost_filesystem -pthread -llibberkelium_d -ljsoncpp

prog :  $(MAIN)

$(MAIN).o : $(MAIN).cpp

build/%.o : %.cpp
	$(CC) -o $@ -c $(CPPFLAGS) $(CXXFLAGS) $<

build/gliby/%.o : /home/ego/projects/personal/gliby/src/%.cpp
	$(CC) -o $@ -c $(CPPFLAGS) $(CXXFLAGS) $<

$(MAIN) : build/$(MAIN).o build/gliby/Batch.o build/gliby/ShaderManager.o build/gliby/Frame.o build/gliby/Math3D.o build/gliby/Frustum.o build/gliby/MatrixStack.o build/gliby/TransformPipeline.o build/gliby/Actor.o build/gliby/TriangleBatch.o build/gliby/GeometryFactory.o build/gliby/TextureWindow.o build/gliby/UIElement.o build/gliby/Grid.o
	$(CC) -o $(MAIN) $^ $(LIBS)

.PHONY: clean
clean:
	rm -f build/*.o
	rm -f build/gliby/*.o
