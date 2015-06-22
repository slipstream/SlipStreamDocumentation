---
title: Candidate Releases
---

Results from each development iteration (sprint) are packaged into
candidate releases.  We welcome feedback on these releases; however,
these are **not** supported and **not** recommended for production
deployments.

## Development commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.11-community...master)  
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.11-community...master)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.11-community...master)  
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.11-community...master)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.11-community...master)  

## v2.11 (candidate) - 22 June 2015

### New features and bug fixes in v2.11

- users can now receive daily cloud usage emails (turn on via
  parameter in user profile)
- extend server for better support of application scaling
- allow cloud contextualization method to be chosen via connector
  configuration
- SlipStream server now requires Java 1.8 (previous versions are EOL);
  the code base will now start using Java 1.8 features
- fix: handling of open subsection in URL 
- fix: catch EINTR interrupt to prevent script failures on Windows
- fix: invalid URL when clicking on VM gauge in dashboard
- fix: problem with scaling scripts not being called on scaling
  actions 
- fix: various browser issues with embedded SlipStream tour

### Migration

**TDB**: A database migration is required from v2.10 to v2.11!!

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.10-community...v2.11-community) 
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.10-community...v2.11-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.10-community...v2.11-community) 
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.10-community...v2.11-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.10-community...v2.11-community)

## v2.10 (candidate) - 7 June 2015

### New features and bug fixes in v2.10

- interactive tour available through SlipStream interface (beta)
- clicking on dashboard gauges opens the corresponding cloud section
- allow event and usage resources to be filtered
- disallow changes to parameter types through UI to be consistent with
  server 
- improve contextualization mechanisms for Windows
- allow admins to choose contextualization method used for a cloud
- fix: dashboard gauges incorrectly rendered in some cases
- fix: wrong version comment sometimes displayed for module
- fix: module logo is not displayed
- fix: Windows deployments intermittently fail
- fix: "noscript" message was not working when JavaScript 

### Migration

A database migration from v2.9 to v2.10 is not needed.

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.9-community...v2.10-community) 
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.9-community...v2.10-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.9-community...v2.10-community) 
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.9-community...v2.10-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.9-community...v2.10-community)

## v2.9 (stable) - 18 May 2015

### New features and bug fixes in v2.9

- only allow configured clouds to be used in UI
- provide pagination of event and usage resources
- package scripts for preparing usage summaries
- reduce resource requirements for collected metrics
- patch timezone handling bug in UI
- fix storage of service configuration enum parameters
- remove unnecessary dependencies in build artifacts

### Migration

A database migration from v2.8 to v2.9 is not needed.

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.8-community...v2.9-community) 
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.8-community...v2.9-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.8-community...v2.9-community) 
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.8-community...v2.9-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.8-community...v2.9-community)

## v2.8 (candidate) - 29 April 2015

### New features and bug fixes in v2.8

- allow connectors to indicate when a VM is usable (for usage records)
- improve logging (more concise messages, longer retention times)
- provide quick installation script with documentation of procedure
- provide "event" resource with standard lifecycle events
- expose "usage" summary as a resource
- updated advanced tutorial for current release
- fix bug which prevented deployments from being saved
- fix bug which erased parameters starting with "http://"
- fix deadlock associated with multiple database clients
- fix run ordering by time
- fix truncation of fields hiding information (popovers used everywhere)
- improve rendering of errors to make the cause more visible

### Migration

**Database migration is required from v2.7 to v2.8. The following
  steps MUST be followed:**

1. Upgrade SlipStream
2. Stop SlipStream
 
        $ service slipstream stop

3. Stop HSQLDB (or your DB engine)
 
        $ service hsqldb stop

6. Execute the following SQL script */opt/slipstream/server/migrations/014_enumvalues_size_fix.sql*:
 
        $ java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/014_enumvalues_size_fix.sql

7. Start HSQLDB (or your DB engine)
 
        $ service hsqldb start

8. Start SlipStream
 
        $ service slipstream start

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.7-community...v2.8-community) 
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.7-community...v2.8-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.7-community...v2.8-community) 
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.7-community...v2.8-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.7-community...v2.8-community)

## v2.7 (stable) - 15 April 2015

### New features and bug fixes from v2.7

- Bug fixes for launching and accessing Windows virtual machines
- Support for v5.5 of vCloud API
- Allow input parameters to be specified for simple image run to avoid
  having to create a deployment for this
- Add back App Store to the image chooser
- Add custom error pages for SlipStream frontend proxy
- Make forward/backward navigation more natural (avoid URLs with
  fragment changes in history)
- Improve rendering of tables on mobile devices 

### Migration

No migration is required from v2.6.1 to v2.7.

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.6.1-community...v2.7-community) 
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.6.1-community...v2.7-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.6.1-community...v2.7-community) 
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.6.1-community...v2.7-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.6.1-community...v2.7-community)

## v2.6.1 (stable) - 7 April 2015

