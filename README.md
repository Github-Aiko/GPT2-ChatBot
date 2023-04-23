## GPT2-Telegram-Chatbot

A GPT-2 Telegram chatbot that's been relatively tuned for chatting. Feel free to make me PRs and I'll check out your code! The bot isn't 100% accurate all the time (why I coded in a /retry function.)

Since the bot consumes so much memory, I have it programmed in a round-robin sort of mode. Each input will reset a timer on your account ID, once the timer runs down the bot is free for other users to use. You will be notified when the timer runs down, and other users can see how much time is left and if the bot is in use.

# ENV Path Aiko Used For service
```
/mnt/c/Users/Aiko/Documents/Github/
```

### Installation/How to use:

Brief install instructions on Ubuntu 20/WSL.

I highly reccomend looking at the jupyter notebook/ipynb on google collab instead.

Install python3.7 (I think 3.6 might work as well, but not 3.8):

```
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.7
```

Install pip on python 3.7:
```
sudo apt-get install python3-distutils
```

```
wget https://bootstrap.pypa.io/get-pip.py
python3.7 get-pip.py
```

Install requirements inside of bot folder after cloning repository:
```
python3.7 -m pip install -r requirements.txt
```

Note: You realistically need 16GB of ram or a 8GB video card. Otherwise you will wait forever.
You can use GPU functions with atleast a 8GB video card that supports cuda tooklit 10.0 and cudnn for cuda toolkit 10. This install also works on windows with python 3.7 and nvidia, you must run command prompt as admin running python 3.7 on windows.

Set your telegram bot API key in src/GPT2-Learning.py
```
Edit token telegram from config.py from "Token-Telegram"
```

if you don't have telegram bot API key, you can get it from telegram bot father:

Dowload the gpt-2 model: ( I reccomend 1558M for best results, but it takes a long time to download )
```
python3.7 download_model.py 1558M
```

You Can Have Dowload the gpt-2 model in the models folder:
```
python3.7 download_model.py 124M
python3.7 download_model.py 355M
python3.7 download_model.py 774M
```

Run the bot:

If using python3 command:
```
./start.sh
```

If using python3.7 command:
```
python3.7 src/GPT2-Learning.py
```

You can edit start.sh to match your python command as you wish.

Build the Dockerfile and tag the created image as gpt-2-chatbot:
```
docker build --tag gpt-2 -f Dockerfile.gpu . # or Dockerfile.cpu
```

Start an interactive bash session from the gpt-2-chatbot docker image.
You can opt to use the `--runtime=nvidia` flag if you have access to a NVIDIA GPU and a valid install of [nvidia-docker 2.0](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)).
```
docker run --rm -it --runtime=nvidia gpt-2-chatbot bash
```

# Using docker HUB
```
docker pull aikocute/gpt2-chatbot:latest && docker run --restart=always --name gpt2-chatbot -e tgtoken={Telegram-token} --network=host aikocute/gpt2-chatbot:latest
```

### For quick command reference:

```
start - Basic start command.
help - Show quick help command.
chatbot - Chatbot mode, me+you string edit and open-ended questions.
finish - Default finish sentence command counting words as output length.
learnon - Turn on sentence compilation with Me+you string for conversation.
learnoff - Turn off the sentence compilation.
learnreset - Reset the learned conversation.
retry - Retry the current computation.
```
Here's a sample in learning chatbot mode with the latest gpt-2 database and top_p set to 0.83:

```
Me: Hello! How are you today? Are you feeling alright? I hope you are doing well and not getting into any trouble. 
Bot: Yeah, I'm fine. Do you want to make something to eat? 
Me: I already made some food, but thanks! I had some jalapeno poppers. I made a ton of them last night after I sold a lawnmower to some folks I got for free earlier in the day. So what are your plans for the day? 
Bot: Nothing special. Nothing exciting in particular. I just wanna chill out for a bit.  
Me: Just a typical day of kicking back and relaxing huh? Are you gonna watch cartoons or any movies in particular? 
Bot: If it's not sports I'll probably just watch something on the TV.  
Me: Sounds alright. I coded on my chatbot project most of the morning. Was waiting on someone to come buy a projector but they haven't shown up yet unfortunately. What do you do for work if you don't mind me asking? 
Bot: I'm a web developer and engineer. It's fun.   
Me: Cool! I'm also a coder and an ethical hacker. I mostly know how to code in Python but I've been unemployed for some time now after my spine injury. I wish I could have joined the military when I was younger. Were you ever in the military? 
Bot: No. I'm not really too proud of my military career. It ended up taking a huge toll on my back.   
Me: What happened to your back if you don't mind me asking?
Bot: First of all, it's better than before. 
Me: Well that's good to hear. Did you injure your back in the military or doing something else? 
Bot: Nope. It's an old injury. 
Me: Ah I see- Well I'll talk to you later. Sorry about your back! I hope we can catch up tomorrow! 
Bot: Yes, of course. Thanks again for chatting!
```

### Example of learning mode backend:
```
INFO:tensorflow:Restoring parameters from models/1558M/model.ckpt
2020-05-10 14:19:43,794 - tensorflow - INFO - Restoring parameters from models/1558M/model.ckpt
==========
Before splitlines:  Nothing special. Nothing exciting in particular. I just wanna chill out for a bit. You: I'll try to keep my spirits up. Just keep in mind that today's the 10th anniversary of the citywide strike
==========
==========
Mode: True
Learn: True
Length: 44
==========
Before regex:  Nothing special. Nothing exciting in particular. I just wanna chill out for a bit. You: I'll try to keep my spirits up. Just keep in mind that today's the 10th anniversary of the citywide strike
==========
Output:  Nothing special. Nothing exciting in particular. I just wanna chill out for a bit.
==========
Raw_text or Original: You: Hello! How are you today? Are you feeling alright? I hope you are doing well and not getting into any trouble. Me: Yeah, I'm fine. Do you want to make something to eat? You: I already made some food, but thanks! I had some jalapeno poppers. I made a ton of them last night after I sold a lawnmower to some folks I got for free earlier in the day. So what are your plans for the day? Me:
==========
Learning text or Next: You: Hello! How are you today? Are you feeling alright? I hope you are doing well and not getting into any trouble. Me: Yeah, I'm fine. Do you want to make something to eat? You: I already made some food, but thanks! I had some jalapeno poppers. I made a ton of them last night after I sold a lawnmower to some folks I got for free earlier in the day. So what are your plans for the day? Me: Nothing special. Nothing exciting in particular. I just wanna chill out for a bit.
==========
top_p out: 0.8338636363636364
==========
top_p in: 0.83
==========
```

For a list of grammarly scores please see [/SCORES.MD](/SCORES.md).

Tip: 

0.77 top_p can sound emotional, confused and copycat-ish.

0.66 top_p can sound thought-out and literal but can have ascii and cut-off errors.
