# Run on 2 separate terminals

tmux new -s movement
source myenv/bin/activate
python realtime.py

tmux new -s weapon
source myenv/bin/activate
python realtime2.py