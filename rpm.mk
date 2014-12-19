GIT_DESCRIBE=$(subst -, ,$(shell git describe))
GIT_TAG=$(word 1,$(GIT_DESCRIBE))
GIT_COMMIT_NUMBER=$(word 2,$(GIT_DESCRIBE))
GIT_OBJECT_NAME=$(word 3,$(GIT_DESCRIBE))
GIT_TOPLEVEL=$(shell git rev-parse --show-toplevel)

RPM_VERSION=$(GIT_TAG)
ifneq ($(GIT_COMMIT_NUMBER),)
	RPM_RELEASE="$(GIT_COMMIT_NUMBER).$(GIT_OBJECT_NAME)"
else
	RPM_RELEASE="1"
endif

RPM_PACKAGE=$(notdir $(GIT_TOPLEVEL))
RPM_SOURCES=$(shell rpm --eval %{_sourcedir})

SOURCE_FILE=${RPM_SOURCES}/${RPM_PACKAGE}-${RPM_VERSION}.tar.gz
SPEC_FILE=${RPM_PACKAGE}.spec

RPMBUILD_OPTIONS=-bb --quiet -D "release ${RPM_RELEASE}" -D "version ${RPM_VERSION}"
ifndef RPM_BUILD_DEBUG
RPMBUILD_OPTIONS+=-D "debug_package %{nil}"
endif

rpm:
	tar --xform "s@^@${RPM_PACKAGE}-${RPM_VERSION}/@" -czf "${SOURCE_FILE}" .
	rpmbuild $(RPMBUILD_OPTIONS) "${SPEC_FILE}"

.PHONY: rpm
