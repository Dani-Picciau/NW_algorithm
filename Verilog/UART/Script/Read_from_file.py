import serial
import time

# Configurazione della porta seriale
ser = serial.Serial(
    port='COM11',       # Cambia con la porta corretta (es: 'COM3' su Windows o '/dev/ttyUSB0' su Linux)
    baudrate=9600,     # Baud rate configurato sulla tua scheda FPGA
    bytesize=serial.EIGHTBITS,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_ONE,
    timeout=1          # Timeout per le operazioni di I/O
)

# Percorso del file da cui leggere
file_path = r"C:\\Users\\crist\\Desktop\\ESD\\Progetto\\UART\\Script\\dati.txt"  # Modifica con il percorso corretto

try:
    # Apri il file in modalità lettura
    with open(file_path, "r") as file:
        string_to_send = file.read()  # Leggi il contenuto del file come stringa
        print(f"Stringa letta dal file: {string_to_send.strip()}")

    # Invia un carattere alla volta tramite UART
    for char in string_to_send:
        ser.write(char.encode())  # Invia il carattere codificato in byte
        print(f"Carattere inviato: {char}")
        time.sleep(0.01)  # Pausa breve (10 ms) tra i caratteri, se necessario

except FileNotFoundError:
    print(f"Errore: il file {file_path} non esiste.")
except serial.SerialException as e:
    print(f"Errore nella comunicazione seriale: {e}")
except Exception as e:
    print(f"Errore generico: {e}")

finally:
    ser.close()  # Chiudi la porta seriale quando hai finito
