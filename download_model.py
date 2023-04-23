import os
import sys
import requests
from tqdm import tqdm

if len(sys.argv) != 2:
    print('You must enter the model name as a parameter, e.g.: download_model.py 124M')
    sys.exit(1)

model = sys.argv[1]

subdir = os.path.join('models', model)
if not os.path.exists(subdir):
    os.makedirs(subdir)
subdir = subdir.replace('\\','/') # needed for Windows

for filename in ['checkpoint','encoder.json','hparams.json','model.ckpt.data-00000-of-00001', 'model.ckpt.index', 'model.ckpt.meta', 'vocab.bpe']:
    url = "https://aikocute.net/model/" + model + "/" + filename
    
    r = requests.get(url, stream=True)
    with open(os.path.join(subdir, filename), 'wb') as f:
        file_size = int(r.headers.get("content-length", 0))
        chunk_size = 1000
        with tqdm(ncols=100, desc=filename, total=file_size, unit_scale=True) as pbar:
            for chunk in r.iter_content(chunk_size=chunk_size):
                f.write(chunk)
                pbar.update(chunk_size)
                
print(f"Download model: {model} successfully!")