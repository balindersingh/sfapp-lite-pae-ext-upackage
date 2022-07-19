# sfapp-lite-pae-ext-upackage
Unlocked package consists of few components to be deployed in customer org to use Lite Pae app

## Some development notes
Development could be done in either scratch org or developer/sandbox org.
Recommended : use scratch org for development and then create package and install it in your orgs.
* create a new scratch org
```sfdx force:org:create -f config/project-scratch-def.json -a <orgAliasOrUsername> --setdefaultusername```
```sfdx force:org:create -f config/project-scratch-def.json -a <orgAliasOrUsername> --nonamespace```
* Generate password
```sfdx force:user:password:generate -u <orgAliasOrUsername>```
* Display org info
```sfdx force:user:display -u <orgAliasOrUsername>```
* Delete a scratch org
```sfdx force:org:delete -u <orgAliasOrUsername>```
* To list all active / inactive orgs
```sfdx force:org:list --all```
* Deploy source code to scratch org
```sfdx force:source:push -u <orgAliasOrUsername>```
* Make changes to the components
* Pull the changes from scratch org to code
```sfdx force:source:pull -u <orgAliasOrUsername>```
* To install LWC local dev server to render LWC locally for testing
```sfdx plugins:install @salesforce/lwc-dev-server && sfdx plugins:update```
* To start local LWC dev server
```sfdx force:lightning:lwc:start```
* assign permission set to user
    * ```sfdx force:user:permset:assign --permsetname <permset_name> -u <username/alias>```
    * i.e. ```sfdx force:user:permset:assign --permsetname Payments_Admin -u <username/alias>``` 
* Create a standard platform user
```sfdx force:user:create -u orgf4v1 --setalias stduser --definitionfile config/std-user-def.json Username=dummystduser@litepae.ca```
    * with permission set assigned
    * ```sfdx force:user:create -u orgf4v1 --setalias stduser --definitionfile config/std-user-def.json permsets="Payments_Light" Username=dummystduser@litepae.ca```

## Package creation commands
* create unlocked package 
    * ```(sfdx force:package:create --name <packageName> --description "<packageDescription>" --packagetype Unlocked --path <sampleforceapp> --nonamespace --targetdevhubusername <devHubAlias> || exit 1)```
* create a released candidate version (it will BETA by default)
    * ```sfdx force:package:version:create -p <packageName> -d <sampleforceapp> --installationkey <sampleinstallationKey> --wait 10 -v <devHubAlias>```
* List package created 
    * ```sfdx force:package:list```
* List package versions created 
    * ```sfdx force:package:version:list```
* See detail of a specific package version like code coverage
    * ```sfdx force:package:version:report -p '04t5e0000012BgTUUU'```
* To install a package
    * ```sfdx force:package:install -r -p <packageversionid> -u <org_alias>```
* To uninstall a package
    * ```sfdx force:package:uninstall -p <packageversionid> -u me@example.com```
* Here's few sample comands
    * ```sfdx auth:web:login --setdefaultdevhubusername --setalias <dev-hub-alias>```
    * ```sfdx force:package:create --name <packagename> --packagetype Managed --path "force-app" --targetdevhubusername <dev-hub-alias>```
    * ```sfdx force:package:version:create -p <packagename> --postinstallscript "PostInstall" -x```
    * ```sfdx force:package:version:promote --package "04t5e00000125s9AAA"```
* https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_create_pkg_ver_promote.htm
