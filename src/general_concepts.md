# General concepts

How DCI works is a little different from the CI tools we use today like Jenkins or Github Actions. DCI is a toolbox composed of RPMs, plugins and Ansible roles. The goal is simple: to make it easier to install Red Hat products before they are released to the market, so you can test your hardware and products in advance.

DCI tools retrieve information about your continuous integration to display it on a user interface. You can use this interface and the CI jobs that are displayed to communicate with engineers or support at Red Hat. Only you and the engineers have access to your jobs.

## In concrete terms, how does DCI work ?

You will need a server with RHEL installed on it (it should work with Centos Stream, but for the sake of simplicity we are only talking about RHEL in this documentation).

We call this server the **jumpbox**. This can be a physical machine or a virtual machine. For exact requirements, please refer to the corresponding section for the tool in the documentation.

On this jumpbox we install the RPMs necessary for downloading and launching your continuous integration jobs. The tool we use to download, install and test RHEL or Openshift is called an **agent**. You have one agent per product. You will install the necessary agent on your jumpbox (i.e. dci-rhel-agent or dci-openshift-agent)

All agents need to be configured. There is a configuration common to all agents which we will detail below. This configuration is used to secure communication between the agent and the control server on which CI jobs are saved. To verify the identity of your server, protect in-transit data and forbid the reuse of the signed requests, we use HMAC v4 auth from AWS and HTTPS to protect the communication between your agent and the **control server**.

The other part of the configuration is agent-specific, and changes depending on the Red Hat product you are using.


## Secure communication between the agent and the control server

Each time you run a DCI tool that communicates with the control server, the latter will look for 3 environment variables (`DCI_CLIENT_ID`, `DCI_API_SECRET` and `DCI_CS_URL`). These variables are saved in a **dcirc.sh** or **credentials.yaml** file. These variables are attached to a resource called a **remoteci**. You create a remoteci on the user interface (We explain this in more detail in the [get started](get_started) documentation) and you save the variables into the dcirc.sh or credentials.yaml file on your jumpbox.

Often there is only one remoteci per jumpbox. But if you are several engineers working on the same jumpbox, you can have several remotecis. You will launch the correct file before launching an agent (for example: `source /etc/dci-rhel-agent/dcirc.sh && dci-rhel-agent-ctl start`)

## Run a DCI job with the agent

After the onboarding, you will install the rpm of the agent that interests you. You will configure your authentication file on your jumpbox. You will configure the agent so that it installs RHEL or OpenShift on your environment. This is often the most complicated part. Then you will launch a DCI job. Unlike CI tools, it is the client who initiates the execution of a job. You can run a job manually at the beginning, and then run a job every day via a Systemd command or a cron.

When you run an agent, behind the scenes it launches an Ansible playbook. To avoid making this documentation too complex, know that the execution is done either directly with Ansible installed on the jumpbox, or in a DCI container in which Ansible is installed.
As you are familiar with Ansible, you will not be surprised to see that the standard output of a DCI job corresponds to the standard output of an Ansible run.

## Understand Product > Topic > Component in DCI

When you launch a job, you always specify either the topic or the component that interests you in the configuration of your agents. It is interesting to understand this concept.

If you are familiar with RHEL or OpenShift, you are certainly familiar with the concept of stream. The **product** is regularly updated during its life cycle, and updates are associated with a minor version of the product. For example RHEL-9.2, RHEL 9.4, OCP 4.12, or OCP-4.14.
In DCI, a **topic** represents a minor version of the product. You will find for example the RHEL-9.2 topic or the RHEL-9.4 topic associated with the RHEL product.

A component corresponds to a given version of the product over time. For example in RHEL you will have multiple nightlies following the stream, one nightly being a component (e.g. `RHEL-9.4.0-20231013.18`)

| Product | Topic | Component |
| --- | --- | --- |
| RHEL | RHEL-9.4 | RHEL-9.4.0-20231013.18 |
| OpenShift | OCP-4.16 | OpenShift 4.16 nightly 2024-01-31 07:38 |

## Customizing a DCI job with hooks

Even though agents are very configurable, we have a way to easily customize the execution of an agent with a mechanism called hooks.

A DCI job is often divided into several steps (new/pre-run/running/post-run):

* In the **new** step, we build the job on the control server and attach the right component of the product (more on this later).
* In the **pre-run** step, we prepare the environment, we check that the state of the jumpbox is correct.
* In the **running** step, we will install the product (RHEL or OpenShift).
* In the **post-run** step, we will launch tests on Red Hat products. Automatic hardware pre certification is also run at this step.

To customize your job, you will create different hooks (`pre-run.yml`, `install.yml`, `post-run.yml`, etc). A hook is an ansible playbook. The agent launches the hook during a DCI job. For example, in `hooks/install.yml` you can add your ansible code to install your product on top of the Red Hat product. And in the `hooks/post-run.yml` hook, you can add your tests to test your product running on RHEL or OpenShift.

# DCI value proposition

Ok I understood, I ran an agent to install the Red Hat product and I created some hooks to install my product. Is that all I get?

Automating the installation of products like RHEL or OpenShift on hardware can be a complicated task. DCI works with quality engineers at Red Hat. We develop tools and Ansible roles, to facilitate the installation of our products. **By using DCI you reuse what already exists**. You go faster to build continuous integration.

Today you can test our products when the beta is available. With DCI you have **access to all nightlies** that pass our CI internally. You can test versions during their development phase. Which was not possible so easily before.

As you have access to the latest versions of the product, you can test updates from one major version to another in advance. For example you can very well launch a job to test the installation of OpenShift in stable version, then launch another job to update with the latest nightly. You can very well imagine launching different jobs to test different versions of your product (the stable version and the development version).

Whenever you want to take advantage of the full potential of DCI, we recommend that you use another tool that we developed called **dci-pipeline**. You can consult its more [detailed documentation](../dci-pipeline). But basically, DCI Pipeline is a tool that allows you to organize your DCI jobs and group them together. Thanks to the pipeline you will be able to test complex continuous integration scenarios.

To give you an example that will perhaps speak more. We have a pipeline in our internal CI to test an OpenShift nightly. As soon as nightly is available, we launch the installation and run our tests. If the installation fails, we launch a second fallback job to install the latest stable version to verify that the problem is not in the CI scripts, but more on the nightly itself. Depending on the result of this installation, we qualify the nightly. If the installation and testing of the nightly works, then we will launch an update in a second phase with the next major version of OpenShift.

Finally, if you have limited resources to launch your CI, we have also developed the [DCI Queue](../dci-pipeline) tool to queue jobs and use the most of available resources.
