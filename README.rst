==================================================================
Common workflow language tool description reference implementation
==================================================================

CWL Conformance test: |Build Status|

THIS PACKAGE CONTAINS A PATCHED RELEASE OF CWLTOOL; IT IS NOT THE
STANDARD CWLTOOL THAT IS PART OF THE REFERENCE IMPLEMENTATION OF THE 
COMMON WORKFLOW LANGUAGE

The patched version of cwltool creates a mount point to the host
docker.sock and a mount point to /datastore in calls to docker run.
This enables containers to start up containers on the host and provides
/datastore as a known accessible location to store data.


This is written and tested for Python 2.7.

The "cwltool" package
is the primary Python module containing the reference implementation in the
"cwltool" module and console executable by the same name.

Install
-------

  pip install cwltool

To install from source::

  git clone https://github.com/BD2KGenomics/cwltool-docker-host-docker
  cd cwltool && python setup.py install


Run on the command line
-----------------------

Simple command::

  cwltool [tool-or-workflow-description] [input-job-settings]

Import as a module
----------------

Add::

  import cwltool

to your script.

Use with boot2docker
--------------------
boot2docker is running docker inside a virtual machine and it only mounts ``Users``
on it. The default behavoir of CWL is to create temporary directories under e.g.
``/Var`` which is not accessible to Docker containers.

To run CWL successfully with boot2docker you need to set the ``--tmpdir-prefix``
and ``--tmp-outdir-prefix`` to somewhere under ``/Users``::

    $ cwl-runner --tmp-outdir-prefix=/Users/username/project --tmpdir-prefix=/Users/username/project wc-tool.cwl wc-job.json

.. |Build Status| image:: https://ci.commonwl.org/buildStatus/icon?job=cwltool-conformance
   :target: https://ci.commonwl.org/job/cwltool-conformance/

Tool or workflow loading from remote or local locations
-------------------------------------------------------

``cwltool`` can run tool and workflow descriptions on both local and remote
systems via its support for HTTP[S] URLs.

Input job files and Workflow steps (via the `run` directive) can reference CWL
documents using absolute or relative local filesytem paths. If a relative path
is referenced and that document isn't found in the current directory then the
following locations will be searched:
http://www.commonwl.org/v1.0/CommandLineTool.html#Discovering_CWL_documents_on_a_local_filesystem
