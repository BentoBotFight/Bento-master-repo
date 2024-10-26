import firebase_admin
from firebase_admin import db
from firebase_admin import credentials
import os
import subprocess
# Firebase configuration (not used in Python, typically used in JavaScript for web apps)
firebase_config = {
    "apiKey": "AIzaSyAwA_sGw2llj4-EsTiWnX-uyRcTY62V1BA",
    "authDomain": "comfyspace-73966.firebaseapp.com",
    "databaseURL": "https://comfyspace-73966-default-rtdb.firebaseio.com",
    "projectId": "comfyspace-73966",
    "storageBucket": "comfyspace-73966.appspot.com",
    "messagingSenderId": "290068007404",
    "appId": "1:290068007404:web:245d2347439be9093cd8c9",
    "measurementId": "G-GPMTL08R27"
}

def listen_to_database(firebase_config):
    # Initialize Firebase app (if not already initialized)
    if not firebase_admin._apps:
        cred = credentials.Certificate("comfyspace-73966-firebase-adminsdk-n34yj-7e5a6b2374.json")
        firebase_admin.initialize_app(
            cred, 
            {
            'databaseURL': firebase_config['databaseURL']
        })

    # Get a reference to the database
    database_ref = db.reference()

    # Specify the path to the data you want to listen to
    data_ref = database_ref.child('robot/cyclop')

    # Set up a listener for changes
    def on_data_change(event):
        # This callback will be triggered whenever the data changes
        data = event.data
        if data is not None:
            if isinstance(data, dict) and 'weapon' in data:
                print(data['weapon'])
                #os.system(f"{data['command']}")
                subprocess.run(data['weapon'], shell=True)                
            else:
                print(f'Data changed: {data}')
        else:
            print('No data available')

    # Add the listener
    data_ref.listen(on_data_change)

# Call the function to start listening
listen_to_database(firebase_config)

