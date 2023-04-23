FROM tensorflow/tensorflow:1.12.0-py3

ENV LANG=C.UTF-8

RUN mkdir /gpt2-chatbot
WORKDIR /gpt2-chatbot

COPY . /gpt2-chatbot/

RUN apt-get update && apt-get install -y python3.7 python3-pip python3.7-dev git
RUN pip3.7 install -r requirements.txt
RUN python3.7 download_model.py 1558M

ENV tgtoken=Token-Telegram

CMD ["python3.7", "/src/GPT2-Learning.py"]