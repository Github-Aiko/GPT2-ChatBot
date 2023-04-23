# sử dụng base image
FROM tensorflow/tensorflow:1.12.0-py3

ENV LANG=C.UTF-8
RUN mkdir /GPT2-ChatBot
WORKDIR /GPT2-ChatBot
ADD . /GPT2-ChatBot
RUN pip3.7 install -r requirements.txt
RUN python3.7 download_model.py 1558M
ENV tgtoken=Token-Telegram


CMD ["python3.7", "main.py"]
