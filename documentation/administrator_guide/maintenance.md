---
title: Maintenance
---

SlipStream, as for every service, needs proper care and feeding!
This chapter provides some information about best practices for this
service.

## Activity Overview

When logged in as an administrator, you can get an overview of all
running deployments and virtual machines by visiting the dashboard.
Just click on the "dashboard" icon at the top of the page. 

## Log Files

The service log files are located in `/opt/slipstream/server/logs`.
These are named by date and rotated daily (or when the service is
restarted).  You should regularly review errors in the log to see if
there are configuration or resource problems. 

## Database Backups

The real value of a SlipStream instance is in the defined images and
deployments.  These and a full history are kept in the HSQLDB
database.  This database should be backed up regularly to avoid having
any of this valuable information lost.

## Maintenance mode

SlipStream can be set in maintenance mode to prevent users to access it and to display an explanatory message instead.
Moreover the properly HTTP code ([503](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html#sec10.5.4)) will be returned so that search engines can handle that case correctly.

##### Enable the maintenance mode

To enable the maintenance mode, edit the file `/etc/nginx/conf.d/slipstream-extra/maintenance.map`.
On this file, you can define which IPs are affected or not by the maintenance mode.

Then execute the following command:
```bash
service nginx reload
```
