FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    curl unzip git build-essential \
    libsqlite3-0 libgl1 libfreetype6 libx11-6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/pharo

RUN curl https://get.pharo.org/vm140 | bash 

# TSLibraries will look in this place
#RUN mkdir -p /root/Documents/tree-sitter-libraries/libtree-sitter-python

#RUN git clone https://github.com/tree-sitter/tree-sitter-python.git /tmp/ts-python \
#    && cd /tmp/ts-python \
#    && make \
#    && cp libtree-sitter-python.so /root/Documents/tree-sitter-libraries/libtree-sitter-python/ \
#    && cp libtree-sitter-python.so /opt/pharo/pharo-vm/lib/ \
#    && rm -rf /tmp/ts-python

RUN mkdir -p /root/Documents/tree-sitter-libraries

# We build Tree-Sitter and the grammar in advance, otherwise pharo will try to do it but will use the vm git and make which conflicts with the ones in the docker
# A.  Tree-Sitter 
RUN git clone https://github.com/tree-sitter/tree-sitter.git /root/Documents/tree-sitter-libraries/tree-sitter \
    && cd /root/Documents/tree-sitter-libraries/tree-sitter \
    && make \
    && make install && ldconfig


# B. Python grammar 
RUN git clone https://github.com/tree-sitter/tree-sitter-python.git /root/Documents/tree-sitter-libraries/tree-sitter-python \
    && cd /root/Documents/tree-sitter-libraries/tree-sitter-python \
    && make \
    && cp libtree-sitter-python.so /opt/pharo/pharo-vm/lib/ 
    # not clear why TSPython loockup fallback in the previous location does not work... so we put it in the vms libs


COPY image/parse-api-fast.image .
COPY image/parse-api-fast.changes .

EXPOSE 1701

ENTRYPOINT ["./pharo"]

CMD ["parse-api-fast.image", "eval", "--no-quit", "Server start"]

