# Vagrant Server for Laravel 5.6 

This should be everything needed to get the dev server up. If anything else is found, please add an issue or document the commit. Once you have setup the server you are prompted for the Git Repository that you want to load when running the Setup-Project.sh script.

## Setup Project

After the initial vagrant up you need to setup your project.

### Automated Project Setup
SSH into the server

Store your GitHub Credentials on the server

Run `setup-project.sh`
--This will prompt you to enter the git repository with the Laravel project you wish to use. If you don't select one it will take the most current Laravel from GitHub.

## Complete Setup
Back on your local machine, in the `www` folder do a npm install

```
# npm install
```

#### Notes:
* If you have installation issues during the provisioning check the output.txt file for more detailed errors
* Lookout for machine timeouts during provisioning
* The default vagrant box is ubuntu/trusty32

Any problems or suggestions please document. I'd like to come up with a more streamlined process to get a new project up.
