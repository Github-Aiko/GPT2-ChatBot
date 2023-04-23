FROM tensorflow/tensorflow:1.12.0-py3

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /gpt2-chatbot
WORKDIR /gpt2-chatbot

COPY . /gpt2-chatbot/

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update

FROM python:3.7.16

RUN python3 -m pip install -r requirements.txt
RUN python3 download_model.py 1558M

ENV tgtoken=Token-Telegram

CMD ["python3", "/src/GPT2-Learning.py"]
