from flask import Flask, request
import base64
import cv2
import os
import face
import object
import ocr
import currency
import io
from PIL import Image

app = Flask(__name__)

@app.route('/',methods=['POST'])
def features():
    result = ''
    data = request.get_json(force=True)
    task = str(data['task'])
    # KNOWN PERSON RECOGNITION
    if task == 'recognize a person':
        image_data = data['image']
        imgdata = base64.b64decode(image_data)
        filename = 'somebody.jpg'
        with open(filename, 'wb') as f:
            f.write(imgdata)
            print("SAVED !")
        path = r'C:\Users\HAYA\PycharmProjects\flask app\somebody.jpg'
        result = face.recognize_face(path)
    # UNKNOWN PERSON ADDITION
    elif task == 'add a person':
        name = str(data['name'])
        path = 'images'
        image = cv2.imread('somebody.jpg')
        image_name = '{}.jpg'.format(name)
        cv2.imwrite(os.path.join(path, image_name), image)
        result = 'Done!'
    # OBJECT RECOGNITION
    elif task == 'recognize objects':
        image_data = data['image']
        imgdata = base64.b64decode(image_data)
        filename = 'something.jpg'
        with open(filename, 'wb') as f:
            f.write(imgdata)
            print("SAVED !")
        path = r'C:\Users\HAYA\PycharmProjects\flask app\something.jpg'
        objects = object.recognize_objects(path)
        for i in range(len(objects)):
            j = i + 1
            if j != len(objects):
                result += objects[i]
                result += ', '
            else:
                result += objects[i]
    # CURRENCY RECOGNITION
    elif task == 'recognize the banknote':
        image_data = data['image']
        imgdata = base64.b64decode(image_data)
        filename = 'something.jpg'
        with open(filename, 'wb') as f:
            f.write(imgdata)
            print("SAVED !")
        path = r'C:\Users\HAYA\PycharmProjects\flask app\something.jpg'
        result = currency.currency_recognize(path)
    # OPTICAL CHARACTER RECOGNITION
    elif task == 'read the image':
        image_data = data['image']
        imgdata = base64.b64decode(image_data)
        filename = 'something.jpg'
        with open(filename, 'wb') as f:
            f.write(imgdata)
            print("SAVED !")
        path = r'C:\Users\HAYA\PycharmProjects\flask app\something.jpg'
        result = ocr.read_image(path)
    print(result)
    return result

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True,port=5000)


