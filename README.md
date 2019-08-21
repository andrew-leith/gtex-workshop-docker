# GTEx Workshop Docker

This docker image contains the notebook and data from https://github.com/broadinstitute/gtex-ashg2017-workshop

To run the notebook, open a terminal window and use the command:

```
  docker run -p 8888:8888 -it aleith/gtex-workshop-docker:latest bash /home/ubuntu/gtex.sh
```

This command will run a container, load the notebook, and forward it to the host machine's browser.  To access the notebook, copy the URL that will be displayed in the terminal.
