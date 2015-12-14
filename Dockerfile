FROM fedora:23
MAINTAINER Pavel Odvody <podvody@redhat.com>

ENV PACKAGES='findutils git golang make npm python-virtualenv ruby-devel rubygem-bundler tar which'
ENV GOPATH='/usr/share/golang'

RUN mkdir -p ${GOPATH}\
 && dnf install -y ${PACKAGES}\
 && (go get -u -v sourcegraph.com/sourcegraph/srclib/cmd/srclib\
  && cd /usr/bin/ && go build sourcegraph.com/sourcegraph/srclib/cmd/srclib)\
 && srclib toolchain install go ruby javascript python\
 && rm -rf /var/cache/dnf

ENTRYPOINT ["/usr/bin/bash"]
