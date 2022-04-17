import torch

# Model
model = torch.hub.load(r'C:\Users\HAYA\PycharmProjects\study\yolov5-master\yolov5-master', 'custom', path=r'E:\_best.pt', source='local')
# Image
im = [r'E:\_currency.jpg']
# Inference
results = model(im)
# results
results.print()
results.save()  # or .show()
results.show()
results.xyxy[0]  # img1 predictions (tensor)
results.pandas().xyxy[0]
