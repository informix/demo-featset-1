#!/bin/bash
#
# This script is used when starting a container.
#
ln -s /opt/ibm/files /home/informix/FS1_DEMOS
sudo apt-get install -y gcc
sudo apt-get install -y less
sudo apt-get install -y time
echo " "
echo " "
echo "---------------------------------------------------------"
echo " "
echo "demo-featset-1 container setup complete."
echo " "
echo "Now, to connect to this container, in another terminal"
echo "window run:"
echo " "
echo "docker exec -it demo_featset_1 bash"
echo " "
echo "A README file and demo scripts are located in the FS1_DEMOS"
echo "subdirectory."
echo " "
echo "This window should be left as-is. To shut down the"
echo "container without losing changes made there, cd to"
echo "the demo-featset-1 directory in another terminal window"
echo "and run:"
echo " "
echo "docker stop demo_featset_1"
echo " "
echo "To shut down the container and abandon all changes made"
echo "to your instance, execute the following command instead:"
echo " "
echo "docker-compose down -v"
