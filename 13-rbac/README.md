### Steps

```shell
lucho@cloud:~$ ./action.sh

  Create Certificate Access K8S

  ./action -u [user] -g [group]

  Mandatory arguments

    -u  User K8S
    -g  Group K8S

lucho@cloud:~$ ./action.sh -u lucho -g dev

[Generate Certificate]
User: lucho
Group: dev

[Signing Certificate CA]
Signature ok
subject=CN = lucho, O = dev
Getting CA Private Key

[Succesfuld]

lucho@cloud:~$ kubectl config set-credentials lucho --client-certificate=lucho.crt --client-key=lucho.key
lucho@cloud:~$ kubectl config set-context lucho-dev --cluster=minikube --user=lucho
lucho@cloud:~$ kubectl config use-context lucho-dev
```