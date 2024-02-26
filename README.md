# sfapp-lite-pae-ext-upackage
Unlocked package consists of few components to be deployed in customer org to use Lite Pae app

## Some development notes
Development could be done in either scratch org or developer/sandbox org.
Recommended : use scratch org for development and then create package and install it in your orgs.
* create a new scratch org
    * ```sf org create scratch -f config/project-scratch-def.json -a <orgAliasOrUsername>```
    * ```sf org create scratch -f config/project-scratch-def.json -a <orgAliasOrUsername> --no-namespace```
* Generate password
    * ```sf org generate password -o <orgAliasOrUsername>  --complexity 3```
* Display org info
    * ```sf org display user -o <orgAliasOrUsername>```
* Delete a scratch org
    * ```sf org delete scratch -o <orgAliasOrUsername>```
* To list all active / inactive orgs
    * ```sf org list --all```
* Deploy source code to scratch org
    * ```sf project deploy start -o <orgAliasOrUsername>```
* Make changes to the components
* Pull the changes from scratch org to code
    * ```sf project retrieve start -o <orgAliasOrUsername>```
* To install LWC local dev server to render LWC locally for testing
    * ```sf plugins install apex@2.2.22```
    * ```sfdx plugins:install @salesforce/lwc-dev-server && sfdx plugins:update```
* To start local LWC dev server
    * ```sfdx force:lightning:lwc:start```
* assign permission set to user
    * ```sfdx force:user:permset:assign --permsetname <permset_name> -u <orgAliasOrUsername>```
    * i.e. ```sfdx force:user:permset:assign --permsetname Payments_Admin -u <orgAliasOrUsername>``` 
* Create a standard platform user
    * ```sfdx force:user:create -u orgf4v1 --setalias stduser --definitionfile config/std-user-def.json Username=dummystduser@litepae.ca```
    * with permission set assigned
    * ```sfdx force:user:create -u orgf4v1 --setalias stduser --definitionfile config/std-user-def.json permsets="Payments_Light" Username=dummystduser@litepae.ca```
* Retrieve some metadata components
    * ```sf project retrieve start --metadata "Flow:litepaeOffsessionCharge, Flow:litepaeCustomer, Flow:litepaePaymentMethods,Flow:litepaeCustomerWithPaymentMethodsAndCharge, CustomField:Contact.Stripe_Customer_Id__c, PermissionSet:Lite_Pae_EXT_permissions" -o <orgAliasOrUsername>```
* Retrieve source based on package.xml
    * ```sf project retrieve start --manifest manifest/package.xml -o <orgAliasOrUsername>```
* Deploy all components listed in a manifest:
    * ```sf project deploy start --manifest manifest/package.xml -o <orgAliasOrUsername>```
* Run the tests that aren’t in any managed packages as part of a deployment:
    * ```sf project deploy start --manifest manifest/package.xml --test-level RunLocalTests -o <orgAliasOrUsername>```

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
    * ```sfdx force:package:install -p <packageversionid> -u <org_alias> -s AdminsOnly```
* To uninstall a package
    * ```sfdx force:package:uninstall -p <packageversionid> -u me@example.com```
* Here's few sample comands
    * ```sfdx auth:web:login --setdefaultdevhubusername --setalias <dev-hub-alias>```
    * For Managed Packages:
        * ```sfdx force:package:create --name <packagename> --packagetype Managed --path "force-app" --targetdevhubusername <dev-hub-alias>```
        * ```sfdx force:package:version:create -p <packagename> --postinstallscript "PostInstall" -x```
        * ```sfdx force:package:version:promote --package "04t5e0dsfdsfdfs"```
    * For Unlocked Packages:
        * ```sfdx force:package:create -n <packagename>  -t Unlocked -r force-app```
            * ```sfdx force:package:create -n "Lite Pae UP Ext" -d "Unlocked Package with sample components to use/extend Lite Pae" -t Unlocked -r force-app```
        * ```sfdx force:package:beta:version:create -p "Lite Pae UP Ext" -x```
        * ```sfdx force:package:update -p "Your Package Alias" -n "New Package Name"```
            * or use package id ```sfdx force:package:update -p )ho... -d "New package description"```
* https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_create_pkg_ver_promote.htm
