![image](https://github.com/user-attachments/assets/8ad5a694-e287-4d45-ba57-203f58a19714)

# Run RL Swarm (Testnet) Node
RL Swarm is a fully open-source framework developed by GensynAI for building reinforcement learning (RL) training swarms over the internet. This guide walks you through setting up an RL Swarm node and a web UI dashboard to monitor swarm activity.

## 💻 System Requirements

| Requirement                        | Details                                                                                      |
|-------------------------------------|---------------------------------------------------------------------------------------------|
| **CPU Architecture**                | `arm64` or `amd64`                                                                            |
| **Minimum RAM**                     | 16 GB                                                                                       |
| **CUDA Devices (optional)**         | `RTX 3090`, `RTX 4090`, `A100`, `H100`                                                  |
| **Python Version**                  | Python >= 3.10 (For Mac, you may need to upgrade) 
Note: You can run the node without a GPU using CPU-only mode.


# Rent GPUs and VPS from Hyperbolic and run gensyn-ai
** Run on Hyperbolic GPUs**
* To install the node on **Hyperbolic** check this [Guide: Rent & Connect to GPU](https://github.com/0xmoei/Hyperbolic-GPU)
* Add this flag: `-L 3000:localhost:3000` in front of your Hyperbolic's `SSH-command`, this will allow you to access to login page via local system.

after rent GPUs, you can connect to vps
![image](https://github.com/user-attachments/assets/976ca1ee-2d52-48bb-a89a-1838b7231f90)

and install it

Access to root:
```
sudo su
```

## 1) Install Dependencies
**1. Update System Packages**
```bash
apt-get update && apt-get upgrade -y
```
**2. Install General Utilities and Tools**
```bash
apt install tmux curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev  -y
```

**3. Install Docker**
```bash
# Remove old Docker installations
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done

# Add Docker repository
 apt-get update -y
 apt-get install ca-certificates curl gnupg -y
 install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
 apt-get update -y
 apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# check Docker status
docker --version
```
![image](https://github.com/user-attachments/assets/c395fc13-f854-4590-ae76-8b726f2d5cad)


**4. Install Python**
```bash
 apt-get install python3 python3-pip -y
```
```
 apt install python3.10-venv -y
```
```
python3 --version
```


![image](https://github.com/user-attachments/assets/aebe8390-2f86-441f-a506-e2f0db4fff67)

**5. Install Node**
```
curl -fsSL https://deb.nodesource.com/setup_23.x |  -E bash -
```
```
 apt-get install -y nodejs
```
```
node --version
```
![image](https://github.com/user-attachments/assets/043aec93-159c-459a-a64f-c88c20649377)

```bash
 npm install -g yarn
```
```bash
yarn -v
```

**6. Install Yarn**
```bash
curl -o- -L https://yarnpkg.com/install.sh | sh
```
```bash
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
```
```bash
source ~/.bashrc
```

---

## 2) Get HuggingFace Access token (options)
Hugging Face is a well-known AI technology company and an open-source platform specializing in natural language processing (NLP) and deep learning
**1- Create account in [HuggingFace](https://huggingface.co/)**

**2- Goto [here](https://huggingface.co/settings/tokens) > Create an Access Token in tab `Write` and save it**

---

## 3) Clone the Repository
```bash
git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm
```

---

## 4) Run the swarm
Open a screen to run it in background
```bash
tmux new -s gensyn
```
Install swarm
```bash
python3 -m venv .venv
source .venv/bin/activate
./run_rl_swarm.sh
```
Press `Y` > and Enter


---

## 5) Login
**1. Wait to `Waiting for userData.json to be created...` display on screen**

![image](https://github.com/user-attachments/assets/5f2cce2f-2b04-4c56-9a2b-80c470866b7d)


**2- Open login page in browser**
open firewall port or you can disable firewall (systemctl stop ufw)
```
ufw allow 3000
```

* Local PC: `http://localhost:3000/`
* VPS: `http://ServerIP:3000/`
  
![image](https://github.com/user-attachments/assets/b5352407-894c-48bf-b39f-9b202e4c1c7b)

* choose login with Google
  
**3- If you can't login via VPS then, Forward port**
* In windows start menu, Search **Powershell** and open its terminal in your local PC
* Enter the command below and replace your vps ip with `Server_IP` and your vps port(.eg 22) with `SSH_PORT`
```
ssh -L 3000:localhost:3000 root@Server_IP -p SSH_PORT
```
![image](https://github.com/user-attachments/assets/52fd9444-9c7a-4cf8-b294-7bd17d27e5a1)


* This prompts you to enter your VPS password, when you enter it, you connect and tunnel to your vps
* Now go to browser and open `http://localhost:3000/` and login
![image](https://github.com/user-attachments/assets/5d25cdff-bf1f-497e-90f1-3f4ea570765b)

**4- Login with your preferred method**
* After login, your terminal starts installation.
  ![image](https://github.com/user-attachments/assets/2e912e4e-0c53-4003-ae0e-27d2d12f2141)

**5- Push models to huggingface**
Wattinng and It will ask you this question : `Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N]` ; You should write `y` there (this options, you can write `n` to bypass it)
* Enter your HuggingFace access token you've created when it prompted

![image](https://github.com/user-attachments/assets/2747490a-af7e-4bc7-ac9e-655f1c7b7215)


---

## 6) Backup
**1- Node name**
* Now your node started running, Find your name after word `🐱 Hello 🐈 [nimble thick ram] 🦮` as in the image below (You can use `CTRL+SHIFT+F` to search Hello in terminal)

![image](https://github.com/user-attachments/assets/1de124e7-d949-458a-ba31-d6103d7aed20)


**2- Node `.pem` file**
* Save `swarm.pem` file in this directory: `/root/rl-swarm/`

---

## 7) Run Swarm Dashboard UI (Optional)
```bash
cd $HOME && cd rl-swarm
```
```bash
docker compose up -d --build
```
Open the dashboard in browser via:
* Local PC: `0.0.0.0:8080`
* VPS: `ServerIP:8080`

---

## 8) Search your node
* Official dashboard: https://dashboard.gensyn.ai/

**You can search your Node name in the dashboard after a while when you have done your first training completed**

![image](https://github.com/user-attachments/assets/6ff687fc-c0fb-4592-be74-9c2e82f7b73c)

--------

Source from: @0xmoei <3
