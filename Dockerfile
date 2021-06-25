ARG VERSION=bullseye-slim

FROM debian:${VERSION} 

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt -y install build-essential gcc-10 cmake \
        gdb python3 python3-pip

# build project
ARG PROJECT=pyc
WORKDIR /workspaces/${PROJECT}

COPY src src/
COPY test test/
COPY bin bin/
COPY CMakeLists.txt .
COPY requirements.txt .

ARG BUILD=build
ARG TYPE=DEBUG

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

#build
ENV MAKEFLAGS=-j8
RUN cmake -H. -B${BUILD} -DPROJECT_NAME=${PROJECT} -DCMAKE_BUILD_TYPE=${TYPE} -DCMAKE_VERBOSE_MAKEFILE=on "-GUnix Makefiles"
RUN cmake --build ${BUILD} --verbose --config ${TYPE}
RUN ls -lR ${BUILD}
ENV CTEST_OUTPUT_ON_FAILURE=1

RUN (cd ${BUILD} && ctest)
ENV PROJECT_NAME=${PROJECT}
CMD python3 bin/pyc.py