**This release has been promoted to a stable release.**

### New features and bug fixes from v2.6

- UI critical bug fix: null pointer exception in the VMs section of dashboard
- UI bug fix: 'Undefined' incorrectly prepended to 'Provisioning' message

### Migration

No migration is required from v2.6 to v2.6.1.

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.6-community...v2.6.1-community)  
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.6-community...v2.6.1-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.6-community...v2.6.1-community)  
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.6-community...v2.6.1-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.6-community...v2.6.1-community)

## v2.6 (candidate) - 2 April 2015

### New features and bug fixes from v2.5

- Expose event resource
- Allow usage notes to be added to image and deployment modules
- Filter VMs by User (for administrator) and by Run Owner
- Add more node information in VM resources (UI and XML)
- Allow input parameters for simple run
- Allow 
- Improvements to VMs resource: additional node information, ability
  to filter by User/Run Owner/Run UUID
- Ability to run an image with installation scripts even if the image
  has not been built.
- Ensure that a module "copy" operation copies all fields
- Fix for time zone parsing error
- Ensure build image operation works 
- Fix bugs in v2.5 that caused SlipStream to stop responding to
  requests and that caused ready applications to be moved to
  "finalizing" incorrectly
- Improve standard example applications: Ubuntu Standalone, CentOS
  Standalone, Wordpress, and LAMP++
- Improve monitoring of service with collectd
- Ensure time is aligned between SlipStream services by adding ntpd to
  SlipStream deployments
- Move documentation to dedicated server and remove the embedded
  documentation from the SlipStream server
- Numerous UI improvements: disactivating buttons when actions are not
  allowed, display user-friendly state in dashboard, improvements for
  touch devices, fix wrapping of fields on small devices, improve
  organization of sections in user profile

### Migration

You have to execute the following script (while HSQLDB is running) to do the BD migration:

    java -jar /opt/hsqldb/lib/sqltool.jar --autoCommit --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql "UPDATE VmRuntimeParameterMapping SET hostnameRuntimeParameterUri = CONCAT(REGEXP_SUBSTRING(vmstateRuntimeParameterUri,'^[^:]+'),':hostname') WHERE hostnameRuntimeParameterUri IS NULL;"

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.5-community...v2.6-community)  
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.5-community...v2.6-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.5-community...v2.6-community)  
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.5-community...v2.6-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.5-community...v2.6-community)  

## v2.5 (candidate) - 20 March 2015

### New features and bug fixes from v2.4.2 (stable)

- Added the Event server
- Improved authorization mechinisme
- Improved logging
- Improved the collector
- Improved stability of the /vms resource when there is a huge amount of VMs
- Improved the Run dialog on the UI:
  - The Cloud for all node can be selected at one place
  - The two checkboxes in the user profile to define the `keep running` behaviour was converted into a dropdown menu
  - The `keep running` behaviour can be redefined
  - Tags can be defined when creating a Run.
  - The value selected for `Cloud` and `Keep running` dropdown menus correspond to the default of the user profile. 
  - It's now possible to create a Run even if there is no SSH key in the user profile
  - An error is displayed if SSH access is asked but there is no key in the user profile
- Improved the time needed to terminate VMs with `stratuslabiter-terminate-instances`.
- Increased the maximum amount of items returned by /vms and /run to 500
- New packaging for the community edition.
- Fixed a bug where deployment scripts were not executed when running a simple image.
- Bugfixes

### Migration

**IMPORTANT: v2.5 requires data migration from v2.4.2. The following
  steps MUST be followed:**

1. Upgrade SlipStream
2. Ensure SlipStream is running
3. Execute the following python script *012_edit_save_all_users.py*
   from the directory */opt/slipstream/server/migrations/*

        $ cd /opt/slipstream/server/migrations/
        $ python 012_edit_save_all_users.py <username> <password>

    `<username>` and `<password>` have to be credentials of a SlipStream administrator.

4. Stop SlipStream
 
        $ service slipstream stop

5. Stop HSQLDB (or your DB engine)
 
        $ ss-db-shutdown

6. Execute the following SQL script */opt/slipstream/server/migrations/013_convert_to_keep_running.sql*:
 
        $ java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/013_convert_to_keep_running.sql

7. Start HSQLDB (or your DB engine)
 
        $ service hsqldb start # ignore start error

8. Start SlipStream
 
        $ service slipstream start

### Commits

  - [Server](https://github.com/slipstream/SlipStreamServer/compare/v2.4.2...v2.5-community)  
  - [UI](https://github.com/slipstream/SlipStreamUI/compare/v2.4.2...v2.5-community)  
  - [Client](https://github.com/slipstream/SlipStreamClient/compare/v2.4.2...v2.5-community)  
  - [Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.2...v2.5-community)  
  - [Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.2...v2.5-community)  

## v2.4.2 (stable) - 28 February 2015

**This release has been promoted to a stable release.**

For this and previous stable releases see the "Stable Releases" page.


