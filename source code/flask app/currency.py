import torch

def results_parser(results):
  s = ""
  if results.pred[0].shape[0]:
    for c in results.pred[0][:, -1].unique():
      n = (results.pred[0][:, -1] == c).sum()  # detections per class
      s += f"{n} {results.names[int(c)]}{'s' * (n > 1)}, "  # add to string
  return s

def currency_recognize(img_path):
  model = torch.hub.load(r'C:\Users\HAYA\PycharmProjects\flask app\yolov5-master\yolov5-master', 'custom', path=r'C:\Users\HAYA\PycharmProjects\flask app\best.pt', source='local')
  results = model(img_path)
  return results_parser(results)


