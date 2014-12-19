# rpm-mk
Makefile for building RPM packages from git

## Usage
Add rpm-mk as a submodule to your project git repository:

```
git submodule add https://github.com/ivoronin/rpm-mk.git rpm-mk
```

Add following line to your project makefile:

```
include rpm-mk/rpm.mk
```

Run:

```
make rpm
```
