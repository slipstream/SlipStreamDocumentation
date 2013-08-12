Authorization
=============

The *Authorization* tab allows you to set the authorization for this
module.

Note: groups are not yet supported in this version of SlipStream.

**Access types**

Access types are described as follow:

Read
:   Read (view) access to the module. By selecting this access type, the
    module becomes visible (accessible) to the group or all. It is not
    possible to de-select this access type for owner.

Write
:   Write (modify) right to the module. By selecting this access type,
    the module becomes editable to the group or all. It is not possible
    to de-select this access type for owner. Note that since most
    modules in SlipStream (i.e. Project, Machine Image, Disk Image,
    Deployment) are version controlled, saving a module will result in
    creating a new version of the module, without keeping all older
    versions.

Delete
:   Delete (remove) right to the module. By selecting this access type,
    the module can be deleted (removed) by the corresponding owner,
    group and/or all.

Execute
:   Execute (launch) right to the module. By selecting this access type,
    the module can be executed (i.e. images and disks can be created, as
    well as deployment executed) by the corresponding owner, group or
    all.


