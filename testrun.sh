
# This is just an example - obviously replace username, password and home directory storage location.
docker run -d -p 4322:22 --name dockerbuntu --hostname=dockerbuntu -e USERNAME=testuser -e PASSWORD=testpassword -v $HOME/tmp/dockerbuntuhome:/home/testuser dockerbuntu
