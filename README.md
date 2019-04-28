# tulip

Tulip is a docker project for refGene

- RESTful API /v1/gene  
  sample /v1/gene?gene=DMD

- Build application with docker container

  ```bash
  sh run.sh
  docker attach tulip
  root@fe04a2a79412:/#
  root@fe04a2a79412:/# cd service/
  ./tulip
  ```