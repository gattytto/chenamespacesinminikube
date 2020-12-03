to deploy first:
````bash
 kubectl apply -f chesc.yaml #create storage class for the first time 
 ./before.sh #reset volumes and clean postgres data (release workspaces volume without erase)
             #run every chectl reinstall.
````

after that issue:

````yaml
chectl server:deploy -p minikube -a operator -m --che-operator-cr-patch-yaml=operatorpatch.yaml
````

then use the after patch:
````bash
./after.sh
````
