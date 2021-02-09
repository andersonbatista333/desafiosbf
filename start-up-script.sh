#!/bin/bash
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda-9-0; then
  # The 16.04 installer works with 16.10.
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
  apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
  apt-get update
  apt-get install cuda-9-0 -y
fi
# Enable persistence mode
nvidia-smi -pm 1

# Install docker
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce

# Install nvidia-container-runtime
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

# Install nvidia-docker2 and reload the Docker daemon configuration
apt-get install -y nvidia-docker2
pkill -SIGHUP dockerd

# add ssh key
mkdir ~/.ssh

echo "MIIEpAIBAAKCAQEAxKCG6VYNrUya7+uHAPgSoJmNfGlMGDIwi39v3EVUIRkUxzPt
yvG2GtlaGUa4NxioJxlECd1ZUFWyWuYfpSWDOg8dqgLLNUtb42a0UgEFHpNxFoQP
EOYu01YGQTaLC5+CCnoP2jTvTXEKkgtTDr0yeGgFTobQ/Y9i4Wh9rBlUPag4622B
zVlUnAwFOlsz9JAnaociHdjuLUGNS2xDtbM/lXrZ4Ox1LPllaR+WyuyboGANhxGy
2bdDhBf1UldAibKWsSfZFEuKPFLW51WmDNzqgm5cdOV6M5cu22bFHjzKyG8wPp1q
JtnGmcDJqwGJZSnYtXW1IB9WGK1n1R2rSrHKuwIDAQABAoIBAA6phcXqk9SDbN5N
KuEInqL5MFLBq1n2jCYq15WOWeqp6yG7npTOl2zDHnPaESySmx9nQ+qUZe+WpFkg
5eUzuehfbi/aS3rq5qw7YWDoEJCqH/m02UbCU2WQ+aBtR8sTFuhfF8WGwv18W3Ru
gcAMnbHa1+J2LSlrQs1aNFzb+qsqOXhkGkQCpk+q+JecZnWzi6lJS4dt1TZE9OWa
5hFtJmKJYsFFT2qgy+ndiqXJMRh8nIs542VGmiKVc9CvRDUIzVfpy7cntWeypYvq
WwstCg9n1+GkPgJu44mgXkCBFzTe4iKMD8RViMtVEcfiuzGEOFXFTupRT3A1BqeA
VFymbdkCgYEA/QmPdcVUN80IypwGCTEB9YL0qlXvkEdmXYLaQvQ7PA80TPOQ8qNe
7IQMoA0v4cW44cdyHg21m998JNP+RzvTLUjLyB0OfxpMoeEw/Hmg1iImR2uuKqgn
+kUU0Ay48pX61/01rAznGEVfvR3+b9RZNvLoPnmoUkVw1NpG995krLcCgYEAxu3i
uiY/+aR2TX+i2T/PSgKNWAz8qbEmMRBLaBeTk9vHMKUQdc+7+DSRp09fb79twa3/
71wqwTJUIeQSoMJ6jZFDn1kEVbTNGIzTyKnOy2HORk3Hsu8S6BRpvvZqI6HD98tS
Wn+2zKq3AUpnxwxQgjmxNKqJ/Z3isM+fcWuhlh0CgYEA9EHpURdWD7OFnAd2sCK1
sGhkg5UG9zBlOTlaNa2LDJPkua+YqRBZTli90zZHlVqG+LPNjgNP3xKhxO87E0pF
tP4DcL3Tw5AAj3dRETbbsjku2FyyuIywYp+S0q6lTc7HYP4VdGrUHZLCM02j0hGa
uTdMRxqrCBfuLhoyzYzJhAsCgYEAj4+d0DlKch7+QW+bVq12KzMsTh8ROGVf6oiX
4scg+dPiLHjzKBKC1N0bQGNHvJ2p19x6l4MsV8C6drrhtqKjTwdGhfj35+JTISSA
so/ZbW1oL9RyCe/+9P3GUsoCTzSu+GUDScxhX9LTv1qzCjMY5uI7wIZSj3Uh4/fy
WSgTtQECgYA8ByrNmfUqytADvd0Gp6Ty3jJSU2Y/1SI7TJstn36fzkxsH5XkLt3O
t3iOzqJVaZRVbr1c5BQ/IGxq5WFZcCCoIWuna/rWPg/eBujfatkS54QuONtMlqkj
S59AmKmEAFAqe8VSPjTeJ5Ao7VMqFfEdrocSlcippZepYFv11yorUA=="  >> ~/.ssh/id_rsa_gitlab
chmod 0400 ~/.ssh/id_rsa_gitlab
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_gitlab

# Clone project repository
mkdir ~/datascience
cd ~/datascience
ssh-keyscan gitlab.com >>  ~/.ssh/known_hosts
git clone git@gitlab.com:dice89/deep-learning-experiments.git

# Pull and run docker image
docker pull dice89/ubuntu-gpu-python-dl:latest
docker run --runtime=nvidia -p 80:8080 -v ~/datascience:/root/project  dice89/ubuntu-gpu-python-dl

# format to run independent Job
# docker run --runtime=nvidia -d -v ~/datascience:/root/project  cheukting/coursera-aml-docker python3 /root/project/deep-learning-experiments/train.py
