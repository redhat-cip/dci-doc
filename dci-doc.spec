Name:        dci-doc
Version:     0.2.0
Release:     1%{?dist}
Summary:     The Official documentation of Distributed-CI

License:     ASL2.0
URL:         https://github.com/redhat-cip/dci-doc
Source0:     dci-doc-%{version}.tar.gz

Requires:    httpd
BuildArch:   noarch

%description
The Official documentation of Distributed-CI ready to be
served by a web server.

%prep
%setup -q


%build


%install
install -d %{buildroot}/var/www/html/docs
cp -r * %{buildroot}/var/www/html/docs


%files
/var/www/html/docs/*


%changelog
* Mon Jan 24 2022 Guillaume Vincent <gvincent@redhat.com> 0.2.0-1
- Use mkdocs
* Tue Oct 24 2017 Yanis Guenane <yguenane@redhat.com> 0.0.1-1
- Initial commit
