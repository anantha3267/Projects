FROM python:3.11-slim
RUN pip install kopf kubernetes
COPY main.py /main.py
CMD ["kopf", "run", "--standalone", "/main.py"]