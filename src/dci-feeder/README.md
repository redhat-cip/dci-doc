# Feeders

A Feeder is a script in charge of uploading newer versions of Components to the Control-Server. They are run either event-based (new release) or schedule-based (e.g. once a day). Components are referenced via a Jobdefinition as created by the Feeder.

Various Feeders can be configured to monitor for the creation of new artifacts. When a new artifact is available, the feeder can then upload the artifact as a Component to the DCI Control-Server and make a Jobdefinition available to the Agents so that they can create and execute a new job.

DCI doesn't have a bias towards where the artifact comes from, so scripts can be easily created using the `dciclient` library.

## Installing Feeders

Installing the available feeders is as simple as installing the dci-feeders RPM.:

    $ sudo yum install dci-feeders -y

## Setting Up Feeders

### Configuring DCI Control-Server

On the DCI Control-Server, we need to create a team, create a new topic for that team, and then attach the newly created topic to the team. We'll be doing this via the `dcictl` application.

You can install the `dcictl` application via the `python2-dciclient` or `python3-dciclient` package.

Next we'll be doing the following things

 * Create a team
 * Create a topic
 * Attach a topic to a team

#### Setup environment

To make things easier on ourselves, we're going to setup the environment so that we don't need to pass multiple flags to `dcictl` in order to connect and login to the API server.

The following environment variables are available to us to save us some time:

 * `DCI_LOGIN` (equivalent `--dci-login`)
 * `DCI_PASSWORD` (equivalent `--dci-password`)
 * `DCI_CS_URL` (equivalent `--dci-cs-url`)

You can export these variables or place them into your shell RC file (e.g. `~/.bashrc`) to save superfluous typing.

Example:

    export DCI_LOGIN=admin
    export DCI_PASSWORD=admin
    export DCI_CS_URL='http://127.0.0.1:80'

When done, source the file via `source ~/.bashrc` to load them into memory.

#### Create a team

Let's create a new team for our feeder. If you've previously created a team then you can skip this step.

    dcictl team-create --name testing_team
    +------------+--------------------------------------+
    |  Property  |                Value                 |
    +------------+--------------------------------------+
    | created_at | 2016-03-10T17:59:55.400292           |
    | etag       | 277a7c68108a462b4840ae0f3282b628     |
    | id         | 9db7f0c7-d7b8-473e-9e36-2e66ea0b1c6e |
    | name       | testing_team                         |
    | updated_at | 2016-03-10T17:59:55.400308           |
    +------------+--------------------------------------+

Note the `id` field of the team. You can get this information again via:

    dcictl team-list

The `etag` field is the entity tag, which changes whenever the resource data is updated. In order to update various resources on the DCI Control-Server, you will need this `etag` value.

#### Create a topic

Topics are a way of allowing a one-to-many relationship across multiple teams and remote CI nodes.

When a feeder discovers a new artifact, this is communicated to the DCI Control-Server by creating a new *component*. When a component is created, a new *jobdefinition* is created, and both of those are associated against the topic that the feed is configured for.

Lets create a new topic called `testing`:

    dcictl topic-create --name testing
    +------------+--------------------------------------+
    |  Property  |                Value                 |
    +------------+--------------------------------------+
    | created_at | 2016-03-10T18:30:07.090010           |
    | etag       | a1cbda432e24f113f2d5e173ce64e1a2     |
    | id         | be660493-8a69-4a53-8fc3-14545e6f9d85 |
    | name       | testing                              |
    | updated_at | 2016-03-10T18:30:07.090084           |
    +------------+--------------------------------------+

#### Attach a topic to a team

By attaching a team to a topic, you are stating that you want to be notified of new *jobdefinitions* associated with that topic. The nice side-effect of utilizing topics, is that you can also have multiple teams subscribed to changes of that topic, and get a wide range of tests performed through the creation of a single artifact.

Lets assign our newly created team `testing_team` to the `testing` topic:

    dcictl topic-attach-team \
        --id be660493-8a69-4a53-8fc3-14545e6f9d85 \
        --team_id 9db7f0c7-d7b8-473e-9e36-2e66ea0b1c6e

    +----------+--------------------------------------+
    | Property |                Value                 |
    +----------+--------------------------------------+
    | team_id  | 9db7f0c7-d7b8-473e-9e36-2e66ea0b1c6e |
    | topic_id | be660493-8a69-4a53-8fc3-14545e6f9d85 |
    +----------+--------------------------------------+

