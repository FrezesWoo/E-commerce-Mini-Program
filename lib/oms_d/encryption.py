from base64 import b64encode, b64decode
from Crypto.Cipher import AES
# from Crypto.Util.Padding import pad
import sys


# Padding for the input string --not
# related to encryption itself.
BLOCK_SIZE = 16  # Bytes
pad = lambda s: s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * \
                chr(BLOCK_SIZE - len(s) % BLOCK_SIZE)
# pad = lambda s: bytes(s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * \
# chr(BLOCK_SIZE - len(s) % BLOCK_SIZE), 'utf-8')
unpad = lambda s: s[:-ord(s[len(s) - 1:])]

msg = sys.argv[1]


class AESCipher:
    """
    Usage:
        c = AESCipher('password').encrypt('message')
        m = AESCipher('password').decrypt(c)
    Tested under Python 3 and PyCrypto 2.6.1.
    """

    def __init__(self, key):
        self.key = key

    def encrypt(self, raw):
        raw = pad(raw)
        cipher = AES.new(self.key, AES.MODE_ECB)
        encrypted_data = b64encode(cipher.encrypt(raw))
        print (encrypted_data.decode('utf8'))
        return encrypted_data.decode('utf8')

    def decrypt(self, enc):
        enc = b64decode(enc)
        cipher = AES.new(self.key, AES.MODE_ECB)
        return unpad(cipher.decrypt(enc)).decode('utf8')

    def pad(self, text):
        length = 16
        count = len(text)
        if count < length:
            add = (length - count)
            # \0 backspace
            # text = text + ('\0' * add)
            text = text + ('\0' * add)
        elif count > length:
            add = (length - (count % length))
            # text = text + ('\0' * add)
            text = text + ('\0' * add)
        return text


##
# MAIN
# Just a test.
AESCipher('cpbmp_aes_abc123').encrypt(msg)
