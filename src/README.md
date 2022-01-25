![image](./logo.png)

The goal of Distributed CI (DCI) is to extend Red Hat production chain on partner platforms.


# Extension of the Red Hat production chain

In order to accelerate the delivery of Red Hat products and bring it closer to upstream releases, the Systems Engineering team work hard on continuous integration. Automation of tests upstream and downstream, QE tests. DCI is the last step of the production chain, extending the testing out to the environments that we care about the most. Our key partners and customers’ use cases. Running different products in their data center, using their gear, their specific configuration, and in some cases adding their own tests. This allows us to know how we are doing on a given release while we are building it. And alerts us when things don’t work out post release when releases come out. Did a change break our internal CI? Did it break on our partner’s environment? Did it break for everyone or just one? Troubleshooting and escalations are still happening, but there’s a lot less chatter about who did what and more about checking logs and fixing things.


# Certification

While we focused on accelerating our delivery of good products, partners had to certify their solution with those products in order to be able to sell it. Because we are already running automated tests to validate the product, it was logical to run the certification tests this way as well. With DCI you can now certify your hardware pre-release and see if bug fixes, security patches are not breaking your certification.

# Workflow

![image](./workflow.png)


# Terminology

Like every project, Distributed CI has its own terms with specific meanings. As understanding those terms is key to grasp how DCI works, here is an exhaustive list with their meanings.

## Product

A product is the main abstraction that describe a Red Hat product (RHEL, OpenStack, Openshift).

## Topic

A topic is a subset of a product. For example, RHEL8 or OSP10.

## Component

A component is an artifact (file, package, url, etc.) attached to a [topic](#topic). An [agent](#agent) take components in its workflow. Those components are immutable and regularly updated with newer versions of the artifact through a [feeder](#feeder).

## Feeder

A feeder is a script in charge of uploading newer versions of [components](#component) to the [control server](#control-server). They are run either event-based (new release) or schedule-based (e.g. once a day). [Components](#component) are created by the feeder.

## Agent

The core purpose of DCI is that given a set of [components](#component), an agent will pull them, install and run certification and validation tests.

An agent is a script (ansible, python, bash) that automates the installation of a [component](#component). We try to use the same agent for a given [product](#product). The agent is the result of collaboration between a partner and Red Hat. DCI offers one agent per [product](#product). It is up to the partner to put his automation.

## Job

A Job is the result of the run of an [agent](#agent) for a given [components](#component) by a specific [remote ci](#remote-ci).

## Control-Server

Distributed CI is a client/server application. The control server is the server part.

The control server is where the [components](#component), the [jobs](#job) and all the logs related to CI runs are stored and browsable. It is the central point of supervision to know the health of a given [product](#product) across all users. It also provides a modern web interface for users to browse the output of their Jobs.

## Remote CI

A platform and the production configuration. It belongs to a [team](#team). The platform can be physical, virtual or hybrid.

The remote ci will host the Agent, this service is in charge of the interactions with the [control server](#control-server) and the platform. A Remote CI is associated to a set of Topics.

## Team

A team represents a set of [users](#user).

## User

A User belongs to a [team](#team)