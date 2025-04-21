1.  helm create helloworld

2.  tree .\helloworld\

3.  helm install myhelloworldrelease .\helloworld\

    myhellowworld is release name .\helloworld\ is chart location

4.  helm list -a

5.  helm uninstall myhelloworld

6.  helm upgrade myhelloworldrelease .\helloworld\

7.  helm rollback myhelloworldrelease 1

    rollbacks to revision 1

    even when this rollback is success when u do helm list -a you will have increased revision number

8.  helm get all myhelloworldrelease --revision 2

    Show the Full Details of a Specific Revision

9.  helm history myhelloworldrelease

    List Helm Releases and Their Revisions

10. helm diff revision release-name revision-1 revision-2

11. helm get values my-release --revision 2

12. helm template .\helloworld\

    validates yamls

13. helm lint .\helloworld\

    checks if there are any errors

14. helm search hub wordpress

15. helm search hub wordpress --max-col-width=0

16. helm repo list

17. helm repo add bitnami https://charts.bitnami.com/bitnami

18. helm search repo wordpress --versions

19. helm show readme bitnami/wordpress --version 10.0.3

20. helm show values bitnami/wordpress --version 10.0.3
