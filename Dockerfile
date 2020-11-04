FROM nvidia/cuda:10.2-devel

ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG DEBIAN_FRONTEND=noninteractive

# Update List of avai. Packages and intall additional packages
RUN apt-get update && apt-get -y install \
			python3-tk \
	&& rm -rf /var/lib/apt/lists/* #cleans up apt cache -> reduces image size

RUN apt update
RUN apt-get -y install tzdata \
	htop \
	graphviz \
	sox \
	wget \
	git \
	nano \
	zip \
	sudo \
	ffmpeg \
	python3-pip



RUN apt-get -y install python3-dev libffi-dev gcc && pip3 install --upgrade pip

RUN pip3 install --upgrade -I setuptools

RUN pip3 install \
  jupyter \
  matplotlib \
  seaborn	\
  scikit-learn \
  lxml \
  h5py \
  python_speech_features \
  sox \
  librosa \
  SpeechRecognition \
  spectrum \
  tqdm \
  cython \
  pydot \
  pydotplus\
  graphviz \
  nvidia-ml-py3 \
  pysptk \
  samplerate \
  cmake 

RUN pip3 install \
  pybind11 \
  pyroomacoustics

RUN pip3 install webrtcvad  

RUN export CUDACXX=/usr/local/cuda/bin/nvcc
RUN pip3 install https://github.com/DavidDiazGuerra/gpuRIR/zipball/master

VOLUME /SEFHI
WORKDIR /SEFHI
EXPOSE 8888

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/SEFHI --ip 0.0.0.0 --no-browser --allow-root"]
