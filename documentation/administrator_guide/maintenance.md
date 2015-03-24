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
