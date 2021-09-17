sudo -S /usr/sbin/sshd
jupyter-lab --port 8888 --ip 0.0.0.0 --allow-root --notebook-dir=~/workspace --NotebookApp.token='' --no-browser &
mlflow server --host 0.0.0.0
tail -f /dev/null
