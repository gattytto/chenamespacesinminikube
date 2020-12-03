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

now there's the need of a patch on checluster:
````bash
kubectl edit -n che checluster/eclipse-che
````
add in relevant part:
````yaml
server:
    allowUserDefinedWorkspaceNamespaces: true
    cheCustomProperties:
      CHE_WORKSPACE_DEFAULT__CPU__LIMIT__CORES: 5999m
      CHE_WORKSPACE_DEFAULT__CPU__REQUEST__CORES: 1.75
````

restart che server to apply:
````bash
kubectl -n che scale deployment/che --replicas=0 && \
kubectl -n che scale deployment/che --replicas=1
````

then use the after patch:
````bash
./after.sh
````

devfile for testing:
````yaml
apiVersion: 1.0.0
metadata:
  name: haskell
components:
  - id: eclipse/che-theia/next
    type: cheEditor
    cpuLimit: 1750m
    cpuRequest: 200m
  - preferences:
      haskell.languageServerVariant: ghcide
    type: chePlugin
    id: haskell/vscode-haskell/latest
    cpuLimit: 4001m
    cpuRequest: 200m
````
