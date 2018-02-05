# RealmServer
Full example realm object server with swift 4

* [Video demo](https://streamable.com/axlbt)

### Installing

A step by step series of examples that tell you have to get a development env running


1- step install realm object server 

Note : This script install all tools (Nodejs , npm , nvm , ros) automatically

```
curl -s https://raw.githubusercontent.com/realm/realm-object-server/master/install.sh | bash

```
2- Project creation 

```
 ros init my-app 
 
```

3- Run server project 

```
 cd my-app/
 npm start
 
```

4- Open Realm Studio  and click Connect to Realm Object Server


5- open xcode and edit values in RealmServerManager 

  * userName 
  * password 
  * authServerURL
  * syncServerURL


## References 

* [Install Server ](https://realm.io/docs/realm-object-server/latest/) - The web Install server amd run 
* [Realm Swift Doc](https://realm.io/docs/swift/latest/) - Realm Swift tut


