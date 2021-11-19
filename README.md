# LAMP


1. The first Script we have to run is for service account creation with appropiate permission for that we need to run certain commands which is present in serviceAccountFile.txt.

2. then we need to go to console or run command to download the serviceaccount key which is in json format.

   $ gcloud iam service-accounts keys create key-file \
        --iam-account=packer@vertical-orbit-324117.iam.gserviceaccount.com

The Json file will be created which we need to keep it secure.

3. Then we need to authenticate the credentials withh google account.Run the following command :

   $ export GOOGLE_APPLICATION_CREDENTIALS=<SA_KEY>.JSON

4. Now we need to install packer on our machine

   $ sudo apt-get update && sudo apt-get install packer

5. After that we need to run the packer script to which shell script [build.sh] is attched

   $ packer build image.json

6.the image will be created with a certain image family [lamp] and image name [lamp-v1] with all the packages and configuration installed  according to the given documentation

7. once the image is created with the image family we can use it in a managed instance group which will be helpful in picking up latest image with the same image family.

8. Now we need to create Managed Instance Group using terraform using the image and image family which we have created

9. we need to install terraform first

     $ sudo apt-get update && sudo apt-get install terraform

10. Now we need to run terraform file main.tf

    $terraform init [fetching the terraform modules and initialising it]
    
    $terraform plan [planning the build in a structure]
    
    $terraform apply [applying the build to create the resources on GCP]
    
11. the resource will be created with the confuration provided in main.tf file

12. As for now we have given the number of instances in Managed instance group is 1.

13. so we can see the MEDIAWIKI site with http://externat_ip/mediawiki
         external_ip = this is the external ip of the only vm created.
     
14. If the  number of instances were nore than 1 then we need to create Load balancer and attach ihe MIG in the backend.
  for load balancer we need to create forwarding rule,http_proxy,urlmap,backend service with health check which will be pointing to the MIG.
  then we would have seen the site with  http://load_balancer_ip/mediawiki
  
15. for rolling update in MIG  we need to just create a new image with new configuration and same image family and just we need to refresh the instances present in the MIG.

16. for Blue green deployment we can specify several version templates in terraform-file <main.tf> and can also assing how many vms will be alligned to which version template.

screenshots:
1.![image](https://user-images.githubusercontent.com/69305821/142619887-90db4439-20a0-489b-8c24-6fb2860aa95f.png)
2.![image](https://user-images.githubusercontent.com/69305821/142620637-ef131ad1-053c-48f2-b012-8b710268f1cc.png)
3.![image](https://user-images.githubusercontent.com/69305821/142621270-948a5d96-9ed2-4d92-bac3-1e1471576229.png)
4.![image](https://user-images.githubusercontent.com/69305821/142621416-e6e5b14f-7b59-47bf-a5a5-4b1fc105bd15.png)
5.![image](https://user-images.githubusercontent.com/69305821/142621860-3443656e-2d5f-4a68-a7bb-f3bed1bfcf12.png)
6.![image](https://user-images.githubusercontent.com/69305821/142622007-d9719ae1-7fc6-4e7b-8455-60ca5c6e0a7c.png)






    

