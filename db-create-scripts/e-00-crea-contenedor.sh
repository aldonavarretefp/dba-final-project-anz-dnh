!/bin/bash

echo "Creando contenedor"

docker run -i -t \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /unam:/unam \
--name c3-bda-anz-dnh \
--hostname d3-bda-anz-dnh.fi.unam \
--expose 1521 \
--expose 5500 \
--shm-size=2g \
-e DISPLAY=$DISPLAY ol-dnh:1.0 bash