import cv2
import pytesseract

def read_image(img_path):
    pytesseract.pytesseract.tesseract_cmd = 'C:\Program Files\Tesseract-OCR\\tesseract.exe'
    img = cv2.imread(img_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    output = pytesseract.image_to_string(img)
    output = output.replace('\n', ' ')
    output = output.replace('\t', ' ')
    return output
