# DemoLTM
just for Networking Developing Demo

## Run the whiteboard from one computer on your LAN

1. Install Mosquitto and make sure `mosquitto.exe` is available on `PATH`. Install Python 3 with the `py` launcher.
2. On the computer that will host the app, run `start-server.bat`. It starts Mosquitto using `mosquitto.conf` and serves this folder over HTTP.
3. Allow Mosquitto and Python through Windows Firewall on **Private networks only**.
4. Open the LAN URL printed by the launcher (for example, `http://10.0.0.25:8080/`) on both computers. The page uses that host address for its MQTT WebSocket connection on port 9001.

The broker is configured for up to two anonymous LAN clients. This is suitable only for a trusted private network: do not port-forward ports 8080 or 9001 or expose this broker to the Internet. Mosquitto must support WebSockets.
