# monitoring_readiness_liveness_probes
deploy readiness and liveness probes to monitor pods
## Scenario :
* Configure a liveness probe
* In this task will deploy a liveness probe to detect applications that have transitioned from a running state to a broken state. Sometimes, applications are temporarily unable to serve traffic. For example, an application might need to load large data or configuration files during startup. In such cases, you don't want to kill the application, but you don't want to send it requests either. Kubernetes provides readiness probes to detect and mitigate these situations. A Pod with containers reporting that they are not ready does not receive traffic through Kubernetes Services.
* Readiness probes are configured similarly to liveness probes. The only difference is that you use the readinessProbe field instead of the livenessProbe field.

### Files: 
1. A Pod definition file called **exec-liveness.yaml** defines a simple container called liveness running Busybox and a liveness probe that uses the cat command against the file /tmp/healthy within the container to test for liveness every 5 seconds. The startup script for the liveness container creates the /tmp/healthy on startup and then deletes it 30 seconds later to simulate an outage that the Liveness probe can detect.

* Configure readiness probes
* Configure a Deployment with liveness and readiness probes
* Readiness probes are configured similarly to liveness probes. The only difference in configuration is that you use the readinessProbe field instead of the livenessProbe field. Readiness probes control whether a specific container is considered ready, and this is used by services to decide when a container can have traffic sent to it.

2. A Deployment definition file called **readiness-deployment.yaml** defines a deployment called readiness-deployment with three Pods running containers with the Hello-World demo application.

* Each container has a readiness probe defined that uses the cat command against the file /tmp/healthy within the container to test for readiness every 5 seconds.

* Each container also has a liveness probe defined that uses the cat command against the same file within the container to test for readiness every 5 seconds but it also has a startup delay of 45 seconds to simulate an application that might have a complex startup process that takes time to stabilize after a container has started.

* The startup script for the containers sleeps for 30 seconds, launches the hello-world web application in the background, and then creates the /tmp/healthy file. This keeps each container from passing the readiness test for at least 30 seconds after startup. The pods will then seem to pause for 30 seconds after starting up before they are flagged as ready and therefore before any service will select them as endpoints. The startup script then waits for a random period of time, between 60 and 180 seconds, before deleting the /tmp/healthy file. That will cause both the readiness and liveness probes to fail so the readiness-svc service will remove the endpoint for that container and at more or less the same time the failure of the liveness probe will cause the container to restart.

* Once the service has started handling traffic this pattern ensures that the service will forward traffic only to containers that are ready to handle traffic.

* Configure a load balancer Service
3. A service definition file called **readiness-service.yaml** creates a load balancer service definition for a service called readiness-svc. The service is configured to select containers that have the app label readiness-test that will match the containers in the deployment you created in the previous task.

### proven steps: 
1. create cluster:
![Screenshot from 2020-11-14 12-54-25](https://user-images.githubusercontent.com/68178003/100541479-ea9d1b00-324c-11eb-89a2-58ed494ef1d9.png)
2. showing readiness service in gcp :
![Screenshot from 2020-11-14 12-54-43](https://user-images.githubusercontent.com/68178003/100541480-ed980b80-324c-11eb-9b90-d51f6284bd41.png)

![Screenshot from 2020-11-14 12-55-13](https://user-images.githubusercontent.com/68178003/100541484-f12b9280-324c-11eb-9a3d-a4941fdb0b77.png)
3. deployment : 
![Screenshot from 2020-11-14 12-57-09](https://user-images.githubusercontent.com/68178003/100541488-f38dec80-324c-11eb-893c-bb7325689490.png)
