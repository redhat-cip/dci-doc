# Onboarding documentation

DCI is reserved for Red Hat partners. If you are not yet a Red Hat Partner, you can visit [Red Hat Connect](https://connect.redhat.com/) to become a Red Hat Partner.

## Speak with your EPM at Red Hat

The first step is to speak with your EPM (Engineering Partner Manager) or point of contact at Red Hat. He will organize a meeting between DCI and you to understand the need and present the DCI offer to you with more details.

You can prepare for this first meeting by logging into DCI with your Red Hat account. Go to the [DCI user interface](https://www.distributed-ci.io/) and click on the Login button. Your account is now created in DCI.

Following this meeting, your EPM will create your team and give you access to the product you need. You can now log back in to [https://www.distributed-ci.io/](https://www.distributed-ci.io/) and create your first remoteci.

> At this point during onboarding, check that you see the product(s) that interest you in the interface. You can click on products in the menu, or go to [https://www.distributed-ci.io/products](https://www.distributed-ci.io/products)

## Create your DCI jumpbox

Depending on what you're looking to do, the requirements for your jumpbox may vary. However, in all cases you will need a physical server or a virtual machine on which you will launch your agent.

You will refine the requirements during the presentation with the DCI team.

In any case, your jumpbox must be running the latest stable RHEL 8 release (8.4 or higher) and registered via RHSM. And you should have at least 160GB of free space available.

The jumpbox should have access to the internet.

## Create your first remoteci

A remoteci contains the information necessary for the authentication of your jumpbox. To create a remoteci, click on Remotecis in the menu on DCI UI, or go to [https://www.distributed-ci.io/remotecis](https://www.distributed-ci.io/remotecis) then click on the Create a new remoteci button.

The name of your remoteci does not matter. But if there are several of you working on the same jumpbox, give your remoteci an explicit name.

After creating your remoteci, copy the contents of the dcirc.sh file (Authentication column of your `remoteci > dcirc.sh > Copy to clipboard`), and save it on a file in your jumpbox (e.g. `~/dcirc.sh`).

## Install the DCI client on your jumpbox

[DCI client](../python-dciclient) is a python library and command line scripts which allows you to consult the server control API. The client is always installed by different agents. But to test our authentication file, we are going to install it by itself.

### Add the DCI repository

The first thing to do is to install the dci-release package which adds the DCI RPMs repository to your jumpbox repositories. It will add dci.repo in your dnf repositories.

On your jumpbox, execute the command:

```
dnf -y install https://packages.distributed-ci.io/dci-release.el8.noarch.rpm
```

### Install the DCI Client tool

To install the dciclient tool on your jumpbox, run the following command:

```
dnf -y install python3-dciclient
```

### Test your DCI client is working correctly

Add the authentication information in the environment variables by sourcing your dcirc.sh file, and list the products you have access to.

```
source ~/dcirc.sh
dcictl product-list
```

> If you don’t see the product(s) you see on the user interface, check your server is up to date (`timedatectl`) and verify that the `DCI_CLIENT_ID`, `DCI_API_SECRET` and `DCI_CS_URL` variables are in your environment.

You are now ready to install the agent for [RHEL](../dci-rhel-agent) or [OpenShift](../dci-openshift-agent)
