from __future__ import print_function

import random
import os

print('Loading function')

thingsToSay = [
    "INVALID AUTHENTICATION ATTEMPT",
    "SUCCESSFUL AUTHENTICATION ATTEMPT",
    "USER LOGGED OUT",
    "USER WANTS A HAIRCUT"
]

def handler(event, context):

    print("Received request.")
    print(random.choice(thingsToSay))
