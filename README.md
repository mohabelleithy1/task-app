Hello Nawy Team,

This is the repo which contains the application with the ci/cd pipeline.

In the workflow file , you will find the steps to automate the deployment of any changes.

Overview : 
This GitHub Actions workflow automates deploying a web application to Amazon ECS. It triggers on pushes to the main branch, first building a Docker image of the application and pushing it to Amazon ECR. Then, it downloads your existing ECS task definition, updates it to reference the new image, and deploys this updated definition to your ECS service. The workflow ensures continuous integration by building and pushing a new image for each code change, and continuous deployment by automatically updating your running service in ECS. Finally, it waits for the service to stabilize, confirming a successful deployment.

Please follow these steps in order to deploy the application :

1- configure the access key and secret access key for terraform first.

2- please make sure you have the iam role named :ecsTaskExecutionRole

3 - deploy the infra but comment from line 187  to line 291  , this is important as creating the service without the uri of the image will not work.

4- create repo secrets into github actions with the following secrets : AWS_ACCESS_KEY_ID ,AWS_SECRET_ACCESS_KEY

5- then run the pipeline to push an initial image to the ecr repo (note that it will fail first time as the steps after the image push requires deploying to the ecs service). 

6- once pushed , copy the image uri and put it in the variable.tf in the variable :uri_repo and copy the image tag and put it into line 242 in main.tf like the following :"image": "${var.uri_repo}:aa248",this is only important for the first time

7- now ,uncomment the lines mentioned in step 1 and then deploy the infra 

8 - once the infra is deployed , you can now run the pipeline in github actions 

9- {important}
 if you have any upcoming changes in the infra ,you have to define lifecycle block in task definition and service resources to neglect the task definition changes, i have included both of them on the main.tf file but commented ,make sure to uncomment them after step 8.


## please note that these steps happens at the first time only , however after that , changes to the application will be automated.