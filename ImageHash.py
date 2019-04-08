import sys
'''
Requirements:
    pip intsall pillow
    pip install ImageHash
Hash mode:
    average hashing (aHash)
    perception hashing (pHash)
    difference hashing (dHash)
    wavelet hashing (wHash)
'''
from PIL import Image
import imagehash
image = sys.argv[1]
mode = int(sys.argv[2])
if mode ==1:
	hash = imagehash.average_hash(Image.open(image))
elif mode ==2:
	hash = imagehash.phash(Image.open(image))
elif mode ==3:
	hash = imagehash.dhash(Image.open(image))
elif mode ==4:
	hash = imagehash.whash(Image.open(image))
else:
	hash = imagehash.average_hash(Image.open(image))
print(hash)
