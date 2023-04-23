FROM tensorflow/tensorflow:1.12.0-py3

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir /gpt2-chatbot
WORKDIR /gpt2-chatbot

COPY . /gpt2-chatbot/

RUN apt-get update -qq && apt-get upgrade -y -qq
RUN apt-get install -y -qq --no-install-recommends software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update -qq
RUN apt-get install -y -qq --no-install-recommends python3.7 python3.7-pip python3.7-dev git
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Check Python and pip versions
RUN python3.7 --version && pip3.7 --version

RUN pip3.7 install -r requirements.txt
RUN python3.7 download_model.py 1558M

ENV tgtoken=Token-Telegram

CMD ["python3.7", "/src/GPT2-Learning.py"]
