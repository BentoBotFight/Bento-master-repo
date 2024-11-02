import network
import utime
from machine import Pin
import ufirestore
from ufirestore.json import FirebaseJson

# Wi-Fi Configuration
SSID = "MiraGalaxy"
PASSWORD = "24LIVINGMIRA3330!"

# Firebase Configuration
PROJECT_ID = "testdev-1b344"
ACCESS_TOKEN = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImI4Y2FjOTViNGE1YWNkZTBiOTY1NzJkZWU4YzhjOTVlZWU0OGNjY2QiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY29tZnlzcGFjZS03Mzk2NiIsImF1ZCI6ImNvbWZ5c3BhY2UtNzM5NjYiLCJhdXRoX3RpbWUiOjE3MzA1OTA1ODksInVzZXJfaWQiOiJua21Vb1B2S0VzTWloUTBUN20wbDJmYmhWdHQyIiwic3ViIjoibmttVW9QdktFc01paFEwVDdtMGwyZmJoVnR0MiIsImlhdCI6MTczMDU5MDU4OSwiZXhwIjoxNzMwNTk0MTg5LCJlbWFpbCI6InRlc3RAYmVudG9ib3QudGVjaCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QGJlbnRvYm90LnRlY2giXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.fv15VGf4TU_reqOdTKhFYX8Ke_KPcVf0_z36OMbI_XgWPTD1vR61N9uU8_y4-8luH80Ue70GWG32w3iToYGfEkQ3I0awO3PpXrnoysMVb4fM1vURMVLbQPvABYSaPOZbZPy35OlZO0LVCzyBJrUw6meccfQEhlFieFN0umXw_Ks1N7_bC0PsGxCgLgNvUpkBeuKfui9biUygjDqymM45fdn9LAmD63zoGHZYH5c85r192TnKscuCPAyLbl7k71S5wi2o6NYnuoUMRP3RLy3-9FZd0sn4fiXWDEDSS_ANy6jvfIRr4-3Mlh4UGo0pTQ4id_MAN_k7ReRzAbr4e_NOtw"  # You need to obtain this

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

def setup_firebase():
    ufirestore.set_project_id(PROJECT_ID)
    ufirestore.set_access_token(ACCESS_TOKEN)

def read_firebase(path):
    try:
        raw_doc = ufirestore.get(path, bg=False)
        doc = FirebaseJson.from_raw(raw_doc)
        if doc.exists("fields/value"):
            return doc.get("fields/value")
        else:
            print("Value field not found in document")
            return None
    except Exception as e:
        print("Error reading from Firebase:", e)
        return None

def main():
    connect_wifi()
    setup_firebase()
    last_value = None
    
    while True:
        try:
            current_value = read_firebase("pico/MyNumber")
            if current_value != last_value:
                print("New value:", current_value)
                last_value = current_value
            utime.sleep(0.1)  # Small delay to reduce load
        except Exception as e:
            print("Error:", e)
            utime.sleep(1)

if __name__ == "__main__":
    main()
