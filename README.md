sudo apt install -y git & wait
sudo rm -f /Scripts_tmp & wait
sudo git clone https://github.com/AlgoClaw/Bash /Scripts_tmp & wait
sudo cp -RT /Scripts_tmp /Scripts & wait
sudo rm -f /Scripts_tmp & wait
sudo cp -RT /Scripts/fcns /Scripts & wait
sudo rm -f /Scripts/fcns & wait
sudo bash /Scripts/FinalizeScripts.sh
