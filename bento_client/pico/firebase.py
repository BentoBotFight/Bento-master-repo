import network
import urequests
import ujson
import utime
from machine import Pin

# Wi-Fi Configuration
SSID = "MiraGalaxy"
PASSWORD = "24LIVINGMIRA3330!"

# Firebase Configuration
FIREBASE_URL = "https://testdev-1b344.firebaseio.com/"

# LED for status indication
led = Pin("LED", Pin.OUT)

def connect_wifi():
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    if not wlan.isconnected():
        print("Connecting to Wi-Fi...")
        wlan.connect(SSID, PASSWORD)
        while not wlan.isconnected():
            led.toggle()
            utime.sleep(0.5)
    print("Connected to Wi-Fi")
    led.on()

def read_firebase(path):
    url = FIREBASE_URL + path + ".json"
    try:
        response = urequests.get(url)
        if response.status_code == 200:
            data = ujson.loads(response.text)
            response.close()
            #print('data:', ujson.dumps(data))
            return data
        else:
            print("Error:", response.status_code)
            response.close()
    except Exception as e:
        print("Error:", e)
    return None

def main():
    connect_wifi()
    last_value = None
    
    while True:
        try:
            import gc
            gc.collect()
            
            current_value = read_firebase('pico/MyNumber')
            if current_value != last_value:
                print("New value:", current_value)
                last_value = current_value
            utime.sleep(0.1)
        except Exception as e:
            print("Error:", e)
            #utime.sleep(5)

if __name__ == "__main__":
    main()
