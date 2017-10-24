Name:        dci-doc
Version:     0.0.1
Release:     1%{?dist}
Summary:     The Official documentation of Distributed-CI

License:     ASL2.0
URL:         https://github.com/redhat-cip/dci-doc
Source0:     dci-doc-%{version}.tar.gz

Requires:    httpd

%description
The Official documentation of Distributed-CI ready to be
served by a web server.

%prep
%setup -q


%build


%install
install -d %{buildroot}/var/www/html/docs.distributed-ci.io
cp -r dci-docs/* %{buildroot}/var/www/html/docs.distributed-ci.io


%files
%{buildroot}/var/www/html/docs.distributed-ci.io/*


%changelog
* Tue Oct 24 2017 Yanis Guenane  <yguenane@redhat.com> 0.0.1-1
- Initial commit
