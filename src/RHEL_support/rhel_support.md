# RHEL support in DCI

If you are using RHEL you are probably familiar with CDN or FTP. CDN contains officially released and supported content. FTP contains pre-release content. The FTP is updated manually and on demand. DCI allows you to get access to pre-release content in an automated way.

## RHEL Compose

Red Hat Enterprise Linux content is in the form of a compose. A compose is a list of RPMs grouped by variants and by architectures.

DCI only support pre-release composes.

For example if the latest release of Red Hat Enterprise Linux is `RHEL-8.4`, DCI supports `RHEL-X.Y` with X >= 8 and Y > 4. E.g. `RHEL-8.5` or `RHEL-9.0`.

## Arches

DCI supports x86_64, aarch64 and ppc64le architectures.

## Variants

DCI supports AppStream, BaseOS, CRB, HighAvailability, NFV, RT, ResilientStorage, SAP, SAPHANA variants.

## Versions

RHEL major version corresponds to the first digit in the version number. Currently there is 2 major version of RHEL in DCI: version 8 and version 9

RHEL minor version corresponds to the second digit in the version number. E.g. `RHEL-8.5` or `RHEL-9.0`.

## Channels

DCI supports 3 different channels: Development, Nightly and Milestone channel.

- Development composes are built every day, tested by basic tests and imported to Beaker and Openstack. They contain unverified RPMs and unverified Kernel changes.

- Nightly composes are built every day, tested with more tests and imported to Beaker and Openstack. Those nightlies contain verified RPMs.

- When Red Hat prepare the next RHEL version, they promote a Nightly Compose into a Milestone compose (alpha, beta and release candidate).
  Nightly compose, Milestone compose are all the very same composes with the very same content, they differ in the amount of testing they received.

Notes: Composes are tested internally. When tests failed DCI ignore those composes. So it is normal that the last nightly could be a few days old.

## Topics

A topic is an abstraction to group different Composes together. The name of the topic contains the major and minor version. E.g. RHEL-8.5.
The different Composes of the different channels are grouped by minor version.

Components for the `RHEL-8.5` topic:

- `RHEL-8.5.0-20211007.n.0` | nightly compose
- `RHEL-8.5.0-20211006.d.1` | development compose

Note: When you list topics in DCI you may see a channel in the name. E.g. `RHEL-8.4-milestone`. This feature has been deprecated in favor of [dci-downloader filters](https://docs.distributed-ci.io/dci-downloader/#filters).

If you want to access RHEL-8.5 nightlies only for example, you will have the appropriate filter in your settings file.

```
topics:
  - name: RHEL-8.5
    filters:
      - type: compose
        tag: nightly
```

## FAQ

### How can I access z-stream updates ?

In short: you can’t get those updates in DCI right now because we are focused on pre-ga content. Feel free to tell us, if this is something important for you.

> During the Full Support Phase, qualified Critical and Important Security errata advisories (RHSAs) and Urgent and Selected (at Red Hat discretion) High Priority Bug Fix errata advisories (RHBAs) may be released as they become available.

After GA during the full support phase, Errata advisories are pushed on the CDN as they become available. So the time between an errata is tested and pushed on the CDN is very short. This is why DCI chose to not provide content for specific minor releases after GA.

### Where can some documentation about the Red Hat Enterprise Linux Life Cycle?

[Red Hat Enterprise Linux Life Cycle official document](https://access.redhat.com/support/policy/updates/errata)
