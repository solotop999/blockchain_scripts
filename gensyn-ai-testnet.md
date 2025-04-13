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


# I. Rent GPUs and VPS from VastAI and run gensyn-ai
* Rent GPU: [VastAI RTX 3090](https://cloud.vast.ai?ref_id=62897&template_id=b9a6835f504bc29f1295cbd936e11abc)
* Note: Add this flag: `-L 3000:localhost:3000` in front of your Hyperbolic's `SSH-command`, this will allow you to access to login page via local system.

ssh to your vps

# II. Install GensynAI

**1.**
```
apt-get install tmux && tmux new -s gen
```

**2.**
```bash
apt-get update && apt-get upgrade -y && apt install tmux curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev nvtop -y

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

apt-get install python3 python3-pip -y && apt install python3.10-venv -y && python3 --version

curl -fsSL https://deb.nodesource.com/setup_23.x | bash - && apt-get install -y nodejs && npm install -g yarn && node --version && yarn -v && curl -o- -L https://yarnpkg.com/install.sh | sh
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source ~/.bashrc

git clone https://github.com/gensyn-ai/rl-swarm/
cd rl-swarm

python3 -m venv .venv
source .venv/bin/activate
./run_rl_swarm.sh
```

Press `Y` > and Enter


---

**3. Wait to `>> Waiting for modal userData.json to be created...` display on screen**

![image](https://github.com/user-attachments/assets/26e23fce-c314-44d5-9833-2fbc6ee7a065)


* In windows start menu, Search **Powershell** and open its terminal in your local PC
* Enter the command below and replace your vps ip with `Server_IP` and your vps port(.eg 22) with `SSH_PORT`
```
ssh -L 3000:localhost:3000 root@Server_IP -p SSH_PORT
```
![image](https://github.com/user-attachments/assets/52fd9444-9c7a-4cf8-b294-7bd17d27e5a1)



**4. Open login page in browser**

* go to: http://localhost:3000/
  
  ![image](https://github.com/user-attachments/assets/b5352407-894c-48bf-b39f-9b202e4c1c7b)

* After login, your terminal starts installation.
  
![image](https://github.com/user-attachments/assets/e4aa4ddc-b6ff-49d2-99b7-e09e4036f48d)



# III. Backup and info
**1- Node name**
* Now your node started running, Find your name after word `🐱 Hello 🐈 [nimble thick ram] 🦮` as in the image below (You can use `CTRL+SHIFT+F` to search Hello in terminal)

![image](https://github.com/user-attachments/assets/1de124e7-d949-458a-ba31-d6103d7aed20)


**2- Node `.pem` file**
* Save `swarm.pem` file in this directory: `/root/rl-swarm/`

**3- Search your node**
* Official dashboard: https://dashboard.gensyn.ai/

**You can search your Node name in the dashboard after a while when you have done your first training completed**
![image](https://github.com/user-attachments/assets/9200281e-294a-4124-ba7a-30ade69e772b)

**4- Telegram bot check**
https://t.me/gensyntrackbot
