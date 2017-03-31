Autoscalable Applications
=========================

`Scalable Applications <scalable-applications.html>`_ described how it is
possible to define and manually manage the scaling of applications with
SlipStream.  This section presents the mechanisms and the accompanying
infrastructure in SlipStream that allows to auto-scale such applications.

With SlipStream one can automatically scale up and down the number of instances
of an application component of a (possibly) complex application. Currently only
one component can be scaled at a time. Work to remove this limitation is
ongoing. There are two ways to take advantage of auto-scaling with the existing
SlipStream implementation:

-  **Black-box autoscaling** The simplest approach is to use the default
   implementation of the auto-scaling in SlipStream. Currently, it is suitable
   for the applications where the only one component will scale based on only
   one metric. If these requirements are met, adding a special autoscaler
   component to the user’s application, providing configuration file with the
   application component scalability constraints, and deploying the application
   as a scalable deployment allows user to benefit from the automated
   scalability provided “out of the box” by SlipStream.

-  **Do-it-yourself (DIY) autoscaling** The implementation of the autoscaler in
   SlipStream allows users to supply their own implementations of the
   autoscaling logic. In this case, SlipStream takes care of the deployment of
   the autoscaler platform and running the user supplied auto-scaling logic.
   What is required from the user is the inclusion of the autoscaler in the
   user’s application as a component and providing a public URL with the
   autoscaling implementation.

In the above cases, it is required that chosen components of the user’s
application publish metrics on which the scaling actions will be based and to
support the automatic scaling.

SlipStream uses Riemann_ to implement its auto-scaling decision making feature
and consequently requires that the metrics be published as Riemann events. To
facilitate metrics collection, Riemann has a wide range of `metric publishers
<http://riemann.io/clients.html>`_; these include a Riemann plugin for
Collectd_ and a Python CLI and library API.

The implementation of the autoscaler in SlipStream is completely open and
flexible. It allows users to write their own decision making logic as Riemann
streams and to provide it to the autoscaler component as an input parameter.
This can be useful in cases when the default autoscaling implementation, that
comes with the SlipStream autoscaler, does not fully satisfy the needs of the
user’s application.

Configuration of Auto-scale Constraints
---------------------------------------

Below is the example configuration file (in `edn
<https://github.com/edn-format/edn>`_ format) to be used
with the black-box autoscaling approach. The configuration defines scalability
constraints for an application component called ``webapp``::

    [
     {
      ;;
      ;; Mandatory parameters.

      ; name of the component in the application
      :comp-name         "webapp"

      ; service tags as sent by Riemann publisher in the event
      :service-tags      ["webapp"]

      ; monitored service metric name (as sent with Riemann event)
      :service-metric    "avg_response_time"

      ; value of the metric after which start adding component instances
      :metric-thold-up   500.0
      ; value of the metric after which start removing component instances
      :metric-thold-down 200.0

      ; max number of component instances allowed
      :vms-max           4   ; "Price" constraint.

      ;;
      ;; Optional parameters (with defaults).

      ; min number of component instances allowed
      ;:vms-min       1

      ; number of instances by which to scale up
      ;:scale-up-by   1
      ; number of instances by which to scale down
      ;:scale-down-by 1
     }
    ]

It reads the following way:

    1.  For an application component ``webapp`` the autoscaler expects to receive
        Riemann events:

        1.  with the service name ``avg_response_time``,
        2.  one of tags being ``webapp``;

    2.  When the value of the metric in the event is

        1.  above ``metric-thold-up`` (500.0), then the autoscaler should
            perform a scale up action,
        2.  below ``metric-thold-down`` (200.0), then the autoscaler should
            perform a scale down action;

    3.  The autoscaler should not perform scale up action if there are already
        ``vms-max`` (4) component instances running,

    4.  The minimum number of component instances should not go below
        ``vms-min``.  That is, the autoscaler should not attempt a scale
        down action if the number of the currently running component
        instances is ``vms-min`` (1),

    5.  The autoscaler should scale up by ``scale-up-by`` number of instances
        and scale down by ``scale-down-by``.

.. _Riemann: http://riemann.io

.. _Collectd: https://collectd.org
