Product Test result Summary
---

Product test results from f0e86e9a9c8aae958bf5dbc49012d8f630a2014 tested on 2021-10-22

| Product                           | Passing | Failing | Skipped | Unfinished | Total |
|-----------------------------------|---------|---------|---------|------------|-------|
| rocky-boot-iso-x86_64-*           | 0       | 2       | 0       | 0          | 2     |
| rocky-minimal-iso-x86_64-*        | 2       | 0       | 0       | 0          | 2     |
| rocky-dvd-iso-x86_64-*            | 25      | 1       | 0       | 0          | 26    |
| rocky-universal-x86_64-*          | 23      | 18      | 0       | 2*         | 47    |

\* install_pxeboot and install_pxeboot@uefi can't run due to misssing `support_server@64bit`

Product test commands
---

rocky-boot-iso-x86_64-*
```
sudo openqa-cli api -X POST isos \
  ISO=Rocky-8.4-x86_64-boot.iso \
  DISTRI=rocky \
  VERSION=8.4 \
  FLAVOR=boot-iso \
  ARCH=x86_64 \
  BUILD="-boot-iso-$(date +%Y%m%d.%H%M%S).0"
```

rocky-minimal-iso-x86_64-*
```
sudo openqa-cli api -X POST isos \
  ISO=Rocky-8.4-x86_64-minimal.iso \
  DISTRI=rocky \
  VERSION=8.4 \
  FLAVOR=minimal-iso \
  ARCH=x86_64 \
  BUILD="-minimal-iso-$(date +%Y%m%d.%H%M%S).0"
```

rocky-dvd-iso-x86_64-*
```
sudo openqa-cli api -X POST isos \
  ISO=Rocky-8.4-x86_64-dvd1.iso \
  DISTRI=rocky \
  VERSION=8.4 \
  FLAVOR=dvd-iso \
  ARCH=x86_64 \
  BUILD="-dvd-iso-$(date +%Y%m%d.%H%M%S).0"
```

rocky-universal-x86_64-*
```
sudo openqa-cli api -X POST isos \
  ISO=Rocky-8.4-x86_64-dvd1.iso \
  DISTRI=rocky \
  VERSION=8.4 \
  FLAVOR=universal \
  ARCH=x86_64 \
  BUILD="-universal-$(date +%Y%m%d.%H%M%S).0"
```
