Name:           icloud-for-linux
Version:        0.22
Release:        1%{?dist}
Summary:        iCloud for Linux

License:        MIT
URL:            https://github.com/cross-platform/icloud-for-linux
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  cmake gcc gcc-c++ pkgconfig gtk3-devel webkit2gtk3-devel
Requires:       gtk3-devel webkit2gtk4-devel

%description
iCloud client for Linux allows users to access iCloud services on a Linux machine.

%prep
%setup -q

%build
mkdir -p %{_target_platform}
cd %{_target_platform}
cmake .. -DCMAKE_INSTALL_PREFIX=%{buildroot}/usr
make %{?_smp_mflags}

%install
cd %{_target_platform}
make install
strip %{buildroot}/usr/bin/icloud-for-linux

%files
%license LICENSE
%doc README.md
/usr/bin/icloud-for-linux

%changelog
* Thu Jul 14 2024 @afro.systems <root@afro.systems> - 0.22-1
- Initial package
