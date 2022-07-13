import cv2
import numpy as np
import face_recognition
import os


def recognize_face(img):
    result = ''
    path = 'images'
    images = []
    classNames = []
    myList = os.listdir(path)
    for cl in myList:
        curImg = cv2.imread(f'{path}/{cl}')
        images.append(curImg)
        classNames.append(os.path.splitext(cl)[0])
    encodeList = []
    for image in images:
        image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(image)[0]
        encodeList.append(encode)

    #imgS = cv2.resize(img, (0, 0), None, 0.25, 0.25)
    img=face_recognition.load_image_file(img)
    imgS = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    facesCurFrame = face_recognition.face_locations(imgS)
    encodesCurFrame = face_recognition.face_encodings(imgS, facesCurFrame)
    for encodeFace, faceLoc in zip(encodesCurFrame, facesCurFrame):
        matches = face_recognition.compare_faces(encodeList, encodeFace)
        faceDis = face_recognition.face_distance(encodeList, encodeFace)
        # print(faceDis)
        matchIndex = np.argmin(faceDis)

        if matches[matchIndex]:
            name = classNames[matchIndex]
            result = name
        else:
            result = 'Face not found!'
    return result


#img=face_recognition.load_image_file(r'E:\flask app\API\test.jpg')
#res = recognize_face(img)
#print(res)