We can view the list of teams associated with the topic via:

    dcictl topic-list-team --id be660493-8a69-4a53-8fc3-14545e6f9d85

### Connecting a Feeder to DCI Control-Server

Next we need to attach the feeder to the DCI Control-Server to allow it to create components for us when a new artifact is found. The following will be configured on your remote CI server (for demonstration purposes), but in a typical production setup you would deploy this in it's own separate node.

#### Configuring the Github Feeder

A few different feeders exist in the [python-dciclient](http://github.com/redhat-cip/python-dciclient) repository. We're going to look at the Github feeder as it's a simple implementation to look for new commits on a Github repository and create new Jobdefinitions within the DCI Control-Server.

We're going to use the Github feeder to monitor for new commits to a repository. Feeders are available in the `/usr/bin/` directory, typically prefixed with `dci-feeder`.

##### Setting up a new user

The DCI feeder takes the same environment variables (and flags) as the `dcictl` command does. Before we setup our environment variables however, lets create a new user on the DCI Control-Server that we can authenticate against within our new `testing_team`.

    dcictl user-create --name remoteci_1 \
        --password welcome \
        --role user \
        --team_id 9db7f0c7-d7b8-473e-9e36-2e66ea0b1c6e

    +------------+--------------------------------------+
    |  Property  |                Value                 |
    +------------+--------------------------------------+
    | created_at | 2016-03-10T18:46:17.349491           |
    | etag       | 30768cbc5ead17c76d598282bbcb6f43     |
    | id         | 66f08830-4500-43b6-be41-5605b765eb6c |
    | name       | remoteci_1                           |
    | role       | user                                 |
    | team_id    | 9db7f0c7-d7b8-473e-9e36-2e66ea0b1c6e |
    | updated_at | 2016-03-10T18:46:17.349509           |
    +------------+--------------------------------------+

We've configured a new user called `remoteci_1` with the role of `user` within the `testing_team`. Let's test our agent by connecting to the DCI Control-Server at the console.

The user namespace is flat, so you can't have duplicate usernames across multiple teams.

##### Connecting to an artifact resource

In order to create a new *component* and *jobdefinition* on the DCI Control-Server, we need to connect to a resource that will provide us the artifact. Using a simple Github repository is sufficient for this. First, get the repository that you want to monitor. You can do this via the *copy* icon on the status bar at the top of any repository.

Be sure to remove the `.git` extension from the URL or else you'll get an error from the DCI Control-Server

Let's pass the Github URL along with our topic ID and login information to the `dci-feeder-github` application.

    /usr/bin/dci-feeder-github \
        --dci-cs-url 'http://api.nfvci.int' \
        --dci-login remoteci_1 \
        --dci-password welcome \
        --dci-topic-id be660493-8a69-4a53-8fc3-14545e6f9d85 \
        --github-url http://github.com/redhat-cip/python-dciclient

We pass several flags to the `dci-feeder-github` application in order to authenticate and connect to our DCI Control-Server. The `--dci-topic-id` contains the `topic_id` value we created earlier The `--github-url` flag is the URL for our artifact source.

You'll notice that we've used `http://api.nfvci.int` as our hostname for the DCI Control-Server. When you configured the DCI Control-Server initially (especially if you used the [dci-infra](https://github.com/redhat-cip/dci-infra) Ansible playbook) you would have provided a hostname that the API would be hosted under, handled via an Apache VirtualHost configuration.

If you don't have a world routable IP address and hostname, you can add the hostname to your /etc/hosts file in order to allow it to work from your remote CI server over your LAN.

After running the `dci-feeder-github` command, your console should have returned with something like the following:

    Use test 'python-dciclient - f032061de28b8f9e16767ff6b51307596c0ba648'
    Create component 'python-dciclient - f032061de28b8f9e16767ff6b51307596c0ba648',
    type 'git_commit'
    Jobdefinition 'python-dciclient - f032061de28b8f9e16767ff6b51307596c0ba648'
    created.

##### Validation

We can validate that our *component* and *jobdefinition* were created by using the `dcictl` console application.

You'll need to install the `dcictl` application on the remote CI server before running the following command. See [Configuring DCI Control-Server]() for a refresher on which package to install.

Check *jobdefinition* list:

    dcictl \
        --dci-login remoteci_1 \
        --dci-password welcome \
        jobdefinition-list --topic_id be660493-8a69-4a53-8fc3-14545e6f9d85

Check *component* list:

    dcictl \
        --dci-login remoteci_1 \
        --dci-password welcome \
        component-list --topic_id be660493-8a69-4a53-8fc3-14545e6f9d85

##### Running a feeder using systemd

Now that we've validated our feeder, we can instantiate the feeder from **systemd** instead of running things manually on the console. When the feeders are installed from the RPM, systemd unit files are also installed. These systemd unit file templates allow you to instantiate one or more feeders, and set them up to run periodically.

Our Github systemd unit file is located in `/usr/lib/systemd/system/` as files `dci-feeder-github@.service` and `dci-feeder-github@.timer` which are the templates for scheduling one-off and periodic feeder runs (respectively).

**Using Systemd Templates**

When using systemd templates, you pass an argument to the template, such as a filename containing environment variable information. The format for this argument is a bit unique, which can take some getting used to.

Inside the template are markers that get replaced during unit creation. In the case of the `dci-feeder-github` templates, the markers `%i` and `%I` are utilized. The lowercase version is replaced with the characters passed into the unit file between the `@` and the suffix of the unit name. The uppercase version is the same value, unescaped.

As the escaping sequence can be a bit strange, we'll make use of the `systemd.escape` application to automatically build our escaped filenames for us. See [systemd.unit](https://www.freedesktop.org/software/systemd/man/systemd.unit.html) for more information.

To setup our feeders with systemd, we need to first create a file to hold our environment variables so that the template understands where to look for information that will get passed to the feeder application. For the Github feeder, these are located in the `/etc/sysconfig/dci-feeder-github/` directory.

Next we name the environment file based on the Github repository we're going to monitor. We'll make use of the `systemd-escape` command which will convert the repository name into the correct format.

The way the escaping works (with it being passed to the unit template file, and then back out when it attempts to read the `EnvironmentFile` value), can get pretty confusing. We're going to eliminate some of the manual changes that would be required through a simple bash oneliner.

We only need the organization and repository name from the Github URL (rather than the whole Github URL). For example, if we wanted to create a *component* and *jobdefinition* for <https://github.com/redhat-cip/dci-infra>, we'd only need the `redhat-cip/dci-infra` portion of the URL.

Let's pass this to the `systemd-escape` command and see what our escaped repository looks like:

    systemd-escape redhat-cip/dci-infra
    redhat\x2dcip-dci\x2dinfra

The next step is to create an environment file that contains the login information for our DCI Control-Server and the topic ID we want to associate the component and jobdefinition to. As noted earlier the format of the filename is particular, but we have a simple script we can run that will take some of the guesswork out of the file naming.

    cd /etc/sysconfig/dci-feeder-github/
    touch $(systemd-escape redhat-cip/dci-infra | tr -d \\)

Our resulting filename will be `redhatx2dcip-dcix2dinfra`, which is the same as our escaped output, but without the backslashes.

Now we can modify the file and add the following environment variables:

 * `DCI_CS_URL`
 * `DCI_LOGIN`
 * `DCI_PASSWORD`
 * `DCI_TOPIC_ID`

As before, set these values to your DCI Control-Server URL, login name, login password, and topic ID (to associate this feeder with).

The last step is to pass this file to the systemd unit template, and create our component and jobdefinition.

    systemctl start 'dci-feeder-github@redhat\x2dcip-dci\x2dinfra.service'

The service unit filename has been passed to `systemctl` in single quotes in order to automatically escape the backslashes.

After running this command, if you don't have any errors, you should be able to validate that your component and jobdefinition were created on the DCI Control-Server. (See [Validation]() for more information.)

If you want to run this periodically on a timer, replace `.service` in the `systemctl` command with `.timer`. You can list the timed services with `systemctl list-timers`.

    systemctl list-timers
    NEXT                         LEFT          LAST  PASSED  UNIT                                               ACTIVATES
    Tue 2016-03-15 00:10:00 UTC  5h 18min left n/a   n/a     dci-feeder-github@redhat\x2dcip-dci\x2dinfra.timer dci-feeder-github@redhat\x2dcip-dci\x2dinfra.service

##### Next steps

Now that we've configured our *feeder*, the next step is to deploy an *agent* on our remote CI node to complete the pipeline. See [Agents](agent.html) for more information.
