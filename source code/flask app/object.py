import cv2

def recognize_objects(imgName):
    img = cv2.imread(imgName)
    classNames = []
    classFile = 'coco.names'
    with open(classFile, 'rt') as f:
        classNames = f.read().rstrip('\n').split('\n')
    configPath = 'ssd_mobilenet_v3_large_coco_2020_01_14.pbtxt'
    weightsPath = 'frozen_inference_graph.pb'
    net = cv2.dnn_DetectionModel(weightsPath, configPath)
    net.setInputSize(320, 320)
    net.setInputScale(1.0 / 127.5)
    net.setInputMean((127.5, 127.5, 127.5))
    net.setInputSwapRB(True)
    classIds, confs, bbox = net.detect(img, confThreshold=0.5)
    objects = []
    for classId in classIds:
        objects.append(classNames[classId - 1])
    cv2.waitKey(0)
    return objects
