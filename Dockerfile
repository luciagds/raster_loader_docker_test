FROM ghcr.io/osgeo/gdal:ubuntu-full-latest

# Configure everything to install gum (helper for entrypoint.sh)
RUN mkdir -p /etc/apt/keyrings \   
    && curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list 

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
    gum \
    git \
    python3 \
    python3-pip \
    python3-setuptools

# FROM SOURCE
WORKDIR /
RUN git clone https://github.com/cartodb/raster-loader raster-loader
WORKDIR /raster-loader
RUN pip3 install .

# FROM RELEASE
# RUN pip3 install raster-loader

WORKDIR /

#change here
COPY entrypoint.sh /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]






