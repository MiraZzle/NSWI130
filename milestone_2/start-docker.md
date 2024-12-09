# Use this command to run the docker container with the C4 model
```
docker run -it --rm -p 8080:8080 -v .\milestone_2\c4-docker-workspace\:/usr/local/structurizr -e STRUCTURIZR_WORKSPACE_PATH=enr2_architecture structurizr/lite
```