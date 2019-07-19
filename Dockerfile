FROM python:2.7.16-buster
RUN mkdir /site
WORKDIR /site

RUN apt-get update
RUN apt-get install git
RUN git clone https://github.com/jroyal/OTTGaaS.git
RUN pip install flask
RUN pip install flask-restful
#Manually install dependancy that failes on pip install pillow.
RUN git clone https://github.com/python-pillow/Pillow.git
WORKDIR /site/Pillow
RUN python ./setup.py install
WORKDIR /site/OTTGaaS
#this changes the port that the server runs on. Change 80 to your desired port
RUN sed 's/5000/80/g' /site/OTTGaaS/server.py > /site/OTTGaaS/customserver.py
RUN pip install -r /site/OTTGaaS/requirements.txt

EXPOSE 80
ENTRYPOINT python /site/OTTGaaS/customserver.py