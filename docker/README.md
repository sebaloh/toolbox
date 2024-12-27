# Docker

## 1. Install Docker

  The following section is directly copied from the official Docker documentation. For more and detailed information visit their [website](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

  **Note:** There are scripts to install and remove Docker. They run the exact lines from the tutorial below.

  ### 3.1 Detact distribution

  ```sh
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
  else
    echo "Unsupported distribution. Exiting."
    exit 1
  fi
  ```

  ### 3.2 Set up Docker's ```apt``` repository

  ```sh
  # Add Docker's official GPG key:

  sudo apt-get update
  sudo apt-get install ca-certificates curl -y
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/$DISTRO/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  
  # Add the repository to Apt sources:

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$DISTRO \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  ```

  ### 3.3 Install the Docker packages.

  ```sh
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  ```

  ### 3.4 Verify that the Docker Engine installation is successful by running the ```hello-world``` image.

  ```sh
  sudo docker run hello-world
  ```

  ### 3.5 Manage Docker access

  **Warning:** Whis will grant all users of the ```docker``` group root-level privileges to the user.

  The following section is directly copied from the official Docker documentation. For more and detailed information visit their [website](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)

  1. Create the ```docker``` group.

  ```sh
  sudo groupadd docker
  ```

  2. Add your user to the ```docker``` group.

  ```sh
  sudo usermod -aG docker $USER
  ```

  3. Activate the changes to groups.

  ```sh
  newgrp docker
  ```

  4. Verify that you can run ```docker``` commands without ```sudo```.

  ```sh
  docker run hello-world
  ```

### *3.6 Uninstall Docker*

  *The following section is directly copied from the official Docker documentation. For more and detailed information visit their [website](https://docs.docker.com/engine/install/ubuntu/#uninstall-docker-engine).*

  ***Note:** There are scripts to install and remove Docker in ```/scripts.``` They run the exact lines from the tutorial below.*

  #### *3.6.1 Stop Docker services.*

  ```sh
  sudo systemctl disable docker.service
  sudo systemctl disable containerd.service
  ```

  #### *3.6.2 Remove Docker packages.*

  ```sh
  sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y
  ```

  #### *3.6.3 Delete all data (images, containers, volumes).*

  ```sh
  sudo rm -rf /var/lib/docker
  sudo rm -rf /var/lib/containerd
  ```

  #### *3.6.4 Cleanup*

  ```sh
  sudo apt autoremove -y
  ```
