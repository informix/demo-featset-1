#!/bin/bash
ln -s /opt/ibm/files /home/informix/FS1_DEMOS
sudo apt-get install -y gcc
sudo apt-get install -y time
echo " "
echo " "
echo "---------------------------------------------------------"
echo " "
echo "demo-featset-1 container setup complete."
echo " "
echo "Now run:"
echo " "
echo "docker exec -it demo_featset_1 bash"
echo " "
echo "in another terminal window to connect to this container."
echo "The demo scripts are located in the ~informix/FS1_DEMOS"
echo "subdirectory."
echo " "
echo "This window should be left as-is. To shut down the"
echo "container, cd to the demo-featset-1 directory in another"
echo "terminal window and run:"
echo " "
echo "docker-compose down"
