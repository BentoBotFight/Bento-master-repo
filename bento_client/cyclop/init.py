import subprocess

subprocess.run('raspi-gpio set 5 op', shell=True)
subprocess.run('raspi-gpio set 6 op', shell=True)
subprocess.run('raspi-gpio set 22 op', shell=True)
subprocess.run('raspi-gpio set 27 op', shell=True)
subprocess.run('raspi-gpio set 20 op', shell=True)
subprocess.run('raspi-gpio set 21 op', shell=True)
