# import json
# from time import sleep
# from django.http import JsonResponse
# import urllib
# from django.shortcuts import render
# from httplib2 import Response
import requests
import pyrebase
#from datetime import date, timedelta,datetime,time
#from django.utils.timezone import datetime
# import firebase_admin
# from firebase_admin import credentials,firestore

#cred = credentials.Certificate("codeaware-125bf-firebase-adminsdk-si8jo-0c71ef0f16.json")
# firebase_admin.initialize_app(cred)
# db=firestore.client()


from apscheduler.schedulers.blocking import BlockingScheduler
sched = BlockingScheduler()
 
config={
    
    'apiKey': "AIzaSyDAxwLRHfi5Dzg6Uaix4CuYYt0Wl22LJag",
    'authDomain': "codeaware-125bf.firebaseapp.com",
    'databaseURL': "https://codeaware-125bf-default-rtdb.firebaseio.com",
    'projectId': "codeaware-125bf",
    'storageBucket': "codeaware-125bf.appspot.com",
    'messagingSenderId': "690245809991",
    'appId': "1:690245809991:web:82aa502b7b342405d57e62",
    'measurementId': "G-E8ZR7V5MPY"
}
# config={  
#   'apiKey': "AIzaSyCLscXyqA0KJCsUnebYEqn6TXLlA_HTc1g",
#   'authDomain': "sampleproject-ef4d0.firebaseapp.com",
#   'databaseURL': "https://sampleproject-ef4d0-default-rtdb.firebaseio.com",
#   'projectId': "sampleproject-ef4d0",
#   'storageBucket': "sampleproject-ef4d0.appspot.com",
#   'messagingSenderId': "863988637736",
#   'appId': "1:863988637736:web:25674b1d514d62e91b951d",
#   'measurementId': "G-ZL0TYCYTXP"
# }
firebase=pyrebase.initialize_app(config)
authe = firebase.auth()
database=firebase.database()
@sched.scheduled_job('interval', seconds=15) 
def home():
    
    # p=request.build_absolute_uri('https://competitive-coding-api.herokuapp.com/api/codechef/abhijeet_ar')
    # print(p)
    url='https://kontests.net/api/v1/codeforces'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        
        database.child('codeforces').child('data {}'.format(i)).set(dict)
        #db.collection(str(month)).document('codeforces').collection('data {}'.format(i)).add(dict)
    url='https://kontests.net/api/v1/top_coder'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('top_coder').child('data {}'.format(i)).set(dict)
        #db.collection(str(month)).document('codeforces').collection('data {}'.format(i)).add(dict)
    url='https://kontests.net/api/v1/code_chef'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('code_chef').child('data {}'.format(i)).set(dict)
        #db.collection(str(month)).document('code_chef').collection('data {}'.format(i)).add(dict)
    url='https://kontests.net/api/v1/leet_code'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('leet_code').child('data {}'.format(i)).set(dict)
    
    url='https://kontests.net/api/v1/at_coder'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('at_coder').child('data {}'.format(i)).set(dict)
    url='https://kontests.net/api/v1/kick_start'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('kick_start').child('data {}'.format(i)).set(dict)
    url='https://kontests.net/api/v1/hacker_earth'
    response = requests.get(url).json()
    l=len(response)
    print(l)
    # day = datetime.today().day
    # month=datetime.today().month
    # year=datetime.today().year
    
    for i in range(0,l): 
        name=response[i]
        dict=name
        print(dict)
        database.child('hacker_earth').child('data {}'.format(i)).set(dict)
    print('end')
    # t=0
    # con=['code_chef','leet_code','top_coder','codeforces','at_coder','kick_start','hacker_earth']
    # for o in con:
    #     val=database.child('current_month').child(o).get()
    #     print(o)
    #     for i  in val.each():
    #         if i.val()['in_24_hours']=='Yes':
    #             db.collection('previous_month').document(o).set(i.val())


        

        
        
           
           

                 #db.collection(str(month)).document('leet_code').collection('data {}'.format(i)).add(dict)
    
    # end_point = request.META.get('https://competitive-coding-api.herokuapp.com/api/codechef/abhijeet_ar', None)
    # print(end_point)
    # day = database.child('Data').child('Day').get().val()
    # id = database.child('Data').child('Id').get().val()
    # projectname = database.child('Data').child('Projectname').get().val()
    # print(day)
    #database.set(dict)

sched.start()


