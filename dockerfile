FROM tverous/pytorch-notebook:latest

RUN apt-get install -y curl
RUN mkdir /app/images

RUN curl --location http://data.vision.ee.ethz.ch/cvl/food-101.tar.gz --output /app/images/food-101.tar.gz && \
    mkdir /app/images/food-101 -p && \
    tar -xf /app/images/food-101.tar.gz --directory /app/images/ && \
    mkdir /app/images/pizza_steak_sushi/train/pizza -p && \
    mkdir /app/images/pizza_steak_sushi/test/pizza -p && \
    mkdir /app/images/pizza_steak_sushi/train/steak -p && \
    mkdir /app/images/pizza_steak_sushi/test/steak -p && \
    mkdir /app/images/pizza_steak_sushi/train/sushi -p && \
    mkdir /app/images/pizza_steak_sushi/test/sushi -p && \
    find /app/images/food-101/images/pizza/. -maxdepth 1 -type f |head -250|xargs mv -t /app/images/pizza_steak_sushi/test/pizza && \
    mv /app/images/food-101/images/pizza/* /app/images/pizza_steak_sushi/train/pizza && \
    find /app/images/food-101/images/steak/. -maxdepth 1 -type f |head -250|xargs mv -t /app/images/pizza_steak_sushi/test/steak && \
    mv /app/images/food-101/images/steak/* /app/images/pizza_steak_sushi/train/steak && \
    find /app/images/food-101/images/sushi/. -maxdepth 1 -type f |head -250|xargs mv -t /app/images/pizza_steak_sushi/test/sushi && \
    mv /app/images/food-101/images/sushi/* /app/images/pizza_steak_sushi/train/sushi && \
    rm /app/images/food-101.tar.gz && \
    rm /app/images/food-101 -r

RUN pip install \
    Pillow \
    matplotlib \
    torchvision \
    tqdm \
    ipywidgets \
    pandas
