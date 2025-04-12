FROM python:3.7-slim
RUN rm -rf /etc/apt/sources.list.d/*
RUN rm -rf /var/lib/apt/lists/*
RUN echo "deb http://mirror.yandex.ru/debian bookworm main contrib non-free\n\
deb-src http://mirror.yandex.ru/debian bookworm main contrib non-free\n\
deb http://mirror.yandex.ru/debian bookworm-updates main contrib non-free\n\
deb-src http://mirror.yandex.ru/debian bookworm-updates main contrib non-free\n\
deb https://mirror.yandex.ru/debian-security bookworm-security main contrib non-free\n\
deb-src https://mirror.yandex.ru/debian-security bookworm-security main contrib non-free" > /etc/apt/sources.list

RUN apt clean && rm -rf /var/lib/apt/lists/* && \
    apt update --fix-missing

RUN apt install -y \
    libgl1-mesa-glx \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libx265-dev \
    libavcodec-extra \
    x265 \
    libgraphviz-dev \
    graphviz \
    ffmpeg && \
    apt-get clean && apt-get autoclean

COPY requirements.txt requirements.txt
RUN pip install pip -U ;\
    pip install --no-cache-dir -r requirements.txt

WORKDIR /notebooks
