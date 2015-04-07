---
title: Candidate Releases
---

Results from each development iteration (sprint) are packaged into
candidate releases.  We welcome feedback on these releases; however,
these are **not** supported and **not** recommended for production
deployments.

## Development commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.6-community...master)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.6-community...master)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.6-community...master)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.6-community...master)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.6-community...master)  

## v2.6.1 (candidate) - 7 April 2015

### New features and bug fixes from v2.6

- UI critical bug fix: null pointer exception in the VMs section of dashboard
- UI bug fix: 'Undefined' incorrectly prepended to 'Provisioning' message

### Migration

No migration is required from v2.6 to v2.6.1.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.5...v2.6-community)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.5...v2.6-community)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.5...v2.6-community)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.5...v2.6-community)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.5...v2.6-community)

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

No migration is required from v2.5 to v2.6.

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.5...v2.6-community)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.5...v2.6-community)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.5...v2.6-community)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.5...v2.6-community)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.5...v2.6-community)  

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
 
     ```bash
     cd /opt/slipstream/server/migrations/
     python 012_edit_save_all_users.py <username> <password>
     ```
    `<username>` and `<password>` have to be credentials of a SlipStream administrator.

 4. Stop SlipStream
 
    ```bash
    service slipstream stop
    ```

 5. Stop HSQLDB (or your DB engine)
 
     ```bash
     java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost:9001/slipstream,user=sa,password= --sql 'SHUTDOWN;' 
     ```

 6. Execute the following SQL script */opt/slipstream/server/migrations/013_convert_to_keep_running.sql*:
 
     ```bash
     java -jar /opt/hsqldb/lib/sqltool.jar --inlineRc=url=jdbc:hsqldb:file:/opt/slipstream/SlipStreamDB/slipstreamdb,user=sa,password= /opt/slipstream/server/migrations/013_convert_to_keep_running.sql
     ```

 7. Start HSQLDB (or your DB engine)
 
    ```bash
    service hsqldb start # ignore start error
    ```

 8. Start SlipStream
 
    ```bash
    service slipstream start
    ```

### Commits

[Server](https://github.com/slipstream/SlipStreamServer/compare/v2.4.2...v2.5-community)  
[UI](https://github.com/slipstream/SlipStreamUI/compare/v2.4.2...v2.5-community)  
[Client](https://github.com/slipstream/SlipStreamClient/compare/v2.4.2...v2.5-community)  
[Connectors](https://github.com/slipstream/SlipStreamConnectors/compare/v2.4.2...v2.5-community)  
[Documentation](https://github.com/slipstream/SlipStreamDocumentation/compare/v2.4.2...v2.5-community)  
