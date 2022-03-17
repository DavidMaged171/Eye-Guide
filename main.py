import tensorflow as tf
from tensorflow import keras
from keras import layers
from keras import datasets
from keras import models
import matplotlib
import numpy as np

import xml.etree.ElementTree as ET
from os import listdir, mkdir
from os.path import isdir, join, isfile, splitext
import re
from tqdm import tqdm
import os

os.environ['TFF_CPP_MIN_LOG_LEVEL'] = '2'


class Processing():
    def __init__(self):
        self.ANN_FILE = None
        self.CLASSES = set()
        self.CLASSES_file = None
        self.COUNT_XML = set()
        self.COUNT_IMAGES = set()
        self.COUNT_BOXES = 0

    def xml_files_in_folder(self, folder):
        return [join(folder, f) for f in listdir(folder) if re.match(r'.*\.(xml|XML)', f, flags=re.I)]

    def init_file_csv(self, _path):
        self.ANN_FILE = open(_path, 'w')

    def write_file_csv(self, row):
        _path, x, y, x2, y2, label = row
        insert_row = f'{_path},{x},{y},{x2},{y2},{label}'
        self.ANN_FILE.write(insert_row)
        self.ANN_FILE.write('\n')

    def read_xml_file(self, _file):
        self.COUNT_XML.add(_file)
        tree = ET.parse(_file)
        root = tree.getroot()
        for boxes in root.iter('object'):
            filename = root.find('filename').text
            full_path = _file.replace(splitext(_file)[1], splitext(filename)[1])
            label = boxes.find('name').text
            ymin, xmin, ymax, xmax = None, None, None, None
            ymin = int(boxes.find("bndbox/ymin").text)
            xmin = int(boxes.find("bndbox/xmin").text)
            ymax = int(boxes.find("bndbox/ymax").text)
            xmax = int(boxes.find("bndbox/xmax").text)
            one_line = [full_path, xmin, ymin, xmax, ymax, label]
            self.write_file_csv(one_line)
            self.CLASSES.add(label)
            self.COUNT_IMAGES.add(filename)
            self.COUNT_BOXES += 1

    def write_classes_csv(self):
        with open(self.CLASSES_file, 'w') as classes_file:
            for id, cl in enumerate(self.CLASSES):
               classes_file.write('{},{}'.format(cl, id))
               classes_file.write('\n')
        classes_file.close()

    def Done(self):
        self.ANN_FILE.close()


class Big_Engine():
    def __init__(self):
        self.PATH_DATA = None
        self.Processing = Processing()

    def SETUP(self, data: str, ann_file: str, classes_file: str):
        self.PATH_DATA = data
        self.Processing.CLASSES_file = classes_file
        self.Processing.init_file_csv(ann_file)

    def RUN(self):
        for sub_dir in tqdm(listdir(self.PATH_DATA)):
            end_dir = join(self.PATH_DATA, sub_dir)
            if not isdir(end_dir):
                continue
            for xml_path in self.Processing.xml_files_in_folder(end_dir):
                self.Processing.read_xml_file(xml_path)

    def PrintData(self):
        print(f"[Count Xml files]  | {len(self.Processing.COUNT_XML)}")
        print(f"[Count Images]  | {len(self.Processing.COUNT_IMAGES)}")
        print(f"[Count Classes]  | {len(self.Processing.CLASSES)}")
        print(f"[Count BOXES]  | {self.Processing.COUNT_BOXES}")

    def SetEnd(self):
        self.Processing.write_classes_csv()
        self.Processing.Done()
        self.PrintData()
        print("[bye] - Done..")


LetsGo = Big_Engine()
LetsGo.SETUP(data='E:\dataset1', ann_file='E:\d_annotation_custom.csv', classes_file='E:\classes_n.csv')
LetsGo.RUN()
LetsGo.SetEnd()
