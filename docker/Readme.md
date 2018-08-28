## Development with Devspaces
 ### Minimum Requirements
 * Python3. (>= 3.5)
* pip3. (>=18.0.0)
* Docker.
* Virtualenv.
 ### Devspaces Configuration
 Jive Doc Converter 2018 has been configured to be developed under DevSpaces(DS).
 DS is a docker based development environment that takes the complexity of 
 setting up local environments and brings all the benefits of a totally cloud
 Development environment
 # Where to start
 Verify that you have access to https://devspaces.ey.devfactory.com (it requires "jira-users" access into AD) and follow the tutorial, setup an image and a workspace to get familiar on how DS works:
 * http://devspaces-docs.ey.devfactory.com/quickstart.html
 
 ### Jive Doc-Converter Devspaces Setup
 After you have installed the DS client and run the basic example, we'll proceed to setup the development environment for doc-converter.  
 This environment is configured using the doc-converter-collection.yml file.  
 On this file we have two major sections, first a "images" part where the basic infra to run the project is configured the Image "doc-converter-dev" it's build on top of the Dockerfile(inside this folder) and its the one that the developer actually uses to connect to and build/run the project.  
 Following there’s a "configs" section, on this last one, first we have the "bind-path" which is the location where you'll be using your DS, after that, the "containers" section defines the different configurations for each image as ports and env variables.

 Start by cloning the project repo, and making sure you are on develop branch, the base location of your repo is going to be your base folder for all DS operation.  
 Make sure you are on the develop branch to have access to devspaces folder, later you can switch to any branch you need.

  # Automatic Configuration
 1. Head to devspaces folder
 2. Make sure the setup.sh file has execute permissions
 3. Run `./setup.sh`

  # Manual Configuration
 1. Before you begin, make sure to edit your local bind-path location inside devspaces/doc-converter-collection.yml folder to your repo base
 2. Head to your base folder, in my case /Users/rafael/Jive/doc-converter
 3. Run `cndevspaces configure` this is only needed once
 4. Run: `cndevspaces collections create -f devspaces/doc-converter-collection.yml`  
 This command takes care of creating a set of images on your DS account to run the project this only needs to be run once also
 5. Head to https://devspaces.ey.devfactory.com/home/collections and make sure your collection was created
 6. Run `cndevspaces bind -C doc-converter-col -c doc-converter -v`  
 This will connect your local and remote folders and keep synchronized all changes made.
 The first time you bind with the DS it’s going to take some time as the system needs to upload all your source files to DS.  
 From now on, all the code you change locally or remotely is going to be synchronized between the systems, also you can use the `.stignore` file to define things that you don't want to be synchronized.
 7. Once the sync process has finished, we advise to run `cndevspaces save`  
 This command saves the current state of the image and saves you time on future restarts, remember that DS is meant to be a stateless environment.  
 So saving the state of the images is a way to keep your changes between work sessions, and save time when starting up your environment, you can use this command at any time.
 8. To login into your new DS run `cndevspaces exec -C doc-converter-col -r doc-conv-cont`, this will take you to the prompt of your newly created DS, when you login you'll be taken directly to the /data folder.  
 This is the folder on your remote machine where all your files are stored, basically everything you have on your base folder is going to be sync to this location.

  # After Configuration
 1. To build the project run `mvn --batch-mode -DskipTests package`  
 Its good to save the devspaces after this also(only after the first run) as this will make the compile faster(as the download was already done and files saved).  
 This will create the .jar files so now we can run the server.
 2. Run the server with `java -Dconfig.file=/data/docker/config/config_local.yaml -jar /data/docker/target/service.jar server /data/docker/config/config_local.yaml &`
 3. Now we can finally run `mvn test` as it depends of a running server to execute without errors.
 
  # Troubleshooting
 1. Is DS stuck at syncing? no problem, first stop the running command, then head to http://localhost:8384/ and from the actions dropdown select restart, then run your command again
 2. Collection or container is giving you a problem but not sure what's going on? Check the logs using the command `cndevspaces logs -C  doc-converter-col -c doc-converter -r doc-conv-cont`
 3. If you run into any issue during your DS setup, check the #devspaces-support slack channel
